import 'package:flutter/material.dart';
import 'package:luz_verde_proyecto/screens/editar_dispositivo.dart';
import '../models/carga.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:luz_verde_proyecto/providers/list_carga_electrica.dart';
import 'package:luz_verde_proyecto/providers/change_theme_provider.dart';

class CargaItem extends StatelessWidget {
  final CargaElectrica carga;

  const CargaItem(this.carga, {super.key});

  @override
  Widget build(BuildContext context) {
    final cargas = Provider.of<ListCargaElectricaProvider>(context);
    final changeTheme = Provider.of<ChangeTheme>(context);

    return Slidable(
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: (context) => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Eliminar'),
                content: const Text('¿Estas seguro?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancelar'),
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () =>
                        {cargas.removeCargas(carga), Navigator.pop(context)},
                    child: const Text('Si'),
                  )
                ],
              ),
            ),

            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Eliminar',
            //cargas.removeCargas(carga)
          ),
          SlidableAction(
            onPressed: (context) {
              // Navegar a la pantalla de edición de dispositivos
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      EditarDispositivos(cargaElectrica: carga),
                ),
              );
            },
            backgroundColor: const Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Editar',
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          carga.elemento,
          style: TextStyle(
            color: changeTheme.isdarktheme ? Colors.white : Colors.black,
          ),
        ),
        subtitle: Text(
          'Cantidad: ${carga.cantidad}',
          style: TextStyle(
            color: changeTheme.isdarktheme ? Colors.white : Colors.black,
          ),
        ),
        trailing: Text(
          'Energía/día: ${carga.energiaDia.toStringAsFixed(2)} kWh',
          style: TextStyle(
            color: changeTheme.isdarktheme ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
