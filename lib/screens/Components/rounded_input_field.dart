import 'package:flutter/material.dart';
import 'package:pneumapp/screens/components/text_field_container.dart';
import 'package:pneumapp/constant.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final bool _validate = false;

  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          /*icon: Icon(
            icon,
            color: kPrimaryColor,
          ),*/
          hintText: hintText,
          border: InputBorder.none,
          errorText: _validate ? 'Value Can\'t Be Empty' : null,
        ),
      ),
    );
  }
}
