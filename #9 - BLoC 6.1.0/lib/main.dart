import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/logic/cubits/counter_cubit.dart';
import 'package:flutter_counter_bloc/logic/cubits/internet_cubit.dart';
import 'package:flutter_counter_bloc/presentation/router/app_router.dart';

void main() => runApp(MyApp(appRouter: AppRouter(), connectivity: Connectivity(),));

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