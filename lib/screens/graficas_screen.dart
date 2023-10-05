import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luz_verde_proyecto/models/carga.dart';
import 'package:luz_verde_proyecto/providers/change_theme_provider.dart';
import 'package:luz_verde_proyecto/providers/list_carga_electrica.dart';
import 'package:luz_verde_proyecto/widgets/indicators.dart';
import 'package:luz_verde_proyecto/widgets/random_colors.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

class GraficasCargas extends StatelessWidget {
  const GraficasCargas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cargas = Provider.of<ListCargaElectricaProvider>(context);
    final List<CargaElectrica> sectors = cargas.items;
    final changeTheme = Provider.of<ChangeTheme>(context);
    final List<Color> colores =
        List.generate(sectors.length, (int x) => randomColor());
    return Theme(
      data: themeSetter(changeTheme),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Gráficas',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          //backgroundColor: Colors.green
        ),
        body: Column(
          children: [
            AspectRatio(
                aspectRatio: 1.0,
                child: PieChart(PieChartData(
                  sections: _chartSections(sectors, colores),
                  centerSpaceRadius: 48.0,
                ))),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: getList(sectors, colores),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _chartSections(
      List<CargaElectrica> sectors, colores) {
    final List<PieChartSectionData> list = [];

    double max = 0;
    for (var element in sectors) {
      max += element.energiaDia;
    }

    int index = 0;
    for (var sector in sectors) {
      const double radius = 40.0;
      final data = PieChartSectionData(
        color: colores[index],
        value: sector.energiaDia,
        radius: radius,
        title: '${(sector.energiaDia / max * 100).toStringAsFixed(2)}%',
        titleStyle: const TextStyle(
            fontSize: 20,
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
      index++;
      list.add(data);
    }
    return list;
  }
}

List<Widget> getList(List<CargaElectrica> sectors, colores) {
  List<Widget> childs = [];
  int index = 0;

  for (var sector in sectors) {
    childs.add(Indicator(
      color: colores[index],
      text: '${sector.elemento}: ${sector.energiaDia}kWh',
      isSquare: true,
    ));
    childs.add(
      const SizedBox(
        height: 4,
      ),
    );
    index++;
  }

  return childs;
}

themeSetter(changeTheme) {
  return changeTheme.isdarktheme
      ? ThemeData(
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.green.shade900,
            systemOverlayStyle: SystemUiOverlayStyle(
              systemNavigationBarColor: Colors.grey.shade900, // Navigation bar
              statusBarColor: Colors.green.shade900, // Status bar
            ),
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.white,
            brightness: Brightness.dark,
            background: Colors.grey.shade900,
          ),
          drawerTheme: DrawerThemeData(backgroundColor: Colors.grey.shade900),
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
          appBarTheme: AppBarTheme(
              backgroundColor: Color.fromARGB(255, 57, 143, 60),
              systemOverlayStyle: SystemUiOverlayStyle(
                systemNavigationBarColor:
                    Colors.grey.shade300, // Navigation bar
                statusBarColor: Color.fromARGB(255, 57, 143, 60), // Status bar
              ),
              titleTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 22,
              )),
          iconButtonTheme: const IconButtonThemeData(
              style: ButtonStyle(
                  iconColor: MaterialStatePropertyAll(Colors.white))),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.white,
            brightness: Brightness.light,
            background: Colors.grey.shade300,
          ),
          drawerTheme: DrawerThemeData(backgroundColor: Colors.grey.shade200),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Color.fromARGB(255, 64, 167, 67)),
              foregroundColor: MaterialStateProperty.all(
                const Color.fromARGB(228, 241, 241, 241),
              ),
            ),
          ),
        );
}
