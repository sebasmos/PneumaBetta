import 'package:flutter/material.dart';
import 'package:pneumapp/constant.dart';

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  RoundedSelectField createState() => 
  RoundedSelectField();
}

class RoundedSelectField extends State<MyStatefulWidget> {
  String dropdownValue = 'Seleccione una opción';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      dropdownColor: kPrimaryColor,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['Seleccione una opción', 'Hombre', 'Mujer', 'Otro']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}