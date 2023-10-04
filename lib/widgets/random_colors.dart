import 'dart:math';
import 'package:flutter/material.dart';

randomColor() {
  return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
}
