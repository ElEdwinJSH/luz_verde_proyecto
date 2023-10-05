import 'package:flutter/material.dart';
import 'package:luz_verde_proyecto/models/carga.dart';
import 'package:luz_verde_proyecto/models/database.dart';
import 'package:luz_verde_proyecto/providers/change_theme_provider.dart';
import 'package:luz_verde_proyecto/providers/list_carga_electrica.dart';
import 'package:provider/provider.dart';

class EditarDispositivos extends StatefulWidget {
  final CargaElectrica cargaElectrica;

  EditarDispositivos({required this.cargaElectrica});

  @override
  _EditarDispositivosState createState() => _EditarDispositivosState();
}

class _EditarDispositivosState extends State<EditarDispositivos> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _elementoController;
  late TextEditingController _cantidadController;
  late TextEditingController _potenciaController;
  late TextEditingController _horasAlDiaController;

  @override
  void initState() {
    super.initState();
    _elementoController =
        TextEditingController(text: widget.cargaElectrica.elemento);
    _cantidadController =
        TextEditingController(text: widget.cargaElectrica.cantidad.toString());
    _potenciaController =
        TextEditingController(text: widget.cargaElectrica.potencia.toString());
    _horasAlDiaController = TextEditingController(
        text: widget.cargaElectrica.horasAlDia.toString());
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
    final cargas = Provider.of<ListCargaElectricaProvider>(context);
    final changeTheme = Provider.of<ChangeTheme>(context);

    return Theme(
        data: themeSetter(changeTheme),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Editar Dispositivo'),
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                TextFormField(
                  controller: _elementoController,
                  decoration: const InputDecoration(labelText: 'Elemento'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, ingrese un elemento';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _cantidadController,
                  decoration: const InputDecoration(labelText: 'Cantidad'),
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
                  decoration:
                      const InputDecoration(labelText: 'Potencia (Watts)'),
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
                  decoration: const InputDecoration(labelText: 'Horas al día'),
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
                      final horasAlDia =
                          double.parse(_horasAlDiaController.text);
                      final energiaDia = (potencia * horasAlDia) / 1000;

                      final cargaActualizada = CargaElectrica(
                        elemento: widget.cargaElectrica.elemento,
                        cantidad: cantidad,
                        potencia: potencia,
                        horasAlDia: horasAlDia,
                        energiaDia: energiaDia,
                      );

                      await DatabaseHelper.instance
                          .updateCargas(cargaActualizada);

                      cargas.updateCargas(cargaActualizada);
                      Navigator.of(context).pop(cargaActualizada);
                    }
                  },
                  child: const Text('Guardar Cambios'),
                ),
              ],
            ),
          ),
        ));
  }
}

//cambia el tema
themeSetter(changeTheme) {
  return changeTheme.isdarktheme
      ? ThemeData(
          useMaterial3: true,
          appBarTheme: AppBarTheme(backgroundColor: Colors.green.shade900),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.white,
            brightness: Brightness.dark,
            background: Colors.grey.shade900,
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
              backgroundColor: Color.fromARGB(255, 64, 167, 67),
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
            background: Colors.grey.shade200,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 64, 167, 67)),
              foregroundColor: MaterialStateProperty.all(
                const Color.fromARGB(228, 241, 241, 241),
              ),
            ),
          ),
        );
}
