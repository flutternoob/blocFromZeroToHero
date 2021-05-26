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
                builder: (internetCubitBuilderContext, state) {
                  if (state is InternetConnected && state.connectionType == ConnectionType.Wifi){
                    return Text(
                        "Wifi",
                        style: Theme.of(internetCubitBuilderContext).textTheme.headline3!.copyWith(color: Colors.green)
                    );
                  }
                  else if (state is InternetConnected && state.connectionType == ConnectionType.Mobile){
                    return Text(
                        "Mobile",
                        style: Theme.of(internetCubitBuilderContext).textTheme.headline3!.copyWith(color: Colors.red)
                    );
                  }
                  else if (state is InternetDisconnected) {
                    return Text(
                        "Disconnected",
                        style: Theme.of(internetCubitBuilderContext).textTheme.headline3!.copyWith(color: Colors.grey)
                    );
                  }
                  return CircularProgressIndicator();
                }
            ),
            Divider(height: 5),
            BlocConsumer<CounterCubit, CounterState>(
                listener: (counterCubitListenerContext, state) => snackBarFunction(state.wasIncremented!, counterCubitListenerContext),
                builder: (counterCubitBuilderContext, state) => counterText(state.counterValue!, counterCubitBuilderContext)),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: () => BlocProvider.of<CounterCubit>(context).decrement(),
                  backgroundColor: widget.color,
                  heroTag: Text("${widget.title!}"),
                  tooltip: "Decrement",
                  child: Icon(Icons.remove),
                ),
                FloatingActionButton(
                  onPressed: () => BlocProvider.of<CounterCubit>(context).increment(),
                  backgroundColor: widget.color,
                  heroTag: Text("${widget.title!} #2"),
                  tooltip: "Increment",
                  child: Icon(Icons.add),
                ),
              ],
            ),
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
