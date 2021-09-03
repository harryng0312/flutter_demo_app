import 'package:flutter/material.dart';

const kTitle = 'Provider';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Text(
                kTitle,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headline6!.fontSize,
                  color: Colors.white,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.teal,
            ),
          ),
          getListTile('Home', onTap: () {
            Navigator.pushReplacementNamed(context, '/');
          }),
          getLine(),
          getListTile('About', onTap: () {
            Navigator.pushReplacementNamed(context, '/about');
          }),
          getLine(),
          getListTile('Settings', onTap: () {
            Navigator.pushReplacementNamed(context, '/settings');
          }),
        ],
      ),
    );
  }

  Widget getLine() {
    return SizedBox(
      height: 0.5,
      child: Container(
        color: Colors.grey,
      ),
    );
  }

  Widget getListTile(title, {void Function()? onTap}) {
    return ListTile(
      title: Text(title),
      onTap: onTap,
    );
  }
}