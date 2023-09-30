import 'package:flutter/material.dart';
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
      },
    );
  }
}
