
//import 'package:app_final/components/empleado/rowicon_empleado.dart';
import 'package:app_final/components/empleado/supervision.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ArmadoRuta extends StatefulWidget {
  const ArmadoRuta({Key? key}) : super(key: key);

  @override
  State<ArmadoRuta> createState() => _ArmadoRutaState();
}

class _ArmadoRutaState extends State<ArmadoRuta> {



  
  final List<LatLng> routeCoordinates = [
    LatLng(-16.40521646629229, -71.57102099896395), // Puente Fatima
    LatLng(-16.409123, -71.537864), // Punto A
    LatLng(-16.408621, -71.538210), // Punto B
    LatLng(-16.387654, -71.542098), // Punto J
    LatLng(-16.400123, -71.540256), // Punto A
    LatLng(-16.394276, -71.551809), // Punto B
    LatLng(-16.408932, -71.523482), // Punto C
    LatLng(-16.420765, -71.515688), // Punto D
    LatLng(-16.389632, -71.525739), // Punto E
    LatLng(-16.404123, -71.558394), // Punto F
    LatLng(-16.397475, -71.512548), // Punto G
    LatLng(-16.416789, -71.530956), // Punto H
    LatLng(-16.411234, -71.555720), // Punto I
    LatLng(-16.387654, -71.542098), // Punto J
    LatLng(-16.415245, -71.534607), // Punto A
    LatLng(-16.404910, -71.547812), // Punto B
    LatLng(-16.400892, -71.525317), // Punto C
    LatLng(-16.408546, -71.517649), // Punto D
    LatLng(-16.420590, -71.527074), // Punto E
    LatLng(-16.399976, -71.540883), // Punto F
    LatLng(-16.413621, -71.554457), // Punto G
    LatLng(-16.394760, -71.530665), // Punto H
    LatLng(-16.409975, -71.549272), // Punto I
    LatLng(-16.389543, -71.517308), // Punto J
  ];

  double calculateTotalDistance(List<LatLng> coordinates) {
    double totalDistance = 0;

    for (int i = 0; i < coordinates.length - 1; i++) {
      totalDistance += distanceBetweenCoordinates(
        coordinates[i].latitude,
        coordinates[i].longitude,
        coordinates[i + 1].latitude,
        coordinates[i + 1].longitude,
      );
    }

    return totalDistance;
  }

  double distanceBetweenCoordinates(
      double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // Radio de la Tierra en kilómetros

    double dLat = _degreesToRadians(lat2 - lat1);
    double dLon = _degreesToRadians(lon2 - lon1);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c; // Distancia en kilómetros

    return distance;
  }

  double _degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }

  void sortCoordinates(List<LatLng> coordinates) {
    for (int i = 0; i < coordinates.length - 1; i++) {
      int minIndex = i;
      double minDistance = double.infinity;
      // Buscar la coordenada más cercana excluyendo las ya ordenadas
      for (int j = i + 1; j < coordinates.length; j++) {
        double distance = distanceBetweenCoordinates(
          coordinates[i].latitude,
          coordinates[i].longitude,
          coordinates[j].latitude,
          coordinates[j].longitude,
        );

        if (distance < minDistance) {
          minDistance = distance;
          minIndex = j;
        }
      }
      LatLng temp = coordinates[minIndex];
      coordinates[minIndex] = coordinates[i + 1];
      coordinates[i + 1] = temp;
    }
  }
 //// FUNCIONALIDADES SELECCION
 
 int detallepedido = 0;
  List<Widget> widgetList = [];




// Coordenadas de los puntos de inicio y destino
 /* final List<LatLng> routeCoordinates = [
    LatLng(-16.3988900, -71.5350000), // Punto de inicio
    LatLng(-16.4152, -71.5375), // Punto de destino
  ];
*/
  List<dynamic>respuesta =[];

  String apiPedidos =  'http://10.0.2.2:8004/api/pedido';
  
  void navigateToSupervision(){
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Supervision(),
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

  Future<dynamic>getPedidos() async{
    var res = await http.get(Uri.parse(apiPedidos),
    headers:{"Content-Type":"application/json"});
    if (res.statusCode == 200){
      var data = json.decode(res.body);
      respuesta = data;
    }


    print( json.decode(res.body));
    respuesta = json.decode(res.body);
    detallepedido = respuesta[0]['conductor_id'];
    print("----DETALLE");
    print(detallepedido);
    print("LENG-------------${respuesta.length}");
  }

  @override
  void initState(){
    super.initState();
    getPedidos();
  }

void crearWidget(double ancho, double largo) {
  //List <String> datos = [];
  List <dynamic> acceptedData = [];
  setState(() {
    widgetList.add(
      DragTarget<String>(
        builder: (BuildContext context, List<dynamic> accepted, List<dynamic> rejectedData) {
          return Container(
            margin: EdgeInsets.all(4),
            padding:EdgeInsets.all(3),
            height:  largo <= 865.6 ? 80 : 100,
            width: ancho <= 393.8 ? 120 :190,
            //color: Colors.purple,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color:Colors.cyan,width: 3)
            ),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Text("RUTA"),
                    Text('${acceptedData.join(" : ")}\n',
                      style: TextStyle(color: Colors.cyan, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        onWillAccept: (data) {
          // Lógica cuando se acerca al DragTarget
          return true; // Puedes personalizar la lógica según tus necesidades
        },
        onAccept: (data) {
          // Lógica cuando el Draggable se suelta en el DragTarget
          setState(() {
            acceptedData.add(data);
          });
          print('Widget aceptado. Datos: $data');
        },
      ),
    );
    print('Widget creado. Total de widgets en la lista: ${widgetList.length}');
  });
}


  
 
  @override
  Widget build(BuildContext context) {

    //DIMENSIONES
    final anchoActual = MediaQuery.of(context).size.width;
    final largoActual = MediaQuery.of(context).size.height;

    sortCoordinates(routeCoordinates);

    // Añadir una nueva coordenada a la lista después de ordenarla
    routeCoordinates.add(routeCoordinates.first);

    

    List<Marker> markers = [];
    for (LatLng coordinate in routeCoordinates) {
      markers.add(
        Marker(
          width: 40.0,
          height: 40.0,
          point: coordinate,
          child: Container(
            child: Icon(
              Icons.flutter_dash_sharp,
              color: Colors.black,
              size: 40.0,
            ),
          ),
        ),
      );
    }

// ANCHO  : 480
// LARGO : 989.33333
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Armado de Rutas',style: TextStyle(fontFamily: 'Pacifico'),)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Container(
                height: largoActual  <= 865.6 ? 200 : 300,//400,
                width: anchoActual <=393.8 ? 300 :400,//double.infinity,
                //padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                //  color:const Color.fromARGB(255, 184, 212, 0)
                ),
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: LatLng(-16.40521646629229,
                        -71.57102099896395), // Centro del mapa (California)
                    initialZoom: 12.0, // Nivel de zoom
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      //subdomains: ['a', 'b', 'c'],
                    ),
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: routeCoordinates,
                          color: Colors.lightBlueAccent, // Color de la línea
                          strokeWidth: 3.0, // Ancho de la línea
                        ),
                      ],
                    ),
                    MarkerLayer(markers: markers),
                  ],
                ),
              ),

              /*Container(
                margin: EdgeInsets.only(top:20,left: 20),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Distancia Total: ${totalDistance.toStringAsFixed(2)} km',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),*/
              
          
          
              /// SELECCION DE RUTAS
              Row(
                    mainAxisAlignment: anchoActual > 393.8 ? MainAxisAlignment.spaceAround : MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text("Rutas",style:TextStyle(fontFamily: 'Pacifico'),),
                          Row(
                            children:
                            [
                            ElevatedButton(onPressed:(){setState(() {
                              crearWidget(anchoActual,largoActual);
                            });}, child: Text("Crear",style: TextStyle(color:Colors.white),),
                              style:ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.blueAccent
                              ),
                              
                            ),),
                           // const SizedBox(width: 10,),
                            ElevatedButton(onPressed:(){setState(() {
                              if(widgetList.isNotEmpty){widgetList.removeLast();}
                            });}, child: Text("Destruir"),
                              style:ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.amberAccent),
                              
                            ),),
                            
                           ],
                          ),                      
                        ]
                      ),
          
                      //const SizedBox(width:10,),
                     Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Text("Pedidos",style:TextStyle(fontFamily: 'Pacifico'),),
                            
                             
                           ],
                         ),
                         
                          
                        
                      
                    ],

                  ),


                  const SizedBox(height: 20,),
          
                  // CONTENIDO
                  Expanded(
                    
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
          
          
                          // Primera Columna
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children:[
                                // ESTE CONTAINER ES EL ANCHO PREDERTERMINADO
                                Container(
                                  height: largoActual  <= 865.6 ? 5 : 10,
                                  width:anchoActual <= 393.8 ? 150 : 180,// 200,
                                 // color: Colors.pink,
                                ),
                                ...widgetList,
          
                              ]
                             
                            ),
                          ),
          
                          // Segunda Columna
                          const SizedBox(width: 20,),
                   
                          SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          
                            child: Column(
                              children: respuesta.map((e) =>
                          
                                LongPressDraggable<String>(
                                  data: "${e['id']},${e['monto_total']}", // Datos que se enviarán cuando se inicie el arrastre
             
                                  feedback: Container(
                                    width:anchoActual<=393.8 ? 120: 190,
                                    height: largoActual <=865.6 ? 80:100,
                                    padding: EdgeInsets.all(10),
                                    color: const Color.fromARGB(255, 251, 152, 152),
                                    child: Column(
                                      children: [
                                        Text("Pedido N°: ${e['id']}",maxLines:1 , style: TextStyle(fontSize: 15, color: Colors.white)),
                                        Text("${e['monto_total']}",maxLines: 1,style: TextStyle(fontSize: 15, color: Colors.white)),
                                        Text("${e['fecha']}",maxLines: 1,style: TextStyle(fontSize: 15, color: Colors.white)),
                                        Text("${e['direccion']}",maxLines: 1,style: TextStyle(fontSize: 15, color: Colors.white)),
                                        
                                      ],
                                      
                                    ),
                                  ),
                                  
                                  child: Container(
                                  width:anchoActual<=393.8 ? 120: 190,
                                    height: largoActual <=865.6 ? 80:100,
                                 margin: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    border:Border.all(color: Colors.blue,width: 2),
                                    borderRadius: BorderRadius.circular(20)
                                    
                                  ),
                                    //color: const Color.fromARGB(255, 64, 232, 251),
                                    child: Column(
                                      children: [
                                        Text("Pedido N°: ${e['id']}", style: TextStyle(fontSize: 18,color:Colors.blue)),
                                        Text("${e['monto_total']}"),
                                        Text("${e['fecha']}"),
                                        Text("${e['direccion']}"),
                                        
                                        //Container(height: 10, color: Colors.white)
                                      ],
                                    ),
                                  ),
                                ),
                              ).toList(),
                              
                            ),
                          ),
          
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 60,),
                  ElevatedButton(onPressed:(){
                    navigateToSupervision();
                  }, 
                  child: Text("Confirmar",style: TextStyle(fontSize:19,color:Colors.white),),
                  style:ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    fixedSize: MaterialStateProperty.all(Size(anchoActual <= 393.8 ? 200 : 350,largoActual <= 865.6 ? 20 : 50)),
                   ),
                  ),
                  SizedBox(height: 60,),
          
            ],
          ),
        ),
      ),
    );
  }
}