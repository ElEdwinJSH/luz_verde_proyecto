import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luz_verde_proyecto/widgets/splash_screen.dart';
import 'providers/change_theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChangeTheme()),
      ],
      child: Builder(builder: (context) {
        final changeTheme = Provider.of<ChangeTheme>(context);
        changeTheme.isdarktheme;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Luz Verde',
          theme: changeTheme.isdarktheme
              ? ThemeData(
                  useMaterial3: true,
                  appBarTheme:
                      AppBarTheme(backgroundColor: Colors.green.shade900),
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: Colors.white,
                    brightness: Brightness.dark,
                  ),
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
                ),
          /* theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),*/
          home: const SplashScreen(),
        );
      }),
    );
  }
  /**/
}
