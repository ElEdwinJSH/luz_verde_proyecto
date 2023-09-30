import 'package:flutter/material.dart';
import 'package:luz_verde_proyecto/screens/lista_dispositivo_screen.dart';
import '../screens/calculadora_screen.dart';
import '../screens/agregar_dispositivo_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (ctx) => CalculadoraScreen(),
        '/agregar_dispositivo': (ctx) => AgregarDispositivoScreen(),
        '/lista_dispositivo': (ctx) => ListaDispositivoScreen(),
      },
    );
  }
}
