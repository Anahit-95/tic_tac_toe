import 'package:flutter/material.dart';

const int relativeWidth = 414; // iPhone 11 Pro Max screen width
const int relativeHeight = 896; // iPhone 11 Pro Max screen height

double rw(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  return relativeHeight - height < relativeWidth - width
      ? rwWidth(width)
      : rwHeight(height);
}

double rwWidth(double width) {
  return width / relativeWidth;
}

double rwHeight(double height) {
  return height / relativeHeight;
}

double grw(BuildContext context) {
  final grw = rw(context);
  return grw < 1 ? 1 : grw;
}
