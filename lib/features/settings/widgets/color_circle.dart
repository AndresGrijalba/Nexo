import 'dart:ui';

import 'package:flutter/material.dart';

class DiagonalColorCircle extends StatelessWidget {
  final Color mainColor;
  final Color backgroundColor;
  final double size;

  const DiagonalColorCircle({
    super.key,
    required this.mainColor,
    required this.backgroundColor,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _DiagonalCirclePainter(
        mainColor: mainColor,
        backgroundColor: backgroundColor,
      ),
    );
  }
}

class _DiagonalCirclePainter extends CustomPainter {
  final Color mainColor;
  final Color backgroundColor;

  _DiagonalCirclePainter({required this.mainColor, required this.backgroundColor});

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    final center = size.center(Offset.zero);
    final paint = Paint()..style = PaintingStyle.fill;
    paint.color = backgroundColor;
    canvas.drawCircle(center, radius, paint);
    paint.color = mainColor;
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(0, size.height)
      ..close();

    canvas.clipPath(Path()..addOval(Rect.fromCircle(center: center, radius: radius)));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
