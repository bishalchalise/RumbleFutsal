import 'package:flutter/material.dart';
import 'package:rumble_futsal/utils/config.dart';

class Button extends StatelessWidget {
  const Button(
      {super.key,
      required this.width,
      required this.title,
      required this.disable,
      required this.onPressed});

  final double width;
  final String title;
  final bool disable;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Config.primaryColor, 
          foregroundColor: Colors.white,
        ),
        
        onPressed: disable ? null :onPressed, 
      child: Text(title, 
      style: const TextStyle(
        fontSize: 18.0, 
        fontWeight: FontWeight.bold
      ),),),

    );
  }
}
