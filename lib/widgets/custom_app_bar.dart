import 'package:flutter/material.dart';
import 'package:pneumapp/services/auth.dart';
import 'package:pneumapp/config/palette.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {

  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Palette.primaryColor,
      elevation: 0.0,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.notifications_none),
          iconSize: 28.0,
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
