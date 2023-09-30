import 'dart:async';
import 'package:flutter/material.dart';

import 'package:luz_verde_proyecto/screens/home_screen.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    //En esta zona creamos el _controller, donde ponemos la ubicacion del splashScreen
    super.initState();

    _controller =
        VideoPlayerController.asset('assets/animations/FinalSplashScreen.mp4')
          ..initialize().then((_) {
            //en el initialize, escribe _controller.play para que se reproduzca el video,
            _controller.play();

            Timer(const Duration(seconds: 2), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  //aqui al terminar el video nos redirije a la pantalla home
                  builder: (context) => const HomeScreen(),
                ),
              );
            });

            setState(() {});
          });
  }

  @override
  Widget build(BuildContext context) {
    //aqui se hizo lo de centrar el video a la mitad de la pantalla
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 233, 232, 232),
        body: Center(
          child: content(),
        ));
  }

  Widget content() {
    //aqui se pusieron las dimensiones del video
    return Stack(
      children: [
        SizedBox(
          child: FittedBox(
            fit: BoxFit.cover,
            child: Container(
              alignment: Alignment.center,
              width: 1200,
              height: 1200,
              child: VideoPlayer(_controller),
            ),
          ),
        )
      ],
    );
  }
}
