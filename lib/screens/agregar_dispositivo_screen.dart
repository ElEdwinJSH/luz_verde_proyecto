import 'package:flutter/material.dart';
import 'package:luz_verde_proyecto/providers/theme.dart';
import 'package:provider/provider.dart';
import '../models/carga.dart';

class AgregarDispositivoScreen extends StatefulWidget {
  @override
  _AgregarDispositivoScreenState createState() =>
      _AgregarDispositivoScreenState();
}

class _AgregarDispositivoScreenState extends State<AgregarDispositivoScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _elementoController;
  late TextEditingController _cantidadController;
  late TextEditingController _potenciaController;
  late TextEditingController _horasAlDiaController;

  @override
  void initState() {
    super.initState();
    _elementoController = TextEditingController();
    _cantidadController = TextEditingController();
    _potenciaController = TextEditingController();
    _horasAlDiaController = TextEditingController();
  }

  @override
  void dispose() {
    _elementoController.dispose();
    _cantidadController.dispose();
    _potenciaController.dispose();
    _horasAlDiaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: currentTheme.isDarkTheme()
          ? Color.fromARGB(255, 86, 85, 106)
          : Colors.white,
      appBar: AppBar(
        title: Text('Agregar Dispositivo'),
        backgroundColor: currentTheme.isDarkTheme()
            ? Colors.green.shade900
            : Colors.green.shade600,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _elementoController,
              decoration: InputDecoration(
                labelText: 'Elemento',
                labelStyle: TextStyle(
                  color: currentTheme.isDarkTheme()
                      ? Color.fromARGB(255, 196, 196, 196)
                      : Color.fromARGB(255, 94, 94, 94),
                  // Cambia los colores según tu preferencia
                ),
              ),
              style: TextStyle(
                color: currentTheme.isDarkTheme() ? Colors.white : Colors.black,
                // Cambia los colores según tu preferencia
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, ingrese un elemento';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _cantidadController,
              decoration: InputDecoration(
                labelText: 'Cantidad',
                labelStyle: TextStyle(
                  color: currentTheme.isDarkTheme()
                      ? Color.fromARGB(255, 196, 196, 196)
                      : Color.fromARGB(255, 94, 94, 94),
                  // Cambia los colores según tu preferencia
                ),
              ),
              style: TextStyle(
                color: currentTheme.isDarkTheme() ? Colors.white : Colors.black,
                // Cambia los colores según tu preferencia
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, ingrese la cantidad';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _potenciaController,
              decoration: InputDecoration(
                labelText: 'Potencia (Watts)',
                labelStyle: TextStyle(
                  color: currentTheme.isDarkTheme()
                      ? Color.fromARGB(255, 196, 196, 196)
                      : Color.fromARGB(255, 94, 94, 94),
                  // Cambia los colores según tu preferencia
                ),
              ),
              style: TextStyle(
                color: currentTheme.isDarkTheme() ? Colors.white : Colors.black,
                // Cambia los colores según tu preferencia
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, ingrese la potencia';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _horasAlDiaController,
              decoration: InputDecoration(
                labelText: 'Horas al día',
                labelStyle: TextStyle(
                  color: currentTheme.isDarkTheme()
                      ? Color.fromARGB(255, 196, 196, 196)
                      : Color.fromARGB(255, 94, 94, 94),
                  // Cambia los colores según tu preferencia
                ),
              ),
              style: TextStyle(
                color: currentTheme.isDarkTheme() ? Colors.white : Colors.black,
                // Cambia los colores según tu preferencia
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, ingrese las horas al día';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final elemento = _elementoController.text;
                  final cantidad = int.parse(_cantidadController.text);
                  final potencia = int.parse(_potenciaController.text);
                  final horasAlDia = double.parse(_horasAlDiaController.text);
                  final energiaDia =
                      (potencia * horasAlDia) / 1000; // Convertir a kWh
                  final nuevaCarga = CargaElectrica(
                    elemento: elemento,
                    cantidad: cantidad,
                    potencia: potencia,
                    horasAlDia: horasAlDia,
                    energiaDia: energiaDia,
                  );
                  Navigator.of(context).pop(nuevaCarga);
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    currentTheme.isDarkTheme()
                        ? Colors.green.shade900
                        : Colors.green.shade600),
              ),
              child: Text(
                'Guardar',
                style: TextStyle(
                  color: currentTheme.isDarkTheme()
                      ? Color.fromARGB(179, 250, 249, 249)
                      : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
