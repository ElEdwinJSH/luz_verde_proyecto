import 'package:luz_verde_proyecto/models/theme_preferences.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import '../models/carga.dart';
import '../widgets/carga_item.dart';
import 'package:luz_verde_proyecto/models/theme_preferences.dart';
import 'package:flutter/material.dart';
import 'package:luz_verde_proyecto/providers/theme.dart';
import '../screens/calculadora_screen.dart';
import '../screens/agregar_dispositivo_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ThemeProvider themeChangeProvider = ThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.setTheme =
        await themeChangeProvider.themePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: themeChangeProvider,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (ctx) => const CalculadorScreen(),
            '/agregar_dispositivo': (ctx) => AgregarDispositivoScreen(),
          },
        ));
  }
}

class CalculadorScreen extends StatefulWidget {
  const CalculadorScreen({super.key});

  @override
  State<CalculadorScreen> createState() => _CalculadorScreenState();
}

class _CalculadorScreenState extends State<CalculadorScreen> {
  final List<CargaElectrica> cargas = [];

  @override
  Widget build(BuildContext context) {
    double cargaTotal = 0.0;

    // Calcular la carga total
    for (var carga in cargas) {
      cargaTotal += carga.energiaDia;
    }

    final currentTheme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: currentTheme.isDarkTheme()
          ? Color.fromARGB(255, 86, 85, 106)
          : Colors.white,
      appBar: AppBar(
        title: Text(
          'Luz Verde',
          style: TextStyle(
            color: currentTheme.isDarkTheme()
                ? Color.fromARGB(179, 250, 249, 249)
                : Colors.white,
          ),
        ),
        backgroundColor: currentTheme.isDarkTheme()
            ? Colors.green.shade900
            : Colors.green.shade600,
        actions: [
          Switch(
              value: currentTheme.isDarkTheme(),
              onChanged: (value) {
                String newTheme =
                    value ? ThemePreference.dark : ThemePreference.light;
                currentTheme.setTheme = newTheme;
              }),
          Icon(
            currentTheme.isDarkTheme()
                ? Icons.nightlight_round
                : Icons.wb_sunny,
            color: currentTheme.isDarkTheme() ? Colors.white : Colors.black,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cargas.length,
              itemBuilder: (ctx, index) {
                return Row(
                  children: [
                    Expanded(child: CargaItem(cargas[index])),
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              currentTheme.isDarkTheme()
                                  ? Colors.green.shade900
                                  : Colors.green.shade600),
                        ),
                        onPressed: () {
                          _eliminarDispositivo(index);
                        },
                        child: Text(
                          'Eliminar',
                          style: TextStyle(
                            color: currentTheme.isDarkTheme()
                                ? Color.fromARGB(179, 250, 249, 249)
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          ListTile(
            title: Text(
              'Carga Total: ${cargaTotal.toStringAsFixed(2)} kWh',
              style: TextStyle(
                color: currentTheme.isDarkTheme() ? Colors.white : Colors.black,
                // Cambia los colores según tu preferencia
              ),
            ),
            /* tileColor: currentTheme.isDarkTheme()
                ? Color.fromARGB(255, 86, 85, 106)
                : Colors.white,
            style: ListTileStyle
                .list,*/ // Aquí puedes usar un estilo predefinido, como ListTileStyle.list
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    currentTheme.isDarkTheme()
                        ? Colors.green.shade900
                        : Colors.green.shade600),
              ),
              onPressed: () {
                _agregarDispositivo(context);
              },
              child: Text(
                'Agregar Dispositivo',
                style: TextStyle(
                  color: currentTheme.isDarkTheme()
                      ? Color.fromARGB(179, 250, 249, 249)
                      : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Función para agregar un dispositivo
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
}
