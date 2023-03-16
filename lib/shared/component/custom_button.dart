import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.onPressed, required this.text,}) : super(key: key);
  final VoidCallback onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: MaterialButton(
        color: Colors.deepOrange,
        padding:const EdgeInsets.symmetric(
            vertical: 13.5,
            horizontal: 30
        ),
        minWidth: double.infinity,
        onPressed: onPressed,
        child: Text(
          text,
          style:const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),

      ),
    );
  }
}
