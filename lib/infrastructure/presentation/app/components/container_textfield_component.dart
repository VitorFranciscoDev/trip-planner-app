import 'package:flutter/material.dart';

class ContainerTextFieldComponent extends StatelessWidget {
  const ContainerTextFieldComponent({ super.key, required this.child, this.height });
  final Widget child;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
      ),
      child: child,
    );
  }
}