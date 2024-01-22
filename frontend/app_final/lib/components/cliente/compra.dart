
import 'package:flutter/material.dart';
import 'package:app_final/components/cliente/gracias.dart';
import 'package:app_final/components/cliente/productos.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:app_final/provider/usuario_provider.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;

class Compra extends StatefulWidget {
  //final List<Producto> productos;
  final List<Producto> productos;
  final int montoTotal;

  const Compra({required this.productos,required this.montoTotal});

  @override
  State<Compra> createState() => _Compra();
}

class _Compra extends State<Compra>{
    
    bool normal = false;
    bool express = false;
    int cantidad = 0;
     String apiPedido = 'http://10.0.2.2:8004/api/pedido';
     String apiDetalle = 'http://10.0.2.2:8004/api/detallepedido';
     String apiLastPedido = 'http://10.0.2.2:8004/api/pedido_last';

    Future <void>setCliente (clienteId,monto,fecha,direccion)async{
   await http.post(Uri.parse(apiPedido),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
        	"cliente_id": clienteId,
          "monto_total":monto,
          "fecha":fecha,
          "direccion":direccion
      }));
     
  }
  
  Future<void>setDetallePedido(Clienteid,producto_id,fecha,cantidadProducto,descripcion,descuento,precioProducto) async{
    await http.post(Uri.parse(apiDetalle),
     headers: {"Content-Type": "application/json"},
   body: jsonEncode({
        	"clienteid":Clienteid,
          "producto_id":producto_id,
          "fecha":fecha,
          "cantidad":cantidadProducto,
          "descripcion_general":descripcion,
          "descuento":descuento,
          "precio_total":precioProducto

      }));

  }
  
  Future<int>getLastPedido() async {
    var lastPedido = await http.get(Uri.parse(apiLastPedido),
    headers: {"Content-Type":"application/json"});
    if (lastPedido.statusCode == 200){
      Map<String,dynamic> data = jsonDecode(lastPedido.body);
      
      return int.parse(data['id'].toString());
    }
    else{
      return 0;
    }
    

    
  }

   
    void navigateGracias(id,monto,fecha,direccion)async{

        BuildContext currentContext = context;

        setCliente(id, monto, fecha, direccion);
        DateTime now = DateTime.now();
        String fechaHoy = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
        //var lastPedido = await getLastPedido();
        //print("last--> ${lastPedido}");
        for (var i=0;i<widget.productos.length;i++){
          await setDetallePedido(id,widget.productos[i].id,fechaHoy,widget.productos[i].cantidad,"productos",10,widget.productos[i].precio);

        }
        Navigator.push(
          currentContext,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => Gracias(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOutQuart;

              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 800),
          ),
        );
        }





    @override
    Widget build (BuildContext context){
    UsuarioProvider usuarioProvider = Provider.of<UsuarioProvider>(context);
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
      return Scaffold(
       // backgroundColor: const Color.fromARGB(255, 240, 211, 122),
        appBar: AppBar(
          title: Text("Detalle de Compra",style: TextStyle(color:Colors.blue,fontFamily: 'Pacifico',fontSize: 35,fontWeight: FontWeight.w200),),centerTitle: true,
          //automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(25),
              child: Column(
                children: [
                 // Text("Resumen de Compra",textAlign:TextAlign.start,style:TextStyle(color:Colors.black)),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                        
                        height: 280,
                        //width: 100,
                        decoration: BoxDecoration(
                          color:Color.fromARGB(255, 124, 231, 126),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.all(10),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                  
                          Row(
                            children: [
                              Icon(Icons.checklist_rounded,size: 40,color: Colors.white,),
                              const SizedBox(width:15,),
                              Text("Compra",style:TextStyle(color:Colors.white,fontFamily: 'Pacifico',fontWeight: FontWeight.w200,fontSize: 40)),
                            ],
                          ),
                          Expanded(
                            
                            child: ListView.builder(
                              
                              padding: EdgeInsets.all(5),
                              itemCount: widget.productos.length,
                              itemBuilder: (context,index){
                              return
                               Row(
                                 children: [
                                   Icon(Icons.check_circle_outlined),
                                   const SizedBox(width: 10,),
                                   Text("ID DE PRODUCTO ${widget.productos[index].id}"),
                                   Text("Cantidad de Productos:${widget.productos[index].cantidad}",style:TextStyle(fontFamily:'Pacifico',fontWeight: FontWeight.w200,fontSize: 20)),
                                 ],
                               );
                            
                              }),
                          ),
                          Text("Subtotal:   S/.${widget.montoTotal}",style:TextStyle(color:Colors.blue,fontFamily: 'Pacifico',fontWeight: FontWeight.w200,fontSize: 30))
                          
                        ]),           
                      ),
                        SizedBox(height: 30,),
                        Container(
                          height: 200,
                          
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 191, 223, 46),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.all(15),
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Row(
                              children: [
                                Icon(Icons.person_pin_outlined,size: 40,color:Colors.white),
                                SizedBox(width: 15,),
                                Text("Cliente",style:TextStyle(color:Colors.blue,fontFamily:'Pacifico',fontWeight: FontWeight.w200,fontSize: 40)),
                              ],
                            ),
                           // print("id,${usuarioProvider.getusuarioActual.id}");
                          Text(" -ID de Cliente: ${usuarioProvider.getusuarioActual.getid()}", style: TextStyle(fontFamily:'Pacifico',fontWeight: FontWeight.w200, fontSize: 20)),

                            Text(" - Nombres: ${usuarioProvider.getusuarioActual.getNombre()}",style:TextStyle(fontFamily:'Pacifico',fontWeight: FontWeight.w200,fontSize: 20)),
                            Text(" - Direccion: Av. Brasil 204",style:TextStyle(fontFamily:'Pacifico',fontWeight: FontWeight.w200,fontSize: 20))
                    
                    
                          ]),           
                        ).animate().shake(),
                        SizedBox(height: 30,),
                      
                        Container(
                        
                        height: 180,
                        width: 400,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 172, 171, 168),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.all(10),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text("Tipo de Envío:",style:TextStyle(fontFamily:'Pacifico',fontWeight: FontWeight.w200,fontSize: 30)),
                          Row(children: [
                            Container(
                              height: 50,
                              
                              child:Icon(Icons.warehouse_outlined,color:Colors.white,size: 55,)
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                child: Text("ESTANDAR ( Se agenda para mañana )",style: TextStyle(fontSize:15,fontFamily:'Pacifico',),),
                              ),
                            ),
                            Container(
                              child: Checkbox(
                                checkColor: Colors.white,
                  
                                value: normal,
                                onChanged:(bool? value){
                                  setState(() {
                                    normal = value!;
                                  });
                                },
                              ),
                            )
                  
                          ],),
                          Row(children: [
                            Container(
                              height: 50,
                              
                              child:Icon(Icons.local_shipping,color:Colors.white,size: 55,)
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                child: Text("EXPRESS ( Entrega  HOY + S/.10.00 )",style:TextStyle(fontSize:15,fontFamily:'Pacifico',),),
                              ),
                            ),
                            Container(
                              child: Checkbox(
                                checkColor: Colors.white,
                  
                                value: normal,
                                onChanged:(bool? value){
                                  setState(() {
                                    normal = value!;
                                  });
                                },
                              ),
                            )
                  
                          ],),
                  
                        ]),           
                      ),
                        
                      ],
                    ),
                  ),

                  //

                  SizedBox(height: 30,),
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color:Color.fromARGB(255, 82, 125, 97)
                        ),
                        child: Row(
                          children: [
                           const SizedBox(width:10,),
                           Icon(Icons.payments_outlined,size: 50,color: Colors.white,),
                           const SizedBox(width:20,),
                           Text("S/.${widget.montoTotal}.00",style:TextStyle(fontFamily:'Pacifico',fontSize:30,color:Colors.white),),
                           const SizedBox(width:30,),
                           ElevatedButton(onPressed:(){
                              navigateGracias(usuarioProvider.getusuarioActual.id,widget.montoTotal,formattedDate,"sachaquita");
                           
                           },
                           style:ButtonStyle(
                            fixedSize: MaterialStateProperty.all(Size(150,80))
                           ), 
                           child:Text("Confirmar",style: TextStyle(fontFamily:'Pacifico',fontSize:20),))
                           
                          ],
                        ),           
                      ),   

                ]
              )
          )
        )
      );
    }
}

                /*  ListView(
                    children: [
                      SizedBox(height: 20,),
                      Text("Resumen",style: TextStyle(fontWeight: FontWeight.w200,fontSize: 20),),
                      Container(
                        
                        height: 320,
                        width: 400,
                        decoration: BoxDecoration(
                          color:const Color.fromARGB(255, 177, 220, 178),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.all(10),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                  
                          Text("Compra:",style:TextStyle(fontWeight: FontWeight.w200,fontSize: 30)),
                          Expanded(
                            
                            child: ListView.builder(
                              
                              padding: EdgeInsets.all(5),
                              itemCount: widget.productos.length,
                              itemBuilder: (context,index){
                              return Text("Cantidad de Productos:${widget.productos[index].cantidad}",style:TextStyle(fontWeight: FontWeight.w200,fontSize: 20));
                            
                              }),
                          ),
                  
                          Text(" - Bidon x 3  :   S/.90.00",style:TextStyle(fontWeight: FontWeight.w200,fontSize: 20)),
                          Text(" - Botellas x 3  :   S/.10.00",style:TextStyle(fontWeight: FontWeight.w200,fontSize: 20)),
                          Text("Subtotal:   S/.105.00",style:TextStyle(fontWeight: FontWeight.w200,fontSize: 20))
                  
                  
                        ]),           
                      ),
                      // USUARIO ------------->
                      SizedBox(height: 30,),
                      Container(
                        
                        height: 200,
                        width: 400,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.all(10),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text("Usuario:",style:TextStyle(fontWeight: FontWeight.w200,fontSize: 30)),
                          Text(" - Nombres: Pedro P. Perez Perez",style:TextStyle(fontWeight: FontWeight.w200,fontSize: 20)),
                          Text(" - Direccion: Av. Brasil 204",style:TextStyle(fontWeight: FontWeight.w200,fontSize: 20))
                  
                  
                        ]),           
                      ),
                      SizedBox(height: 30,),
                      
                      
                      // ENVÍOS---------------->
                      Container(
                        
                        height: 180,
                        width: 400,
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.all(10),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text("Tipo de Envío:",style:TextStyle(fontWeight: FontWeight.w200,fontSize: 30)),
                          Row(children: [
                            Container(
                              height: 50,
                              
                              child:Icon(Icons.warehouse_outlined,color:Colors.white,size: 55,)
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                child: Text("Normal (Se agenda para mañana)"),
                              ),
                            ),
                            Container(
                              child: Checkbox(
                                checkColor: Colors.white,
                  
                                value: normal,
                                onChanged:(bool? value){
                                  setState(() {
                                    normal = value!;
                                  });
                                },
                              ),
                            )
                  
                          ],),
                          Row(children: [
                            Container(
                              height: 50,
                              
                              child:Icon(Icons.local_shipping,color:Colors.white,size: 55,)
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                child: Text("Express (Se entrega HOY + S/.10.00)"),
                              ),
                            ),
                            Container(
                              child: Checkbox(
                                checkColor: Colors.white,
                  
                                value: normal,
                                onChanged:(bool? value){
                                  setState(() {
                                    normal = value!;
                                  });
                                },
                              ),
                            )
                  
                          ],),
                  
                        ]),           
                      ),

                      // Confirmación ----------------------------->
                      SizedBox(height: 30,),
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color:Colors.purple
                        ),
                        child: Row(
                          children: [
                           const SizedBox(width:10,),
                           Icon(Icons.payments_outlined,size: 50,color: Colors.white,),
                           const SizedBox(width:20,),
                           Text("S/.200.00",style:TextStyle(fontSize:30,color:Colors.white),),
                           const SizedBox(width:30,),
                           ElevatedButton(onPressed:(){
                              navigateGracias();
                           },
                           style:ButtonStyle(
                            fixedSize: MaterialStateProperty.all(Size(150,80))
                           ), 
                           child:Text("Confirmar",style: TextStyle(fontSize:20),))
                           
                          ],
                        ),           
                      ),
                      SizedBox(height: 30,)
                  
                    
                      
                  
                    ],
                  ),*/
