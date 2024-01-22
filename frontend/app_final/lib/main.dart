import 'package:app_final/components/cliente/historial.dart';
import 'package:app_final/components/cliente/promocion.dart';
import 'package:app_final/components/cliente/ubicacion.dart';
import 'package:app_final/components/conductor/bienvenida.dart';
import 'package:app_final/components/conductor/felicitaciones.dart';
//import 'package:app_final/components/empleado/home.dart';
import 'package:app_final/components/empleado/armadoruta.dart';
import 'package:app_final/components/test/camara.dart';
import 'package:app_final/components/test/dise%C3%B1o.dart';
import 'package:app_final/components/test/fin.dart';
import 'package:app_final/components/test/formulario.dart';
import 'package:app_final/components/test/hola.dart';
import 'package:app_final/components/test/holaconductor.dart';
import 'package:app_final/components/test/pedido.dart';
import 'package:app_final/components/test/presenta.dart';
import 'package:app_final/components/test/promos.dart';
import 'package:app_final/components/test/ubicacion.dart';
import 'package:app_final/components/test/productos.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:app_final/login.dart';
//import 'package:app_final/components/cliente/productos.dart';
import 'package:app_final/components/cliente/bienvenido.dart';
import 'package:app_final/presentacion.dart';
import 'package:app_final/provider/usuario_provider.dart';
import 'package:provider/provider.dart';
import 'package:app_final/components/test/camara.dart';
//import 'package:app_final/components/empleado/pedidos.dart';
import 'package:app_final/components/empleado/programacion.dart';

late List<CameraDescription> camera;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  camera = await availableCameras();
  //await Geolocator.requestPermission();
  runApp(ChangeNotifierProvider(
    create: (context) => UsuarioProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: '/ubicacion',
      routes: {
//<<<<<<< HEAD
        '/diseño': (context) => Hola(),
        '/cliubi': (context) => Maps(),
        '/ubicacion': (context) => Ubicacion(),
        '/historial': (context) => Historial(),
        '/c_felicitaciones': (context) => FelicitacionesConductor(),
        '/c_bienvenido': (context) => BienvenidaConductor(),
        '/presentacion': (context) => Presentacion(),
        '/programacion': (context) => Programacion(),
        '/conductor': (context) => HolaConductor(),
        '/armadoruta': (context) => ArmadoRuta(),
        '/promos': (context) => Promos(),
        '/loginsol': (context) => const Login2(),
        '/bienvenido': (context) => const Bienvenido(),
        '/productos': (context) => const Productos(),
        '/maps': (context) => const Maps(),
/*
=======
        '/diseño': (context) => Hola(),
        '/historial': (context) => Historial(),
        '/c_felicitaciones': (context) => FelicitacionesConductor(),
        '/c_bienvenido': (context) => BienvenidaConductor(),
        '/presentacion': (context) => Presentacion(),
        '/programacion': (context) => Programacion(),
        '/conductor': (context) => HolaConductor(),
        '/armadoruta': (context) => ArmadoRuta(),
        '/promos': (context) => Promos(),
        '/loginsol': (context) => const Login3(),
        '/bienvenido': (context) => const Bienvenido(),
        '/productos': (context) => const Productos(),
        '/maps': (context) => const Maps(),
>>>>>>> 9fcb71a67fb42580013b116248a674e1431fd44c*/
      },
      //home: const Login3(),
    );
  }
}
