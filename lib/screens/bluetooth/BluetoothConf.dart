import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:scoped_model/scoped_model.dart';

import './DiscoveryPage.dart';
import './SelectBondedDevicePage.dart';
import './BackgroundCollectingTask.dart';
import './BackgroundCollectedVisor.dart';

class BluetoothConf extends StatefulWidget {
  @override
  _BluetoothConf createState() => new _BluetoothConf();
}

class _BluetoothConf extends State<BluetoothConf> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  Timer _discoverableTimeoutTimer;

  BackgroundCollectingTask _collectingTask;

  @override
  void initState() {
    super.initState();

    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    Future.doWhile(() async {
      // Wait if adapter not enabled
      if (await FlutterBluetoothSerial.instance.isEnabled) {
        return false;
      }
      await Future.delayed(Duration(milliseconds: 0xDD));
      return true;
    }).then((_) {
      // Update the address field
    });

    // Listen for futher state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;

        // Discoverable mode is disabled when Bluetooth gets disabled
        _discoverableTimeoutTimer = null;
      });
    });
  }

  @override
  void dispose() {
    FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
    _collectingTask?.dispose();
    _discoverableTimeoutTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Bluetooth Serial'),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.settings_bluetooth),
              textColor: Colors.white,
              label: Text("Settings"),
              onPressed: () {
                FlutterBluetoothSerial.instance.openSettings();
              },
            )
          ],
        ),
        body: Container(
          child: ListView(children: <Widget>[
            SwitchListTile(
              title: const Text('Enable Bluetooth'),
              value: _bluetoothState.isEnabled,
              onChanged: (bool value) {
                // Do the request and update with the true value then
                future() async {
                  // async lambda seems to not working
                  if (value)
                    await FlutterBluetoothSerial.instance.requestEnable();
                  else
                    await FlutterBluetoothSerial.instance.requestDisable();
                }

                future().then((_) {
                  setState(() {});
                });
              },
            ),
            Divider(),
            ListTile(title: const Text('Devices discovery and connection')),
            ListTile(
              title: RaisedButton(
                  child: const Text('Explore discovered devices'),
                  onPressed: () async {
                    final BluetoothDevice selectedDevice =
                        await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return DiscoveryPage();
                        },
                      ),
                    );

                    if (selectedDevice != null) {
                      print('Discovery -> selected ' + selectedDevice.address);
                    } else {
                      print('Discovery -> no device selected');
                    }
                  }),
            ),
            ListTile(
              title: RaisedButton(
                child: ((_collectingTask != null && _collectingTask.inProgress)
                    ? const Text('Disconnect and stop background collecting')
                    : const Text('Connect to start background collecting')),
                onPressed: () async {
                  if (_collectingTask != null && _collectingTask.inProgress) {
                    await _collectingTask.cancel();
                    setState(() {
                      /* Update for `_collectingTask.inProgress` */
                    });
                  } else {
                    final BluetoothDevice selectedDevice =
                        await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return SelectBondedDevicePage(
                              checkAvailability: false);
                        },
                      ),
                    );

                    if (selectedDevice != null) {
                      await _startBackgroundTask(context, selectedDevice);
                      setState(() {
                        /* Update for `_collectingTask.inProgress` */
                      });
                    }
                  }
                },
              ),
            ),
            (_collectingTask != null) ? ScopedModel<BackgroundCollectingTask>(
              model: _collectingTask,
              child: BackgroundCollectedVisor(),
            ) :
            Container(/* Dummy */)
          ]),
        ));
  }

  Future<void> _startBackgroundTask(
    BuildContext context,
    BluetoothDevice server,
  ) async {
    try {
      _collectingTask = await BackgroundCollectingTask.connect(server);
      await _collectingTask.start();
    } catch (ex) {
      if (_collectingTask != null) {
        _collectingTask.cancel();
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error occured while connecting'),
            content: Text("${ex.toString()}"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
