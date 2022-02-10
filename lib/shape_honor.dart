import 'package:flutter/material.dart';

class ShapeHonor extends CustomPainter{
  @override
  paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    var path = Path();
    path.moveTo(0, size.height /2);
    path.quadraticBezierTo(20, -20, 20, -20);

    path.lineTo(size.width, size.height / 2);

    canvas.drawPath(path, paint);
  }



  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
   return true;
  }

}