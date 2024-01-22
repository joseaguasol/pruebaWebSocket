// usuario_provider.dart
import 'package:flutter/foundation.dart';
import 'package:app_final/provider/usuarios_model.dart';

class UsuarioProvider with ChangeNotifier {
  Usuario usuarioActual = Usuario(id: 0,nick: '',pass: '',rolid: 0,email: '');
  
  Usuario get getusuarioActual => usuarioActual;

  void actualizarUsuario(Usuario nuevoUsuario) {
    print("------DENTRO DE PROVIDER------");
    print("nuevo usuario es--> ${nuevoUsuario}");
    print("-----------------------------------");
    usuarioActual = nuevoUsuario;
    notifyListeners();
  } 
}