part of '../imports/intro_imports.dart';

class IntroClipper extends CustomClipper<Path> {
  IntroEdgeOperation edge;
  double margin;

  IntroClipper(this.edge, {this.margin = 0.0}) : super();

  @override
  Path getClip(Size size) {
    return edge.buildPath(size, margin: margin);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
