// ignore_for_file: prefer_const_constructors

import 'package:bloc_class/business_logic/cubit/counter_cubit.dart';
import 'package:bloc_class/presentation/screens/first_home_screen.dart';
import 'package:bloc_class/presentation/screens/home_screen.dart';
import 'package:bloc_class/presentation/screens/second_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  final CounterCubit _counterCubit = CounterCubit();

  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) =>
                FirstHomeScreen(title: 'Dart Screen', color: Colors.purple));
      case '/home':
        return MaterialPageRoute(
            builder: (_) =>
                HomeScreen(title: 'Home Screen', color: Colors.yellow));
      case '/second':
        return MaterialPageRoute(
            builder: (_) =>
                SecondScreen(title: 'Second Screen', color: Colors.green));
      default:
        return null;
    }
  }

  void dispose() {
    _counterCubit.close();
  }
}
