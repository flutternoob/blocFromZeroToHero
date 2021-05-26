import 'package:flutter/material.dart';
import 'package:flutter_counter_bloc/presentation/screens/home_screen.dart';
import 'package:flutter_counter_bloc/presentation/screens/second_screen.dart';
import 'package:flutter_counter_bloc/presentation/screens/third_screen.dart';
import 'package:flutter_counter_bloc/presentation/screens/settings_screen.dart';

class AppRouter {
  Route? onGeneratedRoute(RouteSettings? routeSettings) {
    switch (routeSettings!.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => HomeScreen(
              title: "Home Screen",
              color: Colors.blueAccent,
            )
        );
      case '/second':
        return MaterialPageRoute(
            builder: (_) => SecondScreen(
              title: "Second Screen",
              color: Colors.redAccent,
            )
        );
      case '/third':
        return MaterialPageRoute(
            builder: (_) => ThirdScreen(
              title: "Third Screen",
              color: Colors.greenAccent,
            )
        );
      case '/settings':
        return MaterialPageRoute(
            builder: (_) => SettingsScreen()
        );
      default:
        return null;
    }
  }
}