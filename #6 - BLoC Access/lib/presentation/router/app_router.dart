import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_counter_bloc/logic/cubits/counter_cubit.dart';
import 'package:flutter_counter_bloc/presentation/screens/home_screen.dart';
import 'package:flutter_counter_bloc/presentation/screens/second_screen.dart';
import 'package:flutter_counter_bloc/presentation/screens/third_screen.dart';

class AppRouter {
  final CounterCubit _counterCubit = CounterCubit();

  Route? onGeneratedRoute(RouteSettings? routeSettings) {
    //Object key = routeSettings!.arguments!;
    switch (routeSettings!.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) =>
                BlocProvider.value(
                  value: _counterCubit,
                  child: HomeScreen(
                    title: "Home Screen",
                    color: Colors.blueAccent,
                  ),
                )
        );
      case '/second':
        return MaterialPageRoute(
            builder: (_) =>
                BlocProvider.value(
                  value: _counterCubit,
                  child: SecondScreen(
                    title: "Second Screen",
                    color: Colors.redAccent,
                  ),
                )
        );
      case '/third':
        return MaterialPageRoute(
            builder: (_) =>
                BlocProvider.value(
                  value: _counterCubit,
                  child: ThirdScreen(
                    title: "Third Screen",
                    color: Colors.greenAccent,
                  ),
                )
        );
      default:
        return null;
    }
  }

  void dispose() {
    _counterCubit.close();
  }
}
