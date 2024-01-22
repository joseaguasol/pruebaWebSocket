import 'package:app_final/components/conductor/bienvenida.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';


class FelicitacionesConductor extends StatefulWidget{

  

  const FelicitacionesConductor({Key? key}) : super(key: key);
  //const BienvenidaConductor({super.key});

  @override
  State<FelicitacionesConductor> createState()=>_FelicitacionesConductor();
}


class _FelicitacionesConductor extends State<FelicitacionesConductor>{

  var ruta=2;

  @override
  Widget build(BuildContext context){

    return Container(

      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Color.fromARGB(255, 255, 255, 255),Color.fromARGB(255, 28, 187, 255)],
        )
      ),



      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Felicitaciones", style: TextStyle(fontSize:20,fontWeight:FontWeight.w300,color: Color.fromARGB(255, 63, 63, 63))),
          leading: const IconButton(
            onPressed: null, 
            icon: Icon(Icons.menu)
          ),
          backgroundColor: const Color.fromARGB(255, 56, 195, 255),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),



        body: Padding(

          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text('¡Felicidades, $nombreConductor!',style: const TextStyle(fontSize:19,fontWeight:FontWeight.w500,color: Color.fromARGB(255, 92, 92, 92))) ,
              ),
              const Text('Completaste la ',style: TextStyle(fontSize:17,fontWeight:FontWeight.w500,color:  Color.fromARGB(255, 92, 92, 92),fontStyle: FontStyle.italic)),
              Text('RUTA $ruta',style: const TextStyle(fontSize:17,fontWeight:FontWeight.w500,color:  Color.fromARGB(255, 92, 92, 92),fontStyle: FontStyle.italic)),
              SizedBox(
                height: 300,
                child: Stack(
                  children: [
                    Center(
                      child: Lottie.asset('lib/animatios/anim_1.json',height: 700),
                    ),
                    Center(
                      child: Lottie.asset('lib/animatios/anim_1.json',height: 200)
                      ),
                    Center(
                      child: Lottie.asset('lib/animatios/anim_16.json',height: 180),
                    )
                    
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context)=>const BienvenidaConductor()),
                  );
                },  
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 240, 240, 240),
                ),
                child: const Text('¡REGRESAR A ALMACEN!', style: TextStyle(color: Colors.black),),
              ),
          ],
        ),
      ),
    )
    );
  }
}
