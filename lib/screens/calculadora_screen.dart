import 'package:flutter/material.dart';
import '../models/carga.dart';
import '../widgets/carga_item.dart';

class CalculadoraScreen extends StatefulWidget {
  @override
  _CalculadoraScreenState createState() => _CalculadoraScreenState();
}

class _CalculadoraScreenState extends State<CalculadoraScreen> {
  final List<CargaElectrica> cargas = [];

  @override
  Widget build(BuildContext context) {
    double cargaTotal = 0.0;

    // Calcular la carga total
    for (var carga in cargas) {
      cargaTotal += carga.energiaDia;
    }

    return Scaffold(
      appBar: AppBar(title: Text('Luz Verde'), backgroundColor: Colors.green),
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
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                        ),
                        onPressed: () {
                          _eliminarDispositivo(index);
                        },
                        child: Text('ti'),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          ListTile(
            title: Text('Carga Total: ${cargaTotal.toStringAsFixed(2)} kWh'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              onPressed: () {
                _agregarDispositivo(context);
              },
              child: Text('Agregar Dispositivo'),
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
