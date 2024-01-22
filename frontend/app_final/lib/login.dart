import 'dart:convert';
import 'package:app_final/components/cliente/ubicacion.dart';
import 'package:provider/provider.dart';
import 'package:app_final/provider/usuario_provider.dart';
import 'package:app_final/provider/usuarios_model.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/material.dart';
import 'components/cliente/bienvenido.dart';
import 'package:app_final/components/empleado/programacion.dart';
import 'package:app_final/components/conductor/bienvenida.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login3 extends StatefulWidget {
  const Login3({super.key});

  @override
  State<Login3> createState() => _Login3State();
}

class _Login3State extends State<Login3> {
  //ATRIBUTOS
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  late String responseText = '';
  String apiUrl = 'https://aguasol.onrender.com/api/login';

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // LLAMADA DE API
  Future<dynamic> sendCredentials(user, pass) async {
    if (user == null || pass == null) {
      return "Error: nulos";
    }
    print(" dentro de creden");

    var res = await http.post(Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"nickname": user, "contrasena": pass}));

    if (res.statusCode == 200) {
      // La so  licitud fue exitosa, puedes manejar los datos aquí
      return json.decode(res.body);
    }
  }

  // google
/*
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
*/
  Future<dynamic> signInWithGoogle() async {
    try {
      print("aca");
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User? user = authResult.user;
      return user;
    } catch (e) {
      print('Error during Google sign-in: $e');
      return null;
    }
  }

  void navigateToBienvenido() {
    print("oe");
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => Maps(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          print("estamos aqui?");
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutQuart;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
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

  void navigateToProgramacion() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => Programacion(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutQuart;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
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

  void navigateToBienvenidaConductor() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            BienvenidaConductor(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutQuart;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
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
  Widget build(BuildContext context) {
    // variables especiales
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final usuarioProvider =
        Provider.of<UsuarioProvider>(context, listen: false);

    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          /*Lottie.asset('lib/imagenes/Animation - 1701782678197.json',
              width: screenWidth, height: screenHeight, fit: BoxFit.fill),*/
          SafeArea(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      Image.asset(
                        'lib/imagenes/logo_sol_tiny.png',
                        width: 100,
                        height: 100,
                      ).animate().fade().then().shake(),
                      const SizedBox(
                        height: 200,
                      ),
                      Container(
                        width: 350,
                        child: TextField(
                          controller: _username,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: "User",
                              labelStyle:
                                  TextStyle(color: Colors.blue, fontSize: 14),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent))),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 350,
                        child: TextField(
                          controller: _password,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: "Password",
                            labelStyle:
                                TextStyle(color: Colors.blue, fontSize: 14),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                borderSide:
                                    BorderSide(color: Colors.blueAccent)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                borderSide:
                                    BorderSide(color: Colors.blueAccent)),
                          ),
                          obscureText: true,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          print("...Inicio...");
                          String usuario = _username.text;
                          String pass = _password.text;
                          print("credenciales $usuario,$pass");

                          FocusScope.of(context).unfocus();

                          var resultado = await sendCredentials(
                              _username.text, _password.text);
                          if (resultado != null) {
                            if (resultado['rol_id'] == 4) {
                              //Navigator.pushNamed(context, '/bienvenido');
                              usuarioProvider.actualizarUsuario(Cliente(
                                  id: resultado['id'],
                                  nick: resultado['nickname'],
                                  rolid: resultado['rol_id'],
                                  pass: resultado['contrasena'],
                                  email: resultado['email'],
                                  usuarioid: resultado['usuario_id'],
                                  nombre: resultado['nombre'],
                                  apellidos: resultado['apellidos'],
                                  fechanacimiento:
                                      resultado['fecha_nacimiento'],
                                  sexo: resultado['sexo'],
                                  direccionempresa: resultado['direccion'],
                                  zonatrabajoid: resultado['zona_trabajo_id'],
                                  ruc: resultado['ruc'],
                                  saldobeneficios:
                                      resultado['saldo_beneficios'],
                                  ubicacion: resultado['ubicacion'],
                                  suscripcion: resultado['suscripcion'],
                                  dni: resultado['dni'],
                                  codigo: resultado['codigo'],
                                  nombreempresa:
                                      resultado['direccion_empresa']));
                              navigateToBienvenido();
                            } else if (resultado['rol_id'] == 2) {
                              usuarioProvider.actualizarUsuario(Empleado(
                                  id: resultado['id'],
                                  rolid: resultado['rol_id'],
                                  nick: resultado['nickname'],
                                  pass: resultado['contrasena'],
                                  email: resultado['email'],
                                  usuarioid: resultado['usuario_id'],
                                  nombre: resultado['nombres'],
                                  apellidos: resultado['apellidos'],
                                  fechanacimiento:
                                      resultado['fecha_nacimiento'],
                                  codigoempleado: resultado['codigo_empleado'],
                                  dni: resultado['dni']));
                              navigateToProgramacion();
                            } else if (resultado['rol_id'] == 5) {
                              usuarioProvider.actualizarUsuario(Conductor(
                                  id: resultado['id'],
                                  rolid: resultado['rol_id'],
                                  nick: resultado['nickname'],
                                  pass: resultado['contrasena'],
                                  email: resultado['email'],
                                  usuarioid: resultado['usuario_id'],
                                  nombre: resultado['nombres'],
                                  apellidos: resultado['apellidos'],
                                  fechanacimiento:
                                      resultado['fecha_nacimiento'],
                                  licencia: resultado['licencia'],
                                  dni: resultado['dni']));
                              navigateToBienvenidaConductor();
                            }
                          } else if (resultado == null) {
                            print(" Dentro del null");
                            print("${resultado}");
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Verificación"),
                                  content: Text("No existe el usuario"),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'OK'),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }

                          //print(data.rol_user);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          fixedSize: MaterialStateProperty.all(Size(350, 55)),
                        ),
                        child: Text("Iniciar Sesión",
                            style:
                                TextStyle(fontSize: 15, color: Colors.white)),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text("o continúa con"),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              print("oe");
                              User? user = await signInWithGoogle();
                              print("flag");
                              print(user);
                              if (user != null) {
                                print('Usuario autenticado con Google:');
                                print('UID: ${user.uid}');
                                print('Nombre: ${user.displayName}');
                                print('Correo Electrónico: ${user.email}');
                                print('${user.uid}');
                                // Resto de tu código...
                                navigateToBienvenido();
                              } else {
                                print(
                                    'Inicio de sesión con Google cancelado o error');
                              }
                              print("ooog");
                            },
                            child: Image.asset(
                              'lib/imagenes/google.png',
                              width: 50,
                              height: 50,
                            ),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          InkWell(
                            onTap: () {
                              print("face");
                            },
                            child: Image.asset(
                              'lib/imagenes/facebook.png',
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    ));
  }
}
