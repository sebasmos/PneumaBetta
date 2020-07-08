import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:pneumapp/config/palette.dart';
import 'package:pneumapp/config/styles.dart';
import 'package:pneumapp/data/data.dart';
import 'package:pneumapp/widgets/widgets.dart';
import 'package:pneumapp/services/auth.dart';

import 'dart:async';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:scoped_model/scoped_model.dart';

import './bluetooth/DiscoveryPage.dart';
import './bluetooth/SelectBondedDevicePage.dart';
import './bluetooth/BackgroundCollectingTask.dart';
import './bluetooth/BackgroundCollectedVisor.dart';

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  final AuthService _auth = AuthService();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      appBar: CustomAppBar(),
      drawer: new Drawer(
          child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: new Text(
              "David Santiago Garcia Chicangana",
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            accountEmail: new Text("dsgarcia@unicauca.edu.co"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://static.iris.net.co/semana/upload/images/2020/6/1/675397_1.jpg"),
            ),
            decoration: new BoxDecoration(color: Colors.blue[700]),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Perfil"),
          ),
          ListTile(
            leading: Icon(Icons.help_outline),
            title: Text("Ayuda"),
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text("Mis ventiladores"),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("Información"),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Salir"),
            onTap: () async {
              await _auth.signOutService();
            },
          ),
        ],
      )),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          _buildHeader(),
          _buildRegionTabBar(),
          _buildStatsTabBar(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            sliver: SliverToBoxAdapter(
              child: StatsGrid(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 20.0),
            sliver: SliverToBoxAdapter(
                child: (_collectingTask != null)
                    ? ScopedModel<BackgroundCollectingTask>(
                        model: _collectingTask,
                        child: BackgroundCollectedVisor(),
                      )
                    : Container(/* Dummy */)),
          ),
        ],
      ),
    );
  }

  SliverPadding _buildHeader() {
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          'Realtime',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildRegionTabBar() {
    return SliverToBoxAdapter(
      child: DefaultTabController(
        length: 2,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: TabBar(
            indicator: BubbleTabIndicator(
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
              indicatorHeight: 40.0,
              indicatorColor: Colors.white,
            ),
            labelStyle: Styles.tabTextStyle,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            tabs: <Widget>[
              Text(
                  'Off'), //TODO: onInit initial tab should be 0 or 1 according to _bluetoothState.isEnabled
              Text('On'),
            ],
            onTap: (index) {
              // Do the request and update with the true value then
              future() async {
                // async lambda seems to not working
                if (index == 1)
                  await FlutterBluetoothSerial.instance.requestEnable();
                else
                  await FlutterBluetoothSerial.instance.requestDisable();
              }

              future().then((_) {
                setState(() {});
              });
            },
          ),
        ),
      ),
    );
  }

  SliverPadding _buildStatsTabBar() {
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: DefaultTabController(
          length: 3,
          child: TabBar(
            indicatorColor: Colors.transparent,
            labelStyle: Styles.tabTextStyle,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            tabs: <Widget>[
              Text('Settings'),
              Text('Explore'),
              (_bluetoothState.isEnabled)
                  ? (_collectingTask != null && _collectingTask.inProgress)
                      ? const Text('Disconnect')
                      : const Text('Connect')
                  : Container(/* Dummy */),
            ],
            onTap: (index) async {
              switch (index) {
                case 0:
                  FlutterBluetoothSerial.instance.openSettings();
                  break;
                case 1:
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
                  break;
                case 2:
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
                  break;
              }
            },
          ),
        ),
      ),
    );
  }
}
