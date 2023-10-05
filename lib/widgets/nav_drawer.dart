import 'package:flutter/material.dart';
import 'package:luz_verde_proyecto/providers/change_theme_provider.dart';
import 'package:luz_verde_proyecto/providers/list_carga_electrica.dart';
import 'package:luz_verde_proyecto/screens/graficas_screen.dart';
import 'package:provider/provider.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final cargas = Provider.of<ListCargaElectricaProvider>(context);
    final changeTheme = Provider.of<ChangeTheme>(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: changeTheme.isdarktheme
                  ? Colors.green.shade900
                  : Colors.green.shade700,
              /*image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/cover.jpg'),
              ), */
            ),
            child: const Text(
              'Opciones',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Icon(changeTheme.isdarktheme
                ? Icons.wb_sunny
                : Icons.dark_mode_sharp),
            title: Text(
              changeTheme.isdarktheme
                  ? 'Activar Modo Claro'
                  : 'Activar Modo Oscuro',
            ),
            textColor: changeTheme.isdarktheme ? Colors.white : Colors.black,
            onTap: () => {
              changeTheme.isdarktheme = !changeTheme.isdarktheme,
              themeSetter(changeTheme)
            },
          ),
          ListTile(
            leading: const Icon(Icons.pie_chart),
            title: const Text('Gráficas'),
            textColor: changeTheme.isdarktheme ? Colors.white : Colors.black,
            enabled: cargas.items.isNotEmpty,
            onTap: () {
              Navigator.of(context).pushNamed('/graficas');
            },
          )
        ],
      ),
    );
  }
}
