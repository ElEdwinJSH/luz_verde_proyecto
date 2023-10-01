import 'package:flutter/foundation.dart';
import 'package:luz_verde_proyecto/models/carga.dart';

class ListCargaElectricaProvider extends ChangeNotifier {
  final List<CargaElectrica> _cargas = [];
  List<CargaElectrica> get items => _cargas;

  void addCargas(CargaElectrica newCarga) {
    _cargas.add(newCarga);
    notifyListeners(); // Notifica a los oyentes que la lista ha cambiado
  }

  void removeCargas(CargaElectrica carga) {
    _cargas.remove(carga);
    notifyListeners();
  }

  void updateCargas(CargaElectrica cargaActualizada) {
    final index = _cargas
        .indexWhere((element) => element.elemento == cargaActualizada.elemento);
    if (index != -1) {
      _cargas[index] = cargaActualizada;
      notifyListeners();
    }
  }
}
