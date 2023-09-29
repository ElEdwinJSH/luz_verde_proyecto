import 'package:flutter/material.dart';
import '../models/carga.dart';

class CargaItem extends StatelessWidget {
  final CargaElectrica carga;

  CargaItem(this.carga);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(carga.elemento),
      subtitle: Text('Cantidad: ${carga.cantidad}'),
      trailing: Text('Energía/día: ${carga.energiaDia.toStringAsFixed(2)} kWh'),
    );
  }
}
