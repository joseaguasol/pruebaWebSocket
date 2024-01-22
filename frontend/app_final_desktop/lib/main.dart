
import 'package:app_final_desktop/components/empleado/armado.dart';
import 'package:app_final_desktop/components/empleado/login.dart';

import 'package:flutter/material.dart';




void main(){

  runApp(const MyApp());
}


class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build (BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     // transitionOnUserGestures: false,
      theme: ThemeData(
        useMaterial3: true,
        
      ),
      
      home:  const Armado(),
    );
  }
}