import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:luz_verde_proyecto/providers/change_theme_provider.dart';
import 'package:luz_verde_proyecto/providers/list_carga_electrica.dart';
import '../widgets/carga_item.dart';
import 'package:provider/provider.dart';
import '../widgets/widgets.dart';

class CalculadoraScreen extends StatefulWidget {
  const CalculadoraScreen({Key? key}) : super(key: key);

  @override
  _CalculadoraScreenState createState() => _CalculadoraScreenState();
}

class _CalculadoraScreenState extends State<CalculadoraScreen> {
  @override
  Widget build(BuildContext context) {
    final cargas = Provider.of<ListCargaElectricaProvider>(context);
    final changeTheme = Provider.of<ChangeTheme>(context);
    double cargaTotal = 0.0;

    // Calcular la carga total
    for (var carga in cargas.items) {
      cargaTotal += carga.energiaDia;
    }

    return Theme(
        data: themeSetter(changeTheme),
        child: Scaffold(
          drawer: const NavDrawer(),
          appBar: AppBar(
            title: Text('Luz Verde'),
            actions: [
              IconButton(
                icon: const Icon(Icons.dark_mode),
                tooltip: 'Open shopping cart',
                onPressed: () {
                  changeTheme.isdarktheme = !changeTheme.isdarktheme;
                  themeSetter(changeTheme);
                },
              )
            ],
            //backgroundColor: Colors.green
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cargas.items.length,
                  itemBuilder: (ctx, index) {
                    return CargaItem(cargas.items[index]);
                  },
                ),
              ),
              ListTile(
                title:
                    Text('Carga Total: ${cargaTotal.toStringAsFixed(2)} kWh'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  /* style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),*/
                  onPressed: () {
                    Navigator.of(context).pushNamed('/agregar_dispositivo');
                  },
                  child: Text('Agregar Dispositivo'),
                ),
              ),
            ],
          ),
        ));
  }

//cambia el tema
  themeSetter(changeTheme) {
    return changeTheme.isdarktheme
        ? ThemeData(
            useMaterial3: true,
            appBarTheme: AppBarTheme(backgroundColor: Colors.green.shade900),
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.white,
              brightness: Brightness.dark,
            ),
            drawerTheme: DrawerThemeData(backgroundColor: Colors.white),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.green.shade900),
                foregroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(228, 241, 241, 241),
                ),
              ),
            ),
          )
        : ThemeData(
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.green,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                )),
            drawerTheme: const DrawerThemeData(backgroundColor: Colors.white),
            iconButtonTheme: const IconButtonThemeData(
                style: ButtonStyle(
                    iconColor: MaterialStatePropertyAll(Colors.white))),
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.white,
              brightness: Brightness.light,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
                foregroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(228, 241, 241, 241),
                ),
              ),
            ),
          );
  }
/*
  // Función para agregar un dispositivWo
  void _agregarDispositivo(BuildContext context) async {
    final result =
        await Navigator.of(context).pushNamed('/agregar_dispositivo');
    if (result != null) {
      setState(() {
        cargas.add(result as CargaElectrica);
      });
    }
  }

  void _eliminarDispositivo(int index) {
    setState(() {
      cargas.removeAt(index);
    });
  }
  */
}

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final changeTheme = Provider.of<ChangeTheme>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
                color: changeTheme.isdarktheme
                    ? Colors.green.shade900
                    : Colors.green
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
