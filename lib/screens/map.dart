import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:pneumapp/config/palette.dart';
import 'package:pneumapp/config/styles.dart';
import 'package:pneumapp/data/data.dart';
import 'package:pneumapp/widgets/widgets.dart';
import 'package:pneumapp/services/auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final AuthService _auth = AuthService();
  GoogleMapController mapController;
  final LatLng _center = const LatLng(2.441455, -76.604950);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
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
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
      ),
    );
  }

  SliverPadding _buildHeader() {
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          'Statistics',
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
              Text('My Country'),
              Text('Global'),
            ],
            onTap: (index) {},
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
              Text('Total'),
              Text('Today'),
              Text('Yesterday'),
            ],
            onTap: (index) {},
          ),
        ),
      ),
    );
  }
}
