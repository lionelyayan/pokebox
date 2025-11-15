import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget portrait;
  final Widget? landscape;

  const ResponsiveWidget({super.key, required this.portrait, this.landscape});

  static bool isPortrait(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.portrait;

  static bool isLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  @override
  Widget build(BuildContext context) {
    if (isPortrait(context)) {
      return portrait;
    }
    return landscape!;
  }
}
