import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:app_final/components/conductor/felicitaciones.dart';

class BienvenidaConductor extends StatefulWidget{

  const BienvenidaConductor({Key? key}) : super(key: key);
  //const BienvenidaConductor({super.key});

  @override
  State<BienvenidaConductor> createState()=>_BienvenidaConductor();
}

String url = 'https://aguasol.onrender.com/api/user_conductor';

    List<dynamic> datosConductor=[];
    String nombreConductor='Pedrito';

    Future<dynamic>getPedidos() async{
      var res = await http.get(Uri.parse(url),
      headers:{"Content-Type":"application/json"});
      datosConductor = json.decode(res.body);
      nombreConductor=datosConductor[0]['nombres'];
      print(nombreConductor);
      return nombreConductor;
    }

class _BienvenidaConductor extends State<BienvenidaConductor>{

  var ruta=2;

  @override
  Widget build(BuildContext context){

    getPedidos();

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
          title: const Text("Bienvenid@", style: TextStyle(fontSize:20,fontWeight:FontWeight.w300,color: Color.fromARGB(255, 63, 63, 63))),
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
                child: Text('¡Buenos días, $nombreConductor!',style: const TextStyle(fontSize:19,fontWeight:FontWeight.w500,color: Color.fromARGB(255, 92, 92, 92))) ,
              ),
              const Text('Tu ruta asignada es la',style: TextStyle(fontSize:17,fontWeight:FontWeight.w500,color:  Color.fromARGB(255, 92, 92, 92),fontStyle: FontStyle.italic)),
              Text('RUTA $ruta',style: const TextStyle(fontSize:17,fontWeight:FontWeight.w500,color:  Color.fromARGB(255, 92, 92, 92),fontStyle: FontStyle.italic)),
              SizedBox(
                height: 160,
                child: Stack(
                  children: [
                    Center(
                      child: Lottie.asset('lib/animatios/anim_23.json',height: 700)
                      ),
                    Center(
                      child: Lottie.asset('lib/animatios/anim_23.json',height: 700)
                      ),
                    Center(
                      child: Lottie.asset('lib/animatios/anim_13.json',height: 480),
                    )
                    
                  ],
                )
                //opciones posibles:14,13,12,9,5
              ),
              ElevatedButton(
                onPressed: (){
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context)=>const FelicitacionesConductor()),
                  );
                }, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 240, 240, 240),
                ),
                child: const Text('¡COMENZAR!', style: TextStyle(color: Colors.black),),
              ),
          ],
        ),
      ),
    )
    );
  }
}
