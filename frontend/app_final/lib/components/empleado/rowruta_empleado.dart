import 'package:flutter/material.dart';

class RutaCustomEmpleado extends StatelessWidget {
  final String image;
  final String nombre;
  final int precio;
  final TextEditingController cantidadController;

  const RutaCustomEmpleado({
    Key? key, // Usé "Key?" en lugar de "super.key" para evitar advertencias de null safety
    required this.nombre,
    required this.precio,
    required this.image,
    required this.cantidadController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 50, // Establecí un ancho fijo para la imagen
            child: Image.asset(image),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    nombre,
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    "S/.${precio}",
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 95,
            child: TextField(
              keyboardType: TextInputType.number,
              controller: cantidadController,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
              decoration: InputDecoration(
                labelText: "Cantidad",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
