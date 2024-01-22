import 'package:flutter/material.dart';

class Historial extends StatefulWidget {
  const Historial({super.key});

  @override
  State<Historial> createState() => _Historial();
}

class _Historial extends State<Historial> {
  bool showNavigationRail = false;
  // Lista de datos de ejemplo para las tarjetas
  final List<Map<String, dynamic>> orders = [
    {
      'amount': 'S/ 15',
      'subtitle': 'pedido el 1/12/2023',
      'icon': Icons.local_drink_outlined,
      'subtitulo': 'recarga',
    },
    {
      'amount': 'S/ 20',
      'subtitle': 'pedido el 30/11/2023',
      'icon': Icons.local_drink_sharp,
      'subtitulo': 'bidon nuevo',
    },
    {
      'amount': 'S/ 30',
      'subtitle': 'pedido el 29/11/2023',
      'icon': Icons.local_drink_rounded,
      'subtitulo': 'promocion de 4x5',
    },
    // Puedes agregar más datos para las tarjetas
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis pedidos',style: TextStyle(fontFamily: 'Pacifico'),),
       // backgroundColor: Colors.lightBlueAccent,
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.blue,
            //Color.iop´+fromARGB(255, 240, 247, 248),
            child: Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(
                      orders[index]['icon'],
                      size: 77,
                      color: Colors.white,
                    ),
                    title: Text(
                      orders[index]['amount'],
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      orders[index]['subtitle'],
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(height: 5), // Espaciado entre los subtítulos
                  Center(
                    child: Text(
                      'Detalles del pedido:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Center(
                    child: Text(
                      orders[index]['subtitulo'],
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}