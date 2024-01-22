import 'package:app_final/login.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Presentacion extends StatefulWidget {
  const Presentacion({Key? key}) : super(key: key);

  @override
  State<Presentacion> createState() => _PresentacionState();
}

class _PresentacionState extends State<Presentacion> with TickerProviderStateMixin {
  late final AnimationController _controller;
  bool _showLogo = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2), // Establecer la duración en 2 segundos
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _showLogo = true;
          _navigateToLogin();
        });
      }
    });

    // Iniciar la animación al principio
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToLogin(){
    Future.delayed(Duration(seconds: 2),(){
       Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login3()), // Reemplaza "OtraVista" con el nombre de tu nueva vista
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    //DIMENSIONES
    final anchoActual = MediaQuery.of(context).size.width;
    final largoActual = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Stack(
            children: [
              // Mostrar la animación Lottie solo si _showLogo es false
              if (!_showLogo)
                Center(
                  child: Lottie.asset(
                    'lib/imagenes/Animation - 1702935083488.json',
                    controller: _controller,
                  ),
                ),
              
              // Mostrar el logo solo si _showLogo es true
              if (_showLogo)
                Center(
                  child: Image.asset('lib/imagenes/logo_sol_tiny.png',
                  width: anchoActual >= 480 ? 150 : 100,
                  height: largoActual >= 980 ? 150 : 100,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
