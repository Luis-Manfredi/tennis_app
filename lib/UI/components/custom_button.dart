import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, 
    required this.label, 
    required this.onPressed, 
    this.height, 
    this.width, 
    this.icon, 
    required this.fontSize
  });

  final String label;
  final double fontSize;
  final VoidCallback onPressed;
  final double? height, width;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 60,
      width: width ?? MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [primary, secondary],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight
        )
      ),

      child: icon != null 
        ? ElevatedButton.icon(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          label: icon!,
          icon: Text(label, style: TextStyle(color: Colors.white, fontSize: fontSize))
        )

      : ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ), 
        child: Text(label, style: TextStyle(color: Colors.white, fontSize: fontSize))
      )
    );
  }
}