import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class MyAppIcons extends StatelessWidget {
  final List<List<dynamic>> iconData;
  final double? size;
  final Color? color;

  const MyAppIcons({super.key, required this.iconData, this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return HugeIcon(icon: iconData, size: size, color: color);
  }
}

class MyMaterialIcon extends StatelessWidget {
  final IconData iconData;
  final double? size;
  final Color? color;

  const MyMaterialIcon({
    super.key,
    required this.iconData,
    this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(iconData, size: size, color: color);
  }
}
