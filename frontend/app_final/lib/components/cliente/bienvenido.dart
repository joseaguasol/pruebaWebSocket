import 'package:app_final/components/cliente/promocion.dart';
import 'package:flutter/material.dart';
import 'package:app_final/components/cliente/productos.dart';

class Bienvenido extends StatefulWidget {
  const Bienvenido({Key? key}) : super(key: key);

  @override
  State<Bienvenido> createState() => _Bienvenido();
}

class _Bienvenido extends State<Bienvenido> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

 //final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
 void navigateToProductos(){
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Productos(),
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

  void navigatePromos(){
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Promocion(),
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
  Widget build(BuildContext context) {
    //Color miColor = Color(0xFFD6F635);
    return Scaffold(
     // backgroundColor: Color.fromARGB(255, 222, 242, 161),
     
      key: _scaffoldKey,
      body: SafeArea(
        
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            children: [
              Center(
                child: Column(
                  children: [
                    Text("Agua Sol",style: TextStyle(color:const Color.fromARGB(255, 32, 143, 233),fontSize:45,fontFamily:'Pacifico',fontWeight: FontWeight.w100),),
                    SizedBox(height: 8,),
                    Text("Llevando vida a tu hogar",style: TextStyle(fontFamily: 'Pacifico',color:Color.fromARGB(255, 6, 34, 24),fontSize:15,fontWeight: FontWeight.w400),textAlign:TextAlign.right,),
                    SizedBox(height: 8,),
                    
                    Text("Promociones",style: TextStyle(fontFamily: 'Pacifico',color:const Color.fromARGB(255, 32, 143, 233),fontSize:25,fontWeight: FontWeight.w400),textAlign:TextAlign.right,),

                   // SizedBox(height: 20,),

                    Container(
                      
                      //width: 340,
                      height:350,
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        //color: Color.fromARGB(255, 202, 222, 89),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child:GestureDetector(
                        onTap: (){
                          navigatePromos();
                          //Navigator.push(context,MaterialPageRoute(builder: (context)=>Promocion()));
                        },

                        child: ListView(
                          // This next line does the trick.
                          scrollDirection: Axis.horizontal,
                          children:[
                            const SizedBox(width: 20,),
                            Container(
                              child: Image.asset('lib/imagenes/bodegon.png',height: 380,),
                              width: 450,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color:Colors.white
                              ),
                              //color: Colors.red,
                            ),
                            const SizedBox(width: 20,),
                            Container(
                              child: Image.asset('lib/imagenes/bodegon.png',height: 380,),
                              width: 450,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color:Colors.white
                              ),
                            ),
                            const SizedBox(width: 20,),
                        
                            Container(
                              child: Image.asset('lib/imagenes/bodegon.png',height: 380,),
                              width: 450,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color:Colors.white
                              ),
                            ),
                            const SizedBox(width: 20,),
                            Container(
                              child: Image.asset('lib/imagenes/bodegon.png',height: 300,),
                              width: 450,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color:Colors.white
                              ),
                            ),
                            const SizedBox(width: 20,),
                            Container(
                              child: Image.asset('lib/imagenes/bodegon.png',height: 300,),
                              width: 450,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color:Colors.white
                              ),
                            ),
                          ],
                        ),
                      ),),

                     SizedBox(height: 20,),
                    Text("Productos",style: TextStyle(fontFamily: 'Pacifico',color: const Color.fromARGB(255, 32, 143, 233),fontSize:20,fontWeight: FontWeight.w400),),
                    //SizedBox(height: 20,),

                    // PRODUCTOS
                    InkWell(
                      onTap: (){
                        navigateToProductos();
                      },
                      child: Container(
                        height: 150,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 93, 243, 33),
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: AssetImage('lib/imagenes/tranquilidad.png'),  // Reemplaza con la ruta de tu imagen
                            fit: BoxFit.cover,
                          )
                        ),
                        child: Row(
                          children: [
                           Image.asset('lib/imagenes/BIDON20.png',width:130,),
                           Image.asset('lib/imagenes/BIDON7.png',width:100,),
                           Image.asset('lib/imagenes/BIDON03.png',width:100,),
                           Image.asset('lib/imagenes/BIDON0.png',width:100,),


                           //Image.asset('lib/imagenes/bodegoncito.jpg',width:300,),
                          ],
                        ),
                      ),
                    ),
                   
                     SizedBox(height: 30,),
                    Text("Saldo Beneficiario",style: TextStyle(fontFamily: 'Pacifico',color: const Color.fromARGB(255, 32, 143, 233),fontSize:20,fontWeight: FontWeight.w400),),
                    //SizedBox(height: 20,),


                    /// MONEDERO
                    Container(
                      //width: 340,
                      height:150,
                      decoration: BoxDecoration(
                      color: Color.fromARGB(255, 32, 143, 233),
                      borderRadius: BorderRadius.circular(25)
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                      const  SizedBox(width:10,),
                      Text("Acumulaste: S/. 100.00",style: TextStyle(fontFamily: 'Pacifico',color:Colors.white,fontSize:25,fontWeight: FontWeight.w400),),
                      const  SizedBox(width:50,),
                      Icon(Icons.savings_outlined,size: 68,color: Colors.white,),
                    const SizedBox(width: 20,)
                    ],),),
                    SizedBox(height: 20,),
                   

                  ],
                ),
              ),

              // Icono superpuesto
              Positioned(
                top: 10,
                left: 10,
                child: GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(
                      color: Colors.white,
                      Icons.menu,
                      size: 45,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            
            ListTile(
              title: Text('Opción 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Opción 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 200,),
            ElevatedButton(onPressed: (){
               Navigator.pushReplacementNamed(context, '/loginsol');
            }, child:Text("Salir")),
          ],
        ),
      ),
    );
  }
}
