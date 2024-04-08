import 'package:flutter/material.dart';

class Mood {
  static Icon mood(int emotion, double size, {Color? color}) {
    if (emotion == 1) {
      return Icon(
        Icons.sentiment_dissatisfied_outlined,
        color: color ?? Colors.red,
        size: size,
      );
    } else if (emotion == 2) {
      return Icon(
        Icons.sentiment_neutral_outlined,
        color: color ?? Colors.amber.shade600,
        size: size,
      );
    } else {
      return Icon(
        Icons.sentiment_satisfied_outlined,
        color: color ?? Colors.green.shade800,
        size: size,
      );
    }
  }
}
