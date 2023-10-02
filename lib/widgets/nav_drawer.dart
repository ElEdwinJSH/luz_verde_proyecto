import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
                //color: Colors.green,
                /* image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/cover.jpg'),
              ),*/
                ),
            child: Text(
              'Opciones',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dark_mode_sharp),
            title: Text('Modo oscuro'),
            onTap: () => {},
          ),
        ],
      ),
    );
  }
}
