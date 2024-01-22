class Usuario {
  int id;
  int rolid;
  String nick;
  String pass;
  String email;

  Usuario({
    required this.id,
    required this.rolid,
    required this.nick,
    required this.pass,
    required this.email,
  });

  int getid() => 0;
  String getNombre() => '';
}

class Cliente extends Usuario {
  // Propiedades específicas del Cliente
  int usuarioid = 0;
  String nombre;
  String apellidos;
  String fechanacimiento;
  String sexo;
  String dni;
  String codigo;
  int saldobeneficios=0;
  String direccionempresa;
  String suscripcion;
  String ubicacion;
  String ruc;
  String nombreempresa;
  int zonatrabajoid = 0;

  Cliente({
    required int id,
    required int rolid,
    required String nick,
    required String pass,
    required String email,
    required this.usuarioid,
    required this.nombre,
    required this.apellidos,
    required this.fechanacimiento,
    required this.sexo,
    required this.dni,
    required this.codigo,
    required this.saldobeneficios,
    required this.direccionempresa,
    required this.suscripcion,
    required this.ubicacion,
    required this.ruc,
    required this.nombreempresa,
    required this.zonatrabajoid,
  }) : super(id: id, rolid: rolid,nick: nick, pass:pass, email: email);

  @override
  int getid() => id;

  @override
  String getNombre() => nombre;
}



class Empleado extends Usuario {
  // Propiedades específicas del Empleado
  int usuarioid = 0;
  String nombre;
  String apellidos;
  String dni;
  String fechanacimiento;
  String codigoempleado;

  Empleado({
   required int id,
    required int rolid,
    required String nick,
    required String pass,
    required String email,
    required this.usuarioid,
    required this.nombre,
    required this.apellidos,
    required this.fechanacimiento,
    required this.codigoempleado,
    required this.dni,
    
  }) : super(id: id, rolid: rolid, nick:nick,pass:pass, email: email);
}

class Conductor extends Usuario {
  // Propiedades específicas del Conductor
  int usuarioid = 0;
  String nombre;
  String apellidos;
  String dni;
  String fechanacimiento;
  String licencia;

  Conductor({
   required int id,
    required int rolid,
    required String nick,
    required String pass,
    required String email,
    required this.usuarioid,
    required this.nombre,
    required this.apellidos,
    required this.fechanacimiento,
    required this.licencia,
    required this.dni,
    
  }) : super(id: id, rolid: rolid, nick:nick,pass:pass, email: email);
}
