import 'package:app_final/components/cliente/bienvenido.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

//import 'package:app_final/components/cliente/row_product.dart';

class Gracias extends StatefulWidget {
  const Gracias({super.key});

  @override
  State<Gracias> createState() => _GraciasState();
}

class _GraciasState extends State<Gracias>{
    void navigateToBienvenido(){
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Bienvenido(),
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
    return Scaffold(
      //backgroundColor: const Color.fromARGB(255, 163, 223, 165),
      body: SafeArea(
        child:Padding(
          padding: EdgeInsets.all(2),
          child: Center(
            child: Column(
              children: [
                Container(
                  height: 200,
                  child: Lottie.asset('lib/imagenes/Animation - 1702309484160.json')),
                //const SizedBox(height: 40,),
                Container(
                  height: 350,
                  child: Image.asset('lib/imagenes/BIDON20.png')),
                  SizedBox(height: 60,),
                  Text("Gracias",style:TextStyle(fontFamily: 'Pacifico',color:Colors.blue,fontSize:50)),
                Text("¡Tu Orden está Confirmada!",style:TextStyle(fontFamily: 'Pacifico',fontSize:30,color:Colors.blue,fontWeight: FontWeight.bold)),
                              const SizedBox(height: 60,),
                
            
                ElevatedButton(onPressed:() {
                  navigateToBienvenido();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                  fixedSize: MaterialStateProperty.all(Size(300,60))
                ), child: Text("Listo",style: TextStyle(fontFamily: 'Pacifico',fontSize: 40,color:Colors.white),))
              ],
            ),
          ),
        ),
      ),
    );
  }
}