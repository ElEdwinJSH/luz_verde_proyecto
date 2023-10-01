import 'package:flutter/material.dart';
import '../models/carga.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:luz_verde_proyecto/providers/theme.dart';
import 'package:provider/provider.dart';

class CargaItem extends StatelessWidget {
  final CargaElectrica carga;

  const CargaItem(this.carga, {super.key});

  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeProvider>(context);
    return Slidable(
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: (context) => 1,
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: (context) => 1,
            backgroundColor: const Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.share,
            label: 'Share',
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          carga.elemento,
          style: TextStyle(
            color: currentTheme.isDarkTheme() ? Colors.white : Colors.black,
          ),
        ),
        subtitle: Text(
          'Cantidad: ${carga.cantidad}',
          style: TextStyle(
            color: currentTheme.isDarkTheme() ? Colors.white : Colors.black,
          ),
        ),
        trailing: Text(
          'Energía/día: ${carga.energiaDia.toStringAsFixed(2)} kWh',
          style: TextStyle(
            color: currentTheme.isDarkTheme() ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
