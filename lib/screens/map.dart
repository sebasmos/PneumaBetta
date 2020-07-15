import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:pneumapp/config/palette.dart';
import 'package:pneumapp/config/styles.dart';
import 'package:pneumapp/widgets/widgets.dart';
import 'package:pneumapp/services/auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<Marker> allMarkers = [];
  final AuthService _auth = AuthService();
  GoogleMapController mapController;
  Widget _child;
  LatLng _center = LatLng(2.441455, -76.604950);
  Position position;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    position = new Position();
    //Añadiendo manualmente los hospitales
    allMarkers.add(
      Marker(
          markerId: MarkerId("timbio_hospital"),
          draggable: false,
          onTap: () {
            print("Marker Tapped");
          },
          infoWindow: InfoWindow(title: "Hospital Timbío E.S.E "),
          position: LatLng(2.354474, -76.685870)),
    );
    allMarkers.add(
      Marker(
          markerId: MarkerId("popayan_susana_lopez"),
          draggable: false,
          onTap: () {
            print("Marker Tapped");
          },
          infoWindow:
              InfoWindow(title: "Hospital Susana López de Valencia E.S.E."),
          position: LatLng(2.437406, -76.619241)),
    );
    allMarkers.add(
      Marker(
          markerId: MarkerId("popayan_hospital_universitario"),
          draggable: false,
          onTap: () {
            print("Marker Tapped");
          },
          infoWindow:
              InfoWindow(title: "Hospital Universitario San Jose Popayan"),
          position: LatLng(2.450681, -76.596828)),
    );
    allMarkers.add(
      Marker(
          markerId: MarkerId("popayan_casa_rosada"),
          draggable: false,
          onTap: () {
            print("Marker Tapped");
          },
          infoWindow: InfoWindow(title: "Casa Rosada - E.S.E. Popayán"),
          position: LatLng(2.443891, -76.612943)),
    );

    getCurrentLocation();
    super.initState();
  }

  void getCurrentLocation() async {
    Position res = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      position = res;
      _center = LatLng(position.latitude, position.longitude);
    });
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
        myLocationEnabled: true,
        mapType: MapType.normal,
        rotateGesturesEnabled: false,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 12.0,
        ),
        markers: Set.from(allMarkers),
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
