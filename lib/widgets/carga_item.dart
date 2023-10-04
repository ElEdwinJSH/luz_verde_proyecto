import 'package:flutter/material.dart';
import '../models/carga.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:luz_verde_proyecto/providers/list_carga_electrica.dart';

class CargaItem extends StatelessWidget {
  final CargaElectrica carga;

  const CargaItem(this.carga, {super.key});

  @override
  Widget build(BuildContext context) {
    final cargas = Provider.of<ListCargaElectricaProvider>(context);

    return Slidable(
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const BehindMotion(),

        // A pane can dismiss the Slidable.

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: (context) => cargas.removeCargas(carga),
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Eliminar',
          ),
          SlidableAction(
            onPressed: (context) => 1,
            backgroundColor: const Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Editar',
          ),
        ],
      ),
      child: ListTile(
        title: Text(carga.elemento),
        subtitle: Text('Cantidad: ${carga.cantidad}'),
        trailing:
            Text('Energía/día: ${carga.energiaDia.toStringAsFixed(2)} kWh'),
      ),
    );
  }
}
