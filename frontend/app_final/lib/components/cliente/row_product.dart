

import 'package:flutter/material.dart';

class ProductCustom extends StatelessWidget {
  //final int id;
  final String image; // temporal por ahora
  final String nombre;
  final int precio;
  //final String descripcion;
  //final int stock; // temporal por ahora
  final int contador;
  final VoidCallback? onPressedplus;
  final VoidCallback? onPressedminus;

  const ProductCustom({
    super.key,
    //required this.id,
    required this.nombre,
    required this.precio,
    //required this.stock,
    required this.image,
    required this.contador,
    //required this.descripcion,
    this.onPressedplus,
    this.onPressedminus,
    
  });

  @override
  Widget build(BuildContext context) {

    
    return Row(
      
      children: [
        Container(
          height: 100,
          width: 90,
          //color:Colors.amber,
          child: Image.asset(image,width: 20,
          ),
        ),
    
        Expanded(
          child: Container(
            
            //color:Colors.blue,
            height: 100,
            alignment:Alignment.center,
              
              child:
            Row(
              children: [
                Text(nombre,style:TextStyle(fontFamily: 'Pacifico',color:Colors.black,fontSize:15,fontWeight: FontWeight.w300),),
                SizedBox(width: 30,),
                Text("S/.${precio}",style:TextStyle(fontFamily: 'Pacifico',color:Colors.black,fontSize:25,fontWeight: FontWeight.w300),),
              ],
            ),
            
          ),
        ),
        Container(
          height: 100,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
           //color: Colors.blue,
          ),
          //color:Colors.blue,
          child: Row(
            children: [
              IconButton(onPressed:   onPressedminus,
                icon:Icon(Icons.remove_circle_outline),
                iconSize: 40,
                color: const Color.fromARGB(255, 195, 120, 208),
               ),
               Container(
                height: 45,
                width: 30,
                
                //color: Colors.blue,
                child:Center(
                  child:FittedBox(
                    child:Text("$contador",style: TextStyle(fontFamily: 'Pacifico',color:Color.fromARGB(255, 32, 143, 233),fontSize:30,fontWeight: FontWeight.w300),
                    )))
                 
               ),
              
               IconButton(onPressed: onPressedplus,
                icon: Icon(Icons.add_circle_outline),
                iconSize: 40,
                color:Colors.amber,
                )
            ],
          ),
          
        ),
      SizedBox(height: 120,),
      ],
    );
  }
}