import 'package:flutter/material.dart';

class ButtonCard extends StatelessWidget {
  ButtonCard({super.key, required this.name});

  String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(50),
            offset: const Offset(3, 6),
            spreadRadius: 2.9,
            blurRadius: 3,
          )
        ],
      ),
      width: 180,
      height: 150,
      child: Center(
        child: Text(
          name,
          // 'Bloc Example',
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
