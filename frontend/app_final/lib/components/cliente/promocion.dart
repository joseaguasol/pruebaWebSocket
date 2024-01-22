
import 'package:flutter/material.dart';


class Promocion extends StatefulWidget{
  const Promocion({super.key});

  @override
  State<Promocion> createState() => _PromocionState();
}

class _PromocionState extends State<Promocion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Promociones"),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    color:Colors.blue,
                    padding: EdgeInsets.all(8),
                    width: 150,
                    height: 100,
                    child: Image.asset('lib/imagenes/promocion.jpg'),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Container(
                      color:Colors.blue,
                      padding: EdgeInsets.all(8),
                      //width: 150,
                      height: 100,
                      child: Text("Promoción 3 X 2 \n S/.20.00",style: TextStyle(fontSize:30,fontWeight: FontWeight.w200),textAlign: TextAlign.left,)//Image.asset('lib/imagenes/promocion.jpg'),
                    ),
                  ),
                 

                ],                
              ),
              Row(
                children: [
                  Container(
                    color:Colors.blue,
                    padding: EdgeInsets.all(8),
                    width: 150,
                    height: 100,
                    child: Image.asset('lib/imagenes/promocion.jpg'),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Container(
                      color:Colors.blue,
                      padding: EdgeInsets.all(8),
                      //width: 150,
                      height: 100,
                      child: Text("Promoción 3 X 2 \n S/.20.00",style: TextStyle(fontSize:30,fontWeight: FontWeight.w200),textAlign: TextAlign.left,)//Image.asset('lib/imagenes/promocion.jpg'),
                    ),
                  ),
                 

                ],                
              ),
              Row(
                children: [
                  Container(
                    color:Colors.blue,
                    padding: EdgeInsets.all(8),
                    width: 150,
                    height: 100,
                    child: Image.asset('lib/imagenes/promocion.jpg'),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Container(
                      color:Colors.blue,
                      padding: EdgeInsets.all(8),
                      //width: 150,
                      height: 100,
                      child: Text("Promoción 3 X 2 \n S/.20.00",style: TextStyle(fontSize:30,fontWeight: FontWeight.w200),textAlign: TextAlign.left,)//Image.asset('lib/imagenes/promocion.jpg'),
                    ),
                  ),
                 

                ],                
              ),
              Row(
                children: [
                  Container(
                    color:Colors.blue,
                    padding: EdgeInsets.all(8),
                    width: 150,
                    height: 100,
                    child: Image.asset('lib/imagenes/promocion.jpg'),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Container(
                      color:Colors.blue,
                      padding: EdgeInsets.all(8),
                      //width: 150,
                      height: 100,
                      child: Text("Promoción 3 X 2 \n S/.20.00",style: TextStyle(fontSize:30,fontWeight: FontWeight.w200),textAlign: TextAlign.left,)//Image.asset('lib/imagenes/promocion.jpg'),
                    ),
                  ),
                 

                ],                
              ),
            ],
          ),
        ),
      ),
    );
  }
}
