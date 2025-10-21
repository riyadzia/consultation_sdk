import 'package:flutter/material.dart';

class RipplePainter extends CustomPainter {
  final double progress;
  final Color color;
  final int startAngle;
  final int sweepAngle;

  RipplePainter(this.progress,this.color,{this.startAngle = 2,this.sweepAngle = 2});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color.withValues(alpha: 1 - progress) // Fading effect
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final Offset center = Offset(size.width / 2, size.height / 2);
    final double maxRadius = size.width / 2;

    // Draw multiple arcs/ripples expanding outward
    for (int i = 1; i <= 2; i++) {
      double radius = maxRadius * (progress + (i * 0.3)) % maxRadius;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -3.14 / startAngle, // Start angle at the top
        3.14 / sweepAngle,  // Sweep angle for top half
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}