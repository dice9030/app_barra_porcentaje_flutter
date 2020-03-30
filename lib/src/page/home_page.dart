// import 'package:app_play_dc/src/widget/cuadro_sombra.dart';
import 'dart:ui';

import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  double porcentaje = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DC'),
      ),
      body : Center(
        child: Container(
          width: double.infinity,
          height: 500,
          child: _BarraProgresoVertical(
            porcentaje: porcentaje,
          )
        ),
      ),
      floatingActionButton:  FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: (){
          setState(() {
            porcentaje+=10;
            if(porcentaje>100){
              porcentaje =0;
            }
          });
        },
      ),
      
    );
  }
}

class _BarraProgresoVertical extends StatefulWidget {
  
  final double porcentaje;

  const _BarraProgresoVertical({this.porcentaje = 0});
  
  @override
  __BarraProgresoVerticalState createState() => __BarraProgresoVerticalState();
}

class __BarraProgresoVerticalState extends State<_BarraProgresoVertical> with SingleTickerProviderStateMixin{

  AnimationController controller;
  double porcentajeAnterior;
  double porcentajeAnteriorNro;
  @override
  void initState() {    
    super.initState();
    porcentajeAnterior = widget.porcentaje;
    porcentajeAnteriorNro = widget.porcentaje;
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    controller.addListener((){
      
    });
  }

  @override
  void dispose() { 
    controller.dispose();
    super.dispose();
  }

  _validarPorcentaje(double porcentaje){
    double result;
    if( porcentaje < 20 ){
      result =  20.0 ;
    }else{
      result = porcentaje;
    }
    return result;
  }
  
  @override
  Widget build(BuildContext context) {
    controller.forward(from: 0.0);
    final diferenciaAnimar = _validarPorcentaje(widget.porcentaje) - porcentajeAnterior;
    porcentajeAnterior = _validarPorcentaje(widget.porcentaje);

    final diferenciaAnimarNro = widget.porcentaje - porcentajeAnteriorNro;
    porcentajeAnteriorNro = widget.porcentaje;
    
    return Center(
      child: AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context,Widget child ){
          final size = MediaQuery.of(context).size;           
          final nroPorcentaje = (_validarPorcentaje(widget.porcentaje) - diferenciaAnimar) + (diferenciaAnimar * controller.value);
          final nroPorcentajeNro = (widget.porcentaje - diferenciaAnimarNro) + (diferenciaAnimarNro * controller.value);
          return Stack(
            children: <Widget>[              
              Container(
                width: double.infinity,
                // color: Colors.red,
                child: CustomPaint(
                  painter:  _BarraProgreso(nroPorcentaje),
                ),
              ),
              Container(
                  color: Color(0xff5CC07D),                
                  width: size.width * ((nroPorcentaje) / 100),                               
                  padding: EdgeInsets.all( 20),
                  child: Text('${nroPorcentajeNro.toStringAsFixed(0)}%',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      textAlign: TextAlign.right,
                    ),
                ),

            ],
          );
        } ,
              
      ),
    );
  }
}

class _BarraProgreso extends CustomPainter{
  
  final porcentaje;

  _BarraProgreso(this.porcentaje);
  @override
  void paint(Canvas canvas, Size size) {


    // final paint = new Paint()
    //       ..strokeWidth = 10
    //       ..color = Colors.white
    //       ..style = PaintingStyle.stroke;

    // // Offset center = new Offset(size.width*0.5, size.height * 0.5);
    // final path = new Path();

    // path.moveTo(0, size.height * 0.5);
    // path.lineTo(size.width, size.height * 0.5);

    // canvas.drawPath(path, paint);


    //BARRA PORNCENTAJE
    
    final paintBarra = new Paint()
          ..strokeWidth = 1
          ..color = Color(0xff5CC07D)
          ..style = PaintingStyle.stroke;

    final pathBarra = new Path();

    double validaPorcentaje;
    if( porcentaje < 20 ){
      validaPorcentaje = 20.0 ;
    }else{
      validaPorcentaje = porcentaje;
    }

    double barraPorcentaje = validaPorcentaje /100;
    double avance = size.width * barraPorcentaje;

    pathBarra.moveTo(0, size.height * 0.5);
    pathBarra.lineTo(avance, size.height * 0.5);

    canvas.drawPath(pathBarra, paintBarra);
    
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;


}



