import 'package:flutter/material.dart';
import 'package:pneumapp/services/auth.dart';

class Home extends StatelessWidget {

  final AuthService _auth =AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(color: Colors.blue),
        title:Image.asset(
                'assets/logo.jpeg',
                fit: BoxFit.cover,
                height: 30.0,
              ),
        centerTitle: true,
        actions: <Widget>[
           FlatButton.icon(
              icon: Icon(Icons.person),              
              label: Text("Loggout"),
              onPressed: ()async{
                await _auth.signOutService();
              },
             )
        ],
      ),
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
                backgroundImage: NetworkImage("https://a.wattpad.com/cover/124081801-352-k598788.jpg"),
              ),
              decoration: new BoxDecoration(color: Colors.blue[700]),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Perfil"),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("Información"),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Salir"),
            ),
          ],
        )
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(30),
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            MyMenu(title: "Perfil", icon: Icons.supervised_user_circle, background: Colors.purple),
            MyMenu(title: "Señales", icon: Icons.supervised_user_circle, background: Colors.yellow),
            MyMenu(title: "Prediccion Covid-19", icon: Icons.graphic_eq, background: Colors.lightBlue),
            MyMenu(title: "Chatbot", icon: Icons.chat, background: Colors.pink),
            MyMenu(title: "Opcion x", icon: Icons.headset_off, background: Colors.orange),
            MyMenu(title: "Opcion y", icon: Icons.insert_photo, background: Colors.blue),
          ],
        ),
      ),
    );
  }
}

class MyMenu extends StatelessWidget {
  MyMenu({this.title, this.icon, this.background});
  
  final String title;
  final IconData icon;
  final MaterialColor background;

  @override
  Widget build(BuildContext context) {
    return Card(
            color: background,
            child: InkWell(
              onTap: (){},
              splashColor: Colors.green,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      icon,
                      size: 70.0,
                      color: Colors.white,
                    ),
                    Text(
                      title,
                      style: new TextStyle(fontSize: 17.0,color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
