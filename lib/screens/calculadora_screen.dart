import 'package:flutter/material.dart';
import 'package:luz_verde_proyecto/providers/change_theme_provider.dart';
import 'package:luz_verde_proyecto/providers/list_carga_electrica.dart';
import '../widgets/carga_item.dart';
import 'package:provider/provider.dart';
import '../widgets/nav_drawer.dart';
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
            title: const Text('Luz Verde'),
            actions: [],
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
            drawerTheme: DrawerThemeData(backgroundColor: Colors.black54),
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
            drawerTheme: DrawerThemeData(backgroundColor: Colors.white),
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
}
