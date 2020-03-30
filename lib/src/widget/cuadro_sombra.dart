import 'package:flutter/material.dart';

class CuadroSombra extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(          
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            offset: Offset(5, 5),
            color: Colors.black,
            blurRadius: 12,
            spreadRadius: - 10.0,
          )
        ] ,
      ),      
    );
  }
}