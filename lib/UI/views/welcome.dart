import 'package:flutter/material.dart';

import '../components/clipper.dart';
import '../constants/colors.dart';
import 'home.dart';


class Welcome extends StatelessWidget {
  const Welcome({super.key});

  static const id = 'Bienvenida';

  @override
  Widget build(BuildContext context) {

    String description = 'Con esta aplicación podrás hacer tus reservaciones a nuestras canchas de tenis de manera fácil y rápida.';

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              // Background image with custom clipper
              Stack(
                children: [
                  ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.75,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/tennis_court.png'), 
                          fit: BoxFit.cover,
                        )
                      ),
                    ),
                  ),
                  ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.75,
                      width: MediaQuery.of(context).size.width,
                      color: white.withOpacity(0.5),
                    ),
                  )
                ],
              ),

              // Gradient container with custom clipper
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  height: 266,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primary, secondary],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight
                    )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text('¡Bienvenido!', style: TextStyle(color: white, fontSize: 46)),
                      const SizedBox(height: 10),
                      Text(description, style: TextStyle(fontSize: 16, color: white))
                    ],
                  ),
                )
              )
            ],
          ),

          // Text and button with icon
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Continua para realizar tu reservación y así disfrutar de nuestras instalaciones', 
                  style: TextStyle(color: lightText, fontSize: 16),
                  textAlign: TextAlign.end,
                ),
                const SizedBox(height: 20),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      colors: [primary, secondary],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight
                    )
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pushNamed(context, Home.id),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ), 
                    label: Icon(Icons.arrow_forward_ios_rounded, color: white), 
                    icon: Text('Continuar', style: TextStyle(color: white, fontSize: 20))
                  ),
                ),
                const SizedBox(height: 20)
              ],
            ),
          )
        ],
      ),
    );
  }
}