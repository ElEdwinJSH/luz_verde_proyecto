import 'package:flutter/material.dart';
import 'package:luz_verde_proyecto/screens/lista_dispositivo_screen.dart';
import '../screens/calculadora_screen.dart';
import '../screens/agregar_dispositivo_screen.dart';
import 'package:luz_verde_proyecto/providers/list_carga_electrica.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ListCargaElectricaProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const CalculadoraScreen(),
          '/agregar_dispositivo': (context) => const AgregarDispositivoScreen(),
          '/lista_dispositivo': (context) => const ListaDispositivoScreen(),
        },
      ),
    );
  }
}
