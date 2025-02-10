import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  //const MyButton({super.key});

  final child;
  MyButton({this.child});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: EdgeInsets.all(20),
            color: Colors.grey[900],
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}
