import 'package:flutter/material.dart';

class ContainerRecomendedStop extends StatelessWidget {
  const ContainerRecomendedStop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Color(0xFF8B4513),
          width: 2,
        ),
      ),
    );
  }
}