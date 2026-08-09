// lib/widgets/gradient_button.dart
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const GradientButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final gradient = LinearGradient(colors: [Colors.indigo, Colors.purpleAccent]);
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.black26,
      ).copyWith(elevation: MaterialStateProperty.all(4)),
      child: Ink(
        decoration: BoxDecoration(gradient: gradient, borderRadius: BorderRadius.circular(12)),
        child: Container(
          alignment: Alignment.center,
          child: Text(label, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}
