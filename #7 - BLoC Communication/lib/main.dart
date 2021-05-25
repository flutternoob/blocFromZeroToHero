import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/logic/cubits/counter_cubit.dart';
import 'package:flutter_counter_bloc/logic/cubits/internet_cubit.dart';
import 'package:flutter_counter_bloc/presentation/router/app_router.dart';

void main() => runApp(MyApp(appRouter: AppRouter(), connectivity: Connectivity(),));

class MyApp extends StatefulWidget {
  final AppRouter appRouter;
  final Connectivity? connectivity;

  MyApp({Key? key, required this.appRouter, required this.connectivity}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity: widget.connectivity),
        ),
        BlocProvider<CounterCubit>(
          create: (context) => CounterCubit(internetCubit: BlocProvider.of<InternetCubit>(context)),
        )
      ],
      child: MaterialApp(
        title: "Flutter Demo",
        theme: ThemeData(
          primaryColor: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: widget.appRouter.onGeneratedRoute,
      ),
    );
  }
}
