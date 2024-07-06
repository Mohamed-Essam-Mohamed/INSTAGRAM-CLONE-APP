import 'package:flutter/material.dart';

class ResponsiveUi extends StatelessWidget {
  const ResponsiveUi(
      {super.key, required this.webScreen, required this.mobileScreen});
  final Widget webScreen;
  final Widget mobileScreen;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return webScreen;
        }
        return mobileScreen;
      },
    );
  }
}
