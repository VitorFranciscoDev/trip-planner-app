import 'package:flutter/material.dart';

class ContainerTextFieldComponent extends StatelessWidget {
  const ContainerTextFieldComponent({ super.key, required this.child });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
      ),
      child: child,
    );
  }
}