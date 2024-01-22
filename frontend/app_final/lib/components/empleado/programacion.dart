import 'package:app_final/components/empleado/armadoruta.dart';
import 'package:flutter/material.dart';
import 'package:app_final/components/empleado/rowproduct_empleado.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


final List<String> list = <String>['Cerro C.', 'Sachaca', 'Yanahuara', 'Cayma'];

class Producto {
  final int id;
  final String nombre;
  final int precio;
  final String descripcion;
  final String imagen;
  final int stock;
   final TextEditingController cantidadController;

  Producto({
    this.id =0,
    this.nombre='',
    this.precio =0,
    this.descripcion = '',
    required this.imagen,
    this.stock = 0,
    required this.cantidadController,//=TextEditingController(),
  });
}

class Programacion extends StatefulWidget{
  const Programacion({super.key});

  @override
  State<Programacion> createState() => _Programacion();
}
class _Programacion extends State<Programacion>{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _nombres = TextEditingController();
  final TextEditingController _apellidos = TextEditingController();
  final TextEditingController _telefono = TextEditingController();
  final TextEditingController _direccion = TextEditingController();
  //final TextEditingController _ubicacion = TextEditingController();
  int contador = 0;

  String dropdownValue = list.first;
  String apiProduct = 'https://aguasol.onrender.com/api/products';
  
  List <Producto> newproduct = [];
  Future<dynamic> getProducts()async{
    var res = await http.get(Uri.parse(apiProduct), headers: {"Content-Type": "application/json"});
    if (res.statusCode == 200) {
        var data = json.decode(res.body);
        print("dATA-----------${data}");
        setState(() {
          newproduct = List<Producto>.from(data.map((item) {
            return Producto(
              id: item['id'],
              nombre: item['nombre']??'',
              precio: item['precio'],
              descripcion: item['descripcion'],
              stock: item['stock'],
              imagen: 'lib/imagenes/RECARGA.png',
              cantidadController: TextEditingController(),
            );
          }));
        });
      }
  }

  void navigateToPedidos(){
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ArmadoRuta(),
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
  void initState(){
    super.initState();
    getProducts();

  }
  
 @override
 Widget build (BuildContext context){
  
  //DIMENSIONES
  final mediaQuery = MediaQuery.of(context);
  final screenWidth = mediaQuery.size.width;
   //DIMENSIONES
    final anchoActual = MediaQuery.of(context).size.width;
    final largoActual = MediaQuery.of(context).size.height;

  return Scaffold(
    key: _scaffoldKey,
    appBar: AppBar(title: Align(
                      alignment:Alignment.center,
                      child:Text("Bienvenido - Colaborador",style:TextStyle(fontSize:20,fontFamily: 'Pacifico'),)
                     ),
                     leading:IconButton(icon:Icon(Icons.menu),onPressed:(){
                        _scaffoldKey.currentState?.openDrawer();
                     }),
                     ),
    body: SafeArea(
        child:Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [

                    const SizedBox(height: 20,),
                    const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Programación de Pedidos  Vía Telefónica",
                      //textAlign: TextAlign.right,
                      style: TextStyle(color:Colors.grey,fontSize: 20, fontFamily: 'Pacifico'),
                      ),
                    ),
                    SizedBox(height: 20,),
                    const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Información del Cliente",
                      //textAlign: TextAlign.right,
                      style: TextStyle(color:Colors.grey,fontSize: 20, fontFamily: 'Pacifico'),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    TextField(
                      controller: _nombres,
                      style: TextStyle(fontSize: 15,fontWeight:FontWeight.w400,color: Colors.black),
                          decoration: InputDecoration(
                            labelText: "Nombres",
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)),borderSide: BorderSide(color: Colors.blueAccent)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)),borderSide: BorderSide(color: Colors.blue),),
                      ),
                    ),
                     const SizedBox(height: 20,),
                    TextField(
                      controller: _apellidos,
                      style: TextStyle(fontSize: 15,fontWeight:FontWeight.w400,color: Colors.black),
                          decoration: InputDecoration(
                            labelText: "Apellidos",
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)),borderSide: BorderSide(color: Colors.blueAccent)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)),borderSide: BorderSide(color: Colors.blue),),
                      ),
                    ),
                     const SizedBox(height: 20,),
                    
                     //const SizedBox(height: 20,),
                     Row(children: [
                      Container(
                      width: 60,
                      child: DropdownMenu<String>(
                        initialSelection: list.first,
                        onSelected: (String ? value){
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
                          return DropdownMenuEntry<String>(value: value, label: value);
                        }).toList(),  
                      ),
                    ),
                    const SizedBox(width: 110,),
                    Container(
                        width: 100,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _telefono,
                        style: TextStyle(fontSize: 15,fontWeight:FontWeight.w400,color: Colors.black),
                            decoration: InputDecoration(
                              labelText: "Teléfono",
                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)),borderSide: BorderSide(color: Colors.blueAccent)),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)),borderSide: BorderSide(color: Colors.blue),),
                        ),
                      ),
                    ),
                    const SizedBox(width:5,),
                    Container(
                      width: 165,
                      child: TextField(
                        controller: _direccion,
                        style: TextStyle(fontSize: 15,fontWeight:FontWeight.w400,color: Colors.black),
                            decoration: InputDecoration(
                              labelText: "Dirección",
                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)),borderSide: BorderSide(color: Colors.blueAccent)),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)),borderSide: BorderSide(color: Colors.blue),),
                        ),
                      ),
                    ),
                     const SizedBox(width: 8,),
         
                    ],),
                     
                    
            
            
                    const SizedBox(height: 20,),
                    Align(
                      alignment:Alignment.centerLeft,
                      child:Text("Información del Pedido",style:TextStyle(fontSize:20,fontFamily: 'Pacifico'),)
                     ),
                     
                    const SizedBox(height: 30,),
                    Expanded(
                      child: ListView.builder(
                            itemCount: newproduct.length,
                            itemBuilder: (context, index){
                              return ProductCustomEmpleado(
                                image: 'lib/imagenes/BIDON20.png',
                                cantidadController:newproduct[index].cantidadController,
                                nombre: newproduct[index].nombre,
                               precio: newproduct[index].precio,
                                
                              
                            );
                            },
                          
                            
                          
                        ),
                    ),
                    ElevatedButton(
                      onPressed:(){
                        navigateToPedidos();
                      },
                      child: Text("Programar Pedido",style:TextStyle(color: Colors.white,fontSize:22),),
                      style:ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    fixedSize: MaterialStateProperty.all(Size(anchoActual <= 393.8 ? 180 : 250,largoActual <= 865.6 ? 20 : 50)),
                   ),
                    ),

              
            ],
          ),
          

        ),
      ),
    drawer: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Menú'),
          ),
          ListTile(
            title: Text('Opción 1'),
            onTap: () {
              // Lógica cuando se selecciona la opción 1
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Opción 2'),
            onTap: () {
              // Lógica cuando se selecciona la opción 2
              Navigator.pop(context);
            },
          ),
          ElevatedButton(onPressed: (){
            Navigator.pushReplacementNamed(context, '/loginsol');
          }, child:Text("Salir"))
          // Agregar más elementos según sea necesario
        ],
      ),
    ),
    );
 }

}



