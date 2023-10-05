import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:luz_verde_proyecto/providers/change_theme_provider.dart';
import 'package:luz_verde_proyecto/providers/list_carga_electrica.dart';
import 'package:luz_verde_proyecto/screens/agregar_dispositivo_screen.dart';

import '../widgets/carga_item.dart';
import 'package:provider/provider.dart';
import '../widgets/widgets.dart';

String mesSeleccionado = "Enero";

class CalculadoraScreen extends StatefulWidget {
  const CalculadoraScreen({Key? key}) : super(key: key);

  @override
  _CalculadoraScreenState createState() => _CalculadoraScreenState();
}

class _CalculadoraScreenState extends State<CalculadoraScreen> {
  @override
  Widget build(BuildContext context) {
    //providers
    final cargas = Provider.of<ListCargaElectricaProvider>(context);
    final changeTheme = Provider.of<ChangeTheme>(context);

    //cargas
    double cargaDiaria = 0.0;
    for (var carga in cargas.items) {
      cargaDiaria += carga.energiaDia;
    }

    //json

    Map lista = jsonDecode('''{
  "Basico": {
    "Enero": "0.945",
    "Febrero": "0.951",
    "Marzo": "0.957",
    "Abril": "0.963",
    "Mayo": "0.969",
    "Junio": "0.975",
    "Julio": "0.981",
    "Agosto": "0.987",
    "Septiembre": "0.993",
    "Octubre": "0.999",
    "Noviembre": "1.005",
    "Diciembre": "1.011"
  },
  "Intermedio": {
    "Enero": "1.153",
    "Febrero": "1.16",
    "Marzo": "1.167",
    "Abril": "1.174",
    "Mayo": "1.181",
    "Junio": "1.188",
    "Julio": "1.195",
    "Agosto": "1.203",
    "Septiembre": "1.211",
    "Octubre": "1.219",
    "Noviembre": "1.227",
    "Diciembre": "1.235"
  },
  "Excedente": {
    "Enero": "3.367",
    "Febrero": "3.388",
    "Marzo": "3.409",
    "Abril": "3.43",
    "Mayo": "3.452",
    "Junio": "3.474",
    "Julio": "3.496",
    "Agosto": "3.518",
    "Septiembre": "3.54",
    "Octubre": "3.562",
    "Noviembre": "3.584",
    "Diciembre": "3.607"
  }
}
''');

    final List<String> meses = <String>[
      'Enero',
      'Febrero',
      'Marzo',
      'Abril',
      'Mayo',
      'Junio',
      'Julio',
      'Agosto',
      'Septiembre',
      'Octubre',
      'Noviembre',
      'Diciembre',
    ];

    final Map<String, int> duracionMeses = {
      'Enero': 31,
      'Febrero': 28, // Se asume 28 días para febrero en un año no bisiesto
      'Marzo': 31,
      'Abril': 30,
      'Mayo': 31,
      'Junio': 30,
      'Julio': 31,
      'Agosto': 31,
      'Septiembre': 30,
      'Octubre': 31,
      'Noviembre': 30,
      'Diciembre': 31,
    };
    //tarifas
    int tarifaStatus;
    String mensajeConsumo;

    double cargaMensual = cargaDiaria * duracionMeses[mesSeleccionado]!;

    if (cargaMensual >= 141) {
      tarifaStatus = 3;
      mensajeConsumo = "Excedente";
    } else if (cargaMensual >= 76) {
      tarifaStatus = 2;
      mensajeConsumo = "Intermedio";
    } else {
      tarifaStatus = 1;
      mensajeConsumo = "Basico";
    }

    double costoDiario =
        cargaDiaria * double.parse(lista[mensajeConsumo][mesSeleccionado]!);
    double costoMensual =
        cargaMensual * double.parse(lista[mensajeConsumo][mesSeleccionado]!);
    //

    return Theme(
        data: themeSetter(changeTheme),
        child: Scaffold(
          drawer: const NavDrawer(),
          appBar: AppBar(
            title: Text("Luz Verde"),
            actions: [
              DropdownButton<String>(
                  value: mesSeleccionado,
                  onChanged: (mes) {
                    setState(() {
                      mesSeleccionado = mes!;
                    });
                  },
                  selectedItemBuilder: (BuildContext context) {
                    return meses.map((String value) {
                      return Center(
                        child: Text(
                          mesSeleccionado,
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 16),
                        ),
                      );
                    }).toList();
                  },
                  items: meses.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList()),
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
              DataTable(
                dividerThickness: 0,
                dataRowMinHeight: 40,
                dataRowMaxHeight: 40,
                columns: const [
                  DataColumn(label: Text('')),
                  DataColumn(label: Text('')),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text('Consumo Electrico Diario')),
                    DataCell(Text('${cargaDiaria.toStringAsFixed(2)} kWh')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Consumo Electrico Mensual')),
                    DataCell(Text('${cargaMensual.toStringAsFixed(2)} kWh')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Costo Diario')),
                    DataCell(Text('\$ ${costoDiario.toStringAsFixed(2)}')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Costo Mensual')),
                    DataCell(Text('\$ ${costoMensual.toStringAsFixed(2)}')),
                  ]),
                  DataRow(
                    color: MaterialStateProperty.all(
                      (tarifaStatus == 1)
                          ? Colors.green
                          : (tarifaStatus) == 2
                              ? Colors.deepOrange
                              : Colors.red,
                    ),

                    //for data row color
                    cells: <DataCell>[
                      DataCell(Text('Consumo')),
                      DataCell(Text(mensajeConsumo)),
                    ],
                  ),
                ],
              ),
              /*ListTile(
                subtitle: Text(
                    'Energía Total: ${cargaDiaria.toStringAsFixed(2)} kWh \nEnergía Mensual: ${(cargaDiaria * 30).toStringAsFixed(2)} kWh'),
              ),*/

              /*ListTile(
                textColor: (tarifaStatus == 1)
                    ? Colors.green
                    : (tarifaStatus) == 2
                        ? Colors.yellow
                        : Colors.red,
                title: (tarifaStatus == 1)
                    ? const Text("Básico")
                    : (tarifaStatus) == 2
                        ? const Text("Intermedio")
                        : const Text("Excedente"),
              ),*/
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: ElevatedButton(
                  /* style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),*/
                  onPressed: () {
                    Navigator.of(context).pushNamed('/agregar_dispositivo');
                  },
                  child: const Text('Agregar Dispositivo'),
                ),
              ),
            ],
          ),
        ));
  }
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
                  : Colors.green,
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
        ],
      ),
    );
  }
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
          drawerTheme: const DrawerThemeData(backgroundColor: Colors.black54),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green.shade900),
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
