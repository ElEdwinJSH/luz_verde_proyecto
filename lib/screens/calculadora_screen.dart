import 'package:flutter/material.dart';
import 'package:luz_verde_proyecto/providers/list_carga_electrica.dart';
import '../widgets/carga_item.dart';
import 'package:provider/provider.dart';

class CalculadoraScreen extends StatefulWidget {
  const CalculadoraScreen({super.key});

  @override
  _CalculadoraScreenState createState() => _CalculadoraScreenState();
}

class _CalculadoraScreenState extends State<CalculadoraScreen> {
  @override
  Widget build(BuildContext context) {
    final cargas = Provider.of<ListCargaElectricaProvider>(context);

    double cargaTotal = 0.0;

    // Calcular la carga total
    for (var carga in cargas.items) {
      cargaTotal += carga.energiaDia;
    }

    return Scaffold(
      appBar: AppBar(title: Text('Luz Verde'), backgroundColor: Colors.green),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cargas.items.length,
              itemBuilder: (ctx, index) {
                return CargaItem(cargas.items[index]);
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
                Navigator.of(context).pushNamed('/agregar_dispositivo');
              },
              child: Text('Agregar Dispositivo'),
            ),
          ),
        ],
      ),
    );
  }
/*
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
  */
}
