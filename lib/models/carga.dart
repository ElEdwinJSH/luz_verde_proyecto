// models/carga.dart

class CargaElectrica {
  String elemento;
  int cantidad;
  int potencia;
  double horasAlDia;
  double energiaDia;

  CargaElectrica({
    required this.elemento,
    required this.cantidad,
    required this.potencia,
    required this.horasAlDia,
    required this.energiaDia,
  });

  Map<String, dynamic> toMap() {
    return {
      'elemento': elemento,
      'cantidad': cantidad,
      'potencia': potencia,
      'horasAlDia': horasAlDia,
      'energiaDia': energiaDia
    };
  }
}
