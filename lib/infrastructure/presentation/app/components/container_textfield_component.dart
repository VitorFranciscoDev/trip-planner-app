import 'package:flutter/material.dart';

class ContainerTextFieldComponent extends StatelessWidget {
  const ContainerTextFieldComponent({ super.key, required this.child, this.height });
  final Widget child;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: theme.colorScheme.tertiary,
        borderRadius: BorderRadius.circular(35),
      ),
      child: child,
    );
  }
}