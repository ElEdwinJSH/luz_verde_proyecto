import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:luz_verde_proyecto/models/carga.dart';
import 'package:luz_verde_proyecto/providers/change_theme_provider.dart';
import 'package:luz_verde_proyecto/providers/list_carga_electrica.dart';
import 'package:luz_verde_proyecto/widgets/app_colors.dart';
import 'package:luz_verde_proyecto/widgets/indicators.dart';
import 'package:luz_verde_proyecto/widgets/random_colors.dart';
import 'package:provider/provider.dart';

class GraficasCargas extends StatelessWidget {
  const GraficasCargas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cargas = Provider.of<ListCargaElectricaProvider>(context);
    final List<CargaElectrica> sectors = cargas.items;
    final changeTheme = Provider.of<ChangeTheme>(context);

    return Theme(
      data: themeSetter(changeTheme),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Gráficas'),
          //backgroundColor: Colors.green
        ),
        body: Column(
          children: [
            AspectRatio(
                aspectRatio: 1.0,
                child: PieChart(PieChartData(
                  sections: _chartSections(sectors),
                  centerSpaceRadius: 48.0,
                ))),
            const Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Indicator(
                  color: AppColors.contentColorBlue,
                  text: 'First',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: AppColors.contentColorYellow,
                  text: 'Second',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: AppColors.contentColorPurple,
                  text: 'Third',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: AppColors.contentColorGreen,
                  text: 'Fourth',
                  isSquare: true,
                ),
                SizedBox(
                  height: 18,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _chartSections(List<CargaElectrica> sectors) {
    final List<PieChartSectionData> list = [];
    for (var sector in sectors) {
      const double radius = 40.0;
      final data = PieChartSectionData(
        color: randomColor(),
        value: sector.energiaDia,
        radius: radius,
        title: sector.elemento,
        titleStyle: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            shadows: [
              Shadow(
                  // bottomLeft
                  offset: Offset(-1.5, -1.5),
                  color: Colors.white),
              Shadow(
                  // bottomRight
                  offset: Offset(1.5, -1.5),
                  color: Colors.white),
              Shadow(
                  // topRight
                  offset: Offset(1.5, 1.5),
                  color: Colors.white),
              Shadow(
                  // topLeft
                  offset: Offset(-1.5, 1.5),
                  color: Colors.white),
            ]),
      );

      list.add(data);
    }
    return list;
  }
}

themeSetter(changeTheme) {
  return changeTheme.isdarktheme
      ? ThemeData(
          useMaterial3: true,
          appBarTheme: AppBarTheme(backgroundColor: Colors.green.shade900),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.white,
            brightness: Brightness.dark,
          ),
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
