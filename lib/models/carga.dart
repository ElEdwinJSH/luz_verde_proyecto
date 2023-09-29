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
}
