import 'package:luz_verde_proyecto/providers/theme.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import '../models/carga.dart';
import '../widgets/carga_item.dart';
import 'package:luz_verde_proyecto/models/theme_preferences.dart';
import 'package:flutter/material.dart';
import 'package:luz_verde_proyecto/screens/graficas_screen.dart';
import 'package:luz_verde_proyecto/screens/lista_dispositivo_screen.dart';

import '../screens/calculadora_screen.dart';
import '../screens/agregar_dispositivo_screen.dart';
import 'package:luz_verde_proyecto/providers/list_carga_electrica.dart';
import 'package:provider/provider.dart';

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
          '/graficas': (context) => const GraficasCargas()
        },
      ),
    );
  }

  // Función para agregar un dispositivo
}
