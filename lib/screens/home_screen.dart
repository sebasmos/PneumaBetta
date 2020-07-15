import 'package:flutter/material.dart';
import 'package:pneumapp/config/palette.dart';
import 'package:pneumapp/config/styles.dart';
import 'package:pneumapp/data/data.dart';
import 'package:pneumapp/models/user.dart';
import 'package:pneumapp/shared/loading.dart';
import 'package:pneumapp/widgets/widgets.dart';
import 'package:pneumapp/widgets/custom_app_bar.dart';
import 'package:pneumapp/services/auth.dart';
import 'package:pneumapp/services/databases.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _todoName = "Mostrar datos";
  String _country = 'USA';
  final AuthService _auth = AuthService();
  

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final user = Provider.of<User>(context);
    return StreamBuilder(
        stream: Firestore.instance.collection('user_data').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Text("Cargando datos..");
        return Scaffold(

          appBar: CustomAppBar(),

          drawer: new Drawer(
              child: ListView(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: new Text(
                      snapshot.data.documents[0]['nombres'],
                      style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    accountEmail: new Text("dsgarcia@unicauca.edu.co"),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage("https://static.iris.net.co/semana/upload/images/2020/6/1/675397_1.jpg"),
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
                    onTap: ()async{
                      await _auth.signOutService();
                    },
                  ),
                ],
              )
          ),
          body: CustomScrollView(
            physics: ClampingScrollPhysics(),
            slivers: <Widget>[
              _buildHeader(screenHeight),
              _buildPreventionTips(screenHeight),
              _buildYourOwnTest(screenHeight),
            ],
          ),

        );
      }
    );


  }

  SliverToBoxAdapter _buildHeader(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Palette.primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CountryDropdown(
                  countries: ['CN', 'FR', 'IN', 'IT', 'UK', 'USA'],
                  country: _country,
                  onChanged: (val) => setState(() => _country = val),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '¿Tienes alguna urgencia medica?',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'Llámanos si tienes problemas para conectar tu ventilador o tus síntomas son graves, de lo contrario revisa la sección de FAQs',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton.icon(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                      onPressed: () async{
                    //    await _auth.signOutService();
                     },
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      icon: const Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Llamar ahora',
                        style: Styles.buttonTextStyle,
                      ),
                      textColor: Colors.white,
                    ),
                    FlatButton.icon(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                      onPressed: () {},
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      icon: const Icon(
                        Icons.chat_bubble,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Enviar mensaje',
                        style: Styles.buttonTextStyle,
                      ),
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildPreventionTips(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'En caso de emergencia',
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: prevention
                  .map((e) => Column(
                        children: <Widget>[
                          Image.asset(
                            e.keys.first,
                            height: screenHeight * 0.12,
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          Text(
                            e.values.first,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildYourOwnTest(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
        padding: const EdgeInsets.all(10.0),
        height: screenHeight * 0.15,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFAD9FE4), Palette.primaryColor],
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Image.asset('assets/images/own_test.png'),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Sigue las recomendaciones',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'Datos confidenciales',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                  maxLines: 2,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
