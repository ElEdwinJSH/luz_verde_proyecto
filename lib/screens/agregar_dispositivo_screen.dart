import 'package:flutter/material.dart';
import '../models/carga.dart';
import 'package:luz_verde_proyecto/models/database.dart';

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
    return Scaffold(
      appBar: AppBar(
          title: Text('Agregar Dispositivo'), backgroundColor: Colors.green),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _elementoController,
              decoration: InputDecoration(labelText: 'Elemento'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, ingrese un elemento';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _cantidadController,
              decoration: InputDecoration(labelText: 'Cantidad'),
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
              decoration: InputDecoration(labelText: 'Potencia (Watts)'),
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
              decoration: InputDecoration(labelText: 'Horas al día'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, ingrese las horas al día';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () async {
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
                  final id =
                      await DatabaseHelper.instance.insertCargas(nuevaCarga);

                  Navigator.of(context).pop(nuevaCarga);
                }
              },
              child: Text('Guardar'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
