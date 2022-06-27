// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobilePage;
  final Widget tabletPage;
  final Widget desktopPage;

  const ResponsiveLayout(
      {required this.mobilePage,
      required this.tabletPage,
      required this.desktopPage});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        constraints.widthConstraints();
        if (constraints.maxWidth < 710) {
          currentDevice = DeviceTypes.mobile;
          return mobilePage;
        } else if (constraints.maxWidth < 1200) {
          currentDevice = DeviceTypes.tablet;
          return tabletPage;
        } else {
          currentDevice = DeviceTypes.desktop;
          return desktopPage;
        }
      },
    );
  }
}

enum DeviceTypes {
  mobile,
  tablet,
  desktop,
}

late DeviceTypes currentDevice;
