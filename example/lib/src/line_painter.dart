import 'package:flutter/material.dart';

class LinePainter extends CustomPainter {
  const LinePainter({
    required this.firstOffset,
    required this.secondOffset,
  });

  final Offset firstOffset;
  final Offset secondOffset;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black;
    canvas.drawLine(firstOffset, secondOffset, paint);
  }

  @override
  bool shouldRepaint(oldDelegate) => false;
}
