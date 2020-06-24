import 'package:flutter/material.dart';
import 'package:pneumapp/services/auth.dart';

class Home extends StatelessWidget {

  final AuthService _auth =AuthService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      
        appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(color: Color.fromRGBO(29, 100, 154,1)),
        title:Image.asset(
                'assets/LOGOFINAL.png',
                fit: BoxFit.cover,
                height: 30.0,
              ),
        centerTitle: true,

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
                backgroundImage: NetworkImage("https://static.iris.net.co/semana/upload/images/2020/6/1/675397_1.jpg"),
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
              onTap: ()async{
                await _auth.signOutService();
              },
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
        padding: EdgeInsets.all(40),
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            MyMenu(title: "Perfil", icon: Icons.supervised_user_circle, background: Colors.purple,cardID: "1"),
            MyMenu(title: "Señales", icon: Icons.supervised_user_circle, background: Colors.yellow, cardID: "2"),
            MyMenu(title: "Prediccion Covid-19", icon: Icons.graphic_eq, background: Colors.lightBlue, cardID: "3"),
            MyMenu(title: "Chatbot", icon: Icons.chat, background: Colors.pink, cardID: "4"),
            MyMenu(title: "Opcion x", icon: Icons.headset_off, background: Colors.orange, cardID: "5"),
            MyMenu(title: "Opcion y", icon: Icons.insert_photo, background: Colors.blue,cardID: "6"),
          ],
        ),
      ),
    );
  }
}

class MyMenu extends StatelessWidget {
  MyMenu({this.title, this.icon, this.background, this.cardID});
  
  final String title;
  final IconData icon;
  final MaterialColor background;
  final String cardID;
  

  @override
  Widget build(BuildContext context) {
    return Card(
            color: background,
            child: InkWell(
              onTap: () => {
                 
              if (cardID == "1"){
              print("Signals card has been pressed then you clicked on Profile") 

              } else if(cardID == "2"){
              print("Signals card has been pressed then you clicked on Signals")
                
              } else if(cardID == "3"){
              print("Signals card has been pressed then you clicked on Prediction Covid 19")
              }
                else {
                print("Signals card has been pressed then you clicked on OTHER")}
              },
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
