import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/logic/cubits/internet_cubit.dart';
import 'package:flutter_counter_bloc/constants/enums.dart';
import 'package:flutter_counter_bloc/logic/cubits/counter_cubit.dart';
import 'package:flutter_counter_bloc/logic/functions/counter_functions.dart';

class HomeScreen extends StatefulWidget {
  final String? title;
  final Color? color;

  const HomeScreen({Key? key, this.title, this.color}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext homeScreenContext) {
    return BlocListener<InternetCubit, InternetState>(
      listener: (internetCubitListenerContext, state) {
        if (state is InternetConnected && state.connectionType == ConnectionType.Wifi) {
          BlocProvider.of<CounterCubit>(internetCubitListenerContext).increment();
        } else if (state is InternetConnected && state.connectionType == ConnectionType.Mobile) {
          BlocProvider.of<CounterCubit>(internetCubitListenerContext).decrement();
        }
      },
      child: Scaffold(
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
                    if (state is InternetConnected && state.connectionType == ConnectionType.Wifi) {
                      return Text(
                          "Wifi",
                          style: Theme.of(internetCubitBuilderContext).textTheme.headline3!.copyWith(color: Colors.green)
                      );
                    }
                    else if (state is InternetConnected &&
                        state.connectionType == ConnectionType.Mobile) {
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
              Builder(
                builder: (context) {
                  final counterState = context.watch<CounterCubit>().state;
                  final internetState = context.watch<InternetCubit>().state;

                  if (internetState is InternetConnected && internetState.connectionType == ConnectionType.Mobile){
                    return Text(
                        "Counter: ${counterState.counterValue}, Internet: Mobile",
                      style: Theme.of(context).textTheme.headline6
                    );
                  }
                  else if (internetState is InternetConnected && internetState.connectionType == ConnectionType.Wifi){
                    return Text(
                        "Counter: ${counterState.counterValue}, Internet: Wifi",
                        style: Theme.of(context).textTheme.headline6
                    );
                  }
                  else {
                    return Text(
                        "Counter: ${counterState.counterValue}, Internet: Disconnected",
                        style: Theme.of(context).textTheme.headline6
                    );
                  }
                }
              ),
              Builder(
                builder: (context) {
                  final counterValue = context.select((CounterCubit cubit) => cubit.state.counterValue);
                    return Text(
                        "Counter: $counterValue",
                        style: Theme.of(context).textTheme.headline6
                    );
                }
              ),
              SizedBox(
                height: 24
              ),
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
              Builder(
                builder: (materialButtonContext) => MaterialButton(
                  onPressed: () => Navigator.of(context).pushNamed('/second'),
                  color: Colors.redAccent,
                  child: Text("Go to Second Screen", style: TextStyle(color: Colors.white)),
                ),
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
      ),
    );
  }
}
