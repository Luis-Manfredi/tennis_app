import 'package:flutter/material.dart';

import '../views/welcome.dart';
import '../views/home.dart';
import '../views/reservations.dart';


class AppRouter {
  Route? onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case Welcome.id:
        return MaterialPageRoute(builder: (context) => const Welcome());
      case Home.id:
        return MaterialPageRoute(builder: (context) => const Home());
      case Reservations.id:
        return MaterialPageRoute(builder: (context) => const Reservations());  
      default:
        return null;
    }
  }
}