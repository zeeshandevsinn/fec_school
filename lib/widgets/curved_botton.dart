import 'dart:math';

import 'package:flutter/material.dart';

class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final roundingHeight = size.height * 2 / 2;

    final filledRectangle =
        Rect.fromLTRB(0, 0, size.width, size.height - roundingHeight);

    final roundingRectangle = Rect.fromLTRB(
        -120, size.height - roundingHeight * 2, size.width, size.height);

    final path = Path();
    path.addRect(filledRectangle);

    path.arcTo(roundingRectangle, pi, -pi, true);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class CurvedBottomClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final roundingHeight = size.height * 2 / 3;

    final filledRectangle =
        Rect.fromLTRB(0, 0, size.width, size.height - roundingHeight);

    final roundingRectangle = Rect.fromLTRB(-85,
        size.height - roundingHeight * 2, size.width + 10, size.height - 13);

    final path = Path();
    path.addRect(filledRectangle);

    path.arcTo(roundingRectangle, pi, -pi, true);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class CurvedBottomClipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final roundingHeight = size.height * 6 / 2;

    final filledRectangle =
        Rect.fromLTRB(0, 0, size.width, size.height - roundingHeight);

    final roundingRectangle = Rect.fromLTRB(
        -110, size.height - roundingHeight * 2, size.width + 30, size.height);

    final path = Path();
    path.addRect(filledRectangle);

    path.arcTo(roundingRectangle, pi, -pi, true);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class CurvedBottomClipper4 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final roundingHeight = size.height * 4 / 2;

    final filledRectangle =
        Rect.fromLTRB(0, 0, size.width, size.height - roundingHeight);

    final roundingRectangle = Rect.fromLTRB(
        -80, size.height - roundingHeight * 2, size.width + 40, size.height);

    final path = Path();
    path.addRect(filledRectangle);

    path.arcTo(roundingRectangle, pi, -pi, true);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class CurvedBottomClipper5 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final roundingHeight = size.height * 2 / 3;

    final filledRectangle =
        Rect.fromLTRB(0, 0, size.width, size.height - roundingHeight);

    final roundingRectangle = Rect.fromLTRB(
        -90, size.height - roundingHeight * 2, size.width + 15, size.height);

    final path = Path();
    path.addRect(filledRectangle);

    path.arcTo(roundingRectangle, pi, -pi, true);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class StraightBorderClipper extends CustomClipper<Path> {
  final double borderWidth;

  StraightBorderClipper({this.borderWidth = 1.0});

  @override
  Path getClip(Size size) {
    var path = Path();

    // Move to the top-left corner of the container
    path.moveTo(0, 0);

    // Create a straight line for the top border
    path.lineTo(size.width, 0);

    // Create a line for the right border (optional)
    path.lineTo(size.width, size.height);

    // Create a line for the left border (optional)
    path.lineTo(0, size.height);

    // Close the path to form a full border
    path.close();

    // Create a smaller path to exclude the border area (optional)
    var innerPath = Path();
    innerPath.moveTo(borderWidth, borderWidth);
    innerPath.lineTo(size.width - borderWidth, borderWidth);
    innerPath.lineTo(size.width - borderWidth, size.height - borderWidth);
    innerPath.lineTo(borderWidth, size.height - borderWidth);
    innerPath.close();

    // Subtract the inner path from the outer path to create the border
    path = Path.from(innerPath);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
