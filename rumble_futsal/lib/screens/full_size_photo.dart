import 'dart:io';

import 'package:flutter/material.dart';


class FullSizeImagePage extends StatelessWidget {
  final String imagePath;

  const FullSizeImagePage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
          Navigator.of(context).pop();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          
          child: Image.file(
            
            File(imagePath), ),
        ),
      ),
    );
  }
}
