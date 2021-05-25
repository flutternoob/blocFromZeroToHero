import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/logic/cubits/internet_cubit.dart';
import 'package:flutter_counter_bloc/constants/enums.dart';
import 'package:flutter_counter_bloc/logic/cubits/counter_cubit.dart';
import 'package:flutter_counter_bloc/logic/functions/counter_functions.dart';

class SecondScreen extends StatefulWidget {
  final String? title;
  final Color? color;

  const SecondScreen({Key? key, this.title, this.color}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
        backgroundColor: widget.color!,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<InternetCubit, InternetState>(
                builder: (context, state) {
                  if (state is InternetConnected && state.connectionType == ConnectionType.Wifi){
                    return Text("Wifi");
                  }
                  else if (state is InternetConnected && state.connectionType == ConnectionType.Mobile){
                    return Text("Mobile");
                  }
                  else if (state is InternetDisconnected) {
                    return Text("Disconnected");
                  }
                  return CircularProgressIndicator();
                }
            ),
            BlocConsumer<CounterCubit, CounterState>(
                listener: (context, state) => snackBarFunction(state.wasIncremented!, context),
                builder: (context, state) => counterText(state.counterValue!, context)),
            SizedBox(height: 24),
            MaterialButton(
              onPressed: () => Navigator.of(context).pushNamed('/third'),
              color: Colors.greenAccent,
              child: Text("Go to Third Screen", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
