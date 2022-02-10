import 'package:flutter/material.dart';

class ShapeLip extends CustomPainter {
  final double valueY;
  const  ShapeLip({required this.valueY});
  @override
  void paint(Canvas canvas, Size size) {

    var paint = Paint()
      ..color = Colors.pink
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    var path = Path();

    path.moveTo(0, size.height / 2);
    path.quadraticBezierTo(size.width / 2, valueY, size.width, size.height / 2);


    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate
      ) {
    return true;
  }

}