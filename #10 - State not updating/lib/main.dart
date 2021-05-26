import 'package:flutter/material.dart';
// import 'package:equatable/equatable.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/logic/cubits/counter_cubit.dart';
import 'package:flutter_counter_bloc/logic/cubits/internet_cubit.dart';
import 'package:flutter_counter_bloc/logic/cubits/settings_cubit.dart';
import 'package:flutter_counter_bloc/presentation/router/app_router.dart';

// class MyClass extends Equatable {
//   final int? value;
//   MyClass({this.value});
//
//   @override
//   List<Object> get props => [value!];
// }

void main() {
  // final a = MyClass(value: 1);
  // final b = MyClass(value: 2);
  //
  // print("a == b ${a == b}");
  // print("a == a ${a == a}");
  // print("b == b ${b == b}");

  runApp(MyApp(appRouter: AppRouter(), connectivity: Connectivity(),));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final Connectivity? connectivity;

  MyApp({Key? key, required this.appRouter, required this.connectivity}) : super(key: key);

  @override
  Widget build(BuildContext myAppContext) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (internetCubitContext) => InternetCubit(connectivity: connectivity),
        ),
        BlocProvider<CounterCubit>(
          create: (counterCubitContext) => CounterCubit(internetCubit: BlocProvider.of<InternetCubit>(counterCubitContext)),
        ),
        BlocProvider<SettingsCubit>(
          create: (settingsCubitContext) => SettingsCubit()
        )
      ],
      child: MaterialApp(
        title: "Flutter Demo",
        theme: ThemeData(
          primaryColor: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: appRouter.onGeneratedRoute,
      ),
    );
  }
}