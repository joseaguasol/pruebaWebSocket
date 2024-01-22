import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Formu extends StatefulWidget {
  const Formu({super.key});

  @override
  State<Formu> createState() => _FormuState();
}

class _FormuState extends State<Formu> {
  @override
  Widget build(BuildContext context) {
    //final TabController _tabController = TabController(length: 2, vsync: this);
    TextEditingController _fechaController = TextEditingController();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10,left: 20),
                      //color:Colors.grey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(child: const Text("Me encantaría",
                              style: TextStyle(color:const Color.fromARGB(255, 0, 57, 103),
                              fontSize: 35,fontWeight: FontWeight.w300),)),
                              Container(child: const Text("saber de ti",
                              style: TextStyle(fontSize: 35,color:Color.fromARGB(255, 0, 41, 72)),)),
                              
                            ],
                          ),
                          
                          Container(
                            margin: const EdgeInsets.only(right:50),
                            height: 100,
                            width: 100,
                            child: Lottie.asset('lib/imagenes/Animation - 1701877289450.json'),
                          ),
                        ],
                      ),
                    )
                    ,
                    const SizedBox(height: 20,),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      height: 500,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(20),
                        border: Border.all(
                          width: 2,
                          color: const Color.fromARGB(255, 2, 72, 129),
                          
                        )
                      ),
                    //color:Colors.cyan,
                      child: ListView(
                        
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            width: 350,
                            height: 70,
                            child: TextField(
                              //controller: _username,
                              style:const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 1, 41, 75)
                                ),
                              decoration:const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "Nombres",
                                labelStyle: TextStyle(
                                  color:Color.fromARGB(255, 0, 48, 87),
                                  fontSize: 14
                                ),
                               // enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)),borderSide: BorderSide(color: Colors.blueAccent)),
                                //focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)),borderSide: BorderSide(color: Colors.blueAccent))
                              ),
                            ),
                          ),
                           Container(
                            padding: const EdgeInsets.all(8),
                            width: 350,
                            height: 70,
                            child: TextField(
                              //controller: _username,
                              style:const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 1, 41, 75)
                                ),
                              decoration:const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "Apellidos",
                                labelStyle: TextStyle(
                                  color:Color.fromARGB(255, 0, 48, 87),
                                  fontSize: 14
                                ),
                               // enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)),borderSide: BorderSide(color: Colors.blueAccent)),
                                //focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)),borderSide: BorderSide(color: Colors.blueAccent))
                              ),
                            ),
                          ),
                           Container(
                            padding: const EdgeInsets.all(8),
                            width: 350,height: 70,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              //controller: _username,
                              style:const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 1, 41, 75)
                                ),
                              decoration:const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "RUC (opcional)",
                                labelStyle: TextStyle(
                                  color:Color.fromARGB(255, 0, 48, 87),
                                  fontSize: 14
                                ),
                               // enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)),borderSide: BorderSide(color: Colors.blueAccent)),
                                //focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)),borderSide: BorderSide(color: Colors.blueAccent))
                              ),
                            ),
                          ),
                           Container(
                            padding: const EdgeInsets.all(8),
                            width: 350,height: 70,
                            child: TextField(
                              keyboardType: TextInputType.streetAddress,
                              //controller: _username,
                              style:const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 1, 41, 75)
                                ),
                              decoration:const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "Dirección",
                                labelStyle: TextStyle(
                                  color:Color.fromARGB(255, 0, 48, 87),
                                  fontSize: 14
                                ),
                               // enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)),borderSide: BorderSide(color: Colors.blueAccent)),
                                //focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)),borderSide: BorderSide(color: Colors.blueAccent))
                              ),
                            ),
                          ),
                           Container(
                              padding: const EdgeInsets.all(8),
                              width: 350,
                              height: 70,
                              child: TextFormField(
                                readOnly: true,
                                controller: _fechaController, // Usa el controlador de texto
                                onTap: () async {
                                  // Abre el selector de fechas cuando se hace clic en el campo
                                  DateTime? fechaSeleccionada = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1970),
                                    lastDate: DateTime(2101),
                                  );

                                  if (fechaSeleccionada != null) {
                                    // Actualiza el valor del campo de texto con la fecha seleccionada
                                    _fechaController.text =
                                        "${fechaSeleccionada.day}/${fechaSeleccionada.month}/${fechaSeleccionada.year}";
                                  }
                                },
                                keyboardType: TextInputType.datetime,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 255, 255, 255),
                                  labelText: "Fecha",
                                  labelStyle: TextStyle(
                                    color: Color.fromARGB(255, 0, 48, 87),
                                    fontSize: 14
                                  ),
                                ),
                              ),
                            ),

                           Container(
                            padding: const EdgeInsets.all(8),
                            width: 350,height: 70,
                            child: TextField(
                              //controller: _username,
                              keyboardType: TextInputType.phone,
                              style:const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 1, 41, 75)
                                ),
                              decoration:const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "Celular",
                                labelStyle: TextStyle(
                                  color:Color.fromARGB(255, 0, 48, 87),
                                  fontSize: 14
                                ),
                               // enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)),borderSide: BorderSide(color: Colors.blueAccent)),
                                //focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)),borderSide: BorderSide(color: Colors.blueAccent))
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            width: 350,height: 70,
                            child: TextField(
                              //controller: _username,
                              style:const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 1, 41, 75)
                                ),
                              decoration:const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "Email(opcional)",
                                labelStyle: TextStyle(
                                  color:Color.fromARGB(255, 0, 48, 87),
                                  fontSize: 14
                                ),
                               // enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)),borderSide: BorderSide(color: Colors.blueAccent)),
                                //focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)),borderSide: BorderSide(color: Colors.blueAccent))
                              ),
                            ),
                          ),
                          
                          
                        
                        ],
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      height: 60,
                      width: 150,
                      child: ElevatedButton(
                        onPressed: (){},
                        child: Text("Listo !",style: TextStyle(
                          fontSize: 20,
                          color:Colors.white),),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 3, 66, 117))
                        ),
                      ),
                    )
                    
                    ],
                )
            )
        )
    );
  }
}