import 'package:flutter/material.dart';
import 'package:pneumapp/services/auth.dart';
import 'package:pneumapp/screens/authenticate/signin.dart';
import 'package:pneumapp/screens/Components/rounded_input_field.dart';
import 'package:pneumapp/screens/Components/rounded_password_field.dart';
import 'package:pneumapp/screens/Components/rounded_select_field.dart';
import 'package:pneumapp/screens/Components/rounded_button.dart';
import 'package:pneumapp/screens/Components/already_have_an_account_acheck.dart';
import 'package:pneumapp/screens/Components/or_divider.dart';

class Register extends StatefulWidget {
  // We are passing the toggleView property through authenticate.dart file itself as a param,
  // therefore it must be passed as a widget instead of a state
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // Text field state
  String nombre = '';
  String apellido = '';
  String sexo = '';
  String cedula = '';
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/LOGOFINAL.png',
          fit: BoxFit.cover,
          height: 30.0,
        ),
        centerTitle: true,
      ),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Registro",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: size.height * 0.03),
                  RoundedInputField(
                    hintText: "Nombres",
                    onChanged: (value) {
                      setState(() => nombre = value);
                    },
                  ),
                  RoundedInputField(
                    hintText: "Apellidos",
                    onChanged: (value) {
                      setState(() => apellido = value);
                    },
                  ),
                  MyStatefulWidget(
                      //hintText: "Genero",
                      //onChanged: (value) {},
                      ),
                  RoundedInputField(
                    hintText: "Cedula",
                    onChanged: (value) {
                      setState(() => cedula = value);
                    },
                  ),
                  RoundedInputField(
                    hintText: "Correo electronico",
                    onChanged: (value) {
                      setState(() => email = value);
                    },
                  ),
                  RoundedPasswordField(
                    onChanged: (value) {
                      setState(() => password = value);
                    },
                  ),
                  RoundedButton(
                    text: "Registro",
                    press: () async {
                      // use keyform to validate form
                      if (_formKey.currentState.validate()) {
                        dynamic result =
                            await _auth.registerEmailPassword(email, password);
                        if (result == null) {
                          setState(() => error =
                              'Correo incorrecto, porfavor ingresar un correo valido');
                        }
                      }
                    },
                  ),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    login: false,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SignIn();
                          },
                        ),
                      );
                    },
                  ),
                  OrDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      /*SocalIcon(
                      iconSrc: "assets/icons/facebook.svg",
                      press: () {},
                    ),
                    SocalIcon(
                      iconSrc: "assets/icons/twitter.svg",
                      press: () {},
                    ),
                    SocalIcon(
                      iconSrc: "assets/icons/google-plus.svg",
                      press: () {},
                    ),*/
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
