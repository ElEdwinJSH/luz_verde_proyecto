import 'package:flutter/material.dart';
import 'package:luz_verde_proyecto/models/database.dart';

class ListaDispositivoScreen extends StatefulWidget {
  const ListaDispositivoScreen({super.key});

  @override
  State<ListaDispositivoScreen> createState() => _ListaDispositivoScreenState();
}

class _ListaDispositivoScreenState extends State<ListaDispositivoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de dispositivos'),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseHelper.instance
            .getCargas(), // Reemplaza con tu propio método de consulta
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final items = snapshot.data;

            return ListView.builder(
              itemCount: items?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items![index].toString()),
                  onTap: () {
                    // Acción a realizar cuando se hace clic en un elemento de la lista
                    // Por ejemplo, puedes navegar a una pantalla de detalles o ejecutar alguna otra acción.
                    print('Elemento seleccionado: ${items[index]}');
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
