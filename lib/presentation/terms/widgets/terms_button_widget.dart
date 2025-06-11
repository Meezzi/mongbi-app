import 'package:flutter/material.dart';

class ConfirmButton extends StatelessWidget{
  const ConfirmButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child:ElevatedButton(
        onPressed: (){

        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xF5F5F4F5),
          foregroundColor: Color(0xFFD6D4D8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999)
          ),
        ), 
        child: const Text('확인했어') 
      )
    );
  }
}