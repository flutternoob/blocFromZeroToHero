import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  GlobalKey<ScaffoldState> homeScreenKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScreenKey,
      appBar: AppBar(
        title: Text(widget.title!),
        backgroundColor: widget.color!,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("You have pushed this button this many times:"),
            BlocConsumer<CounterCubit, CounterState>(
                listener: (context, state) => snackBarFunction(state.wasIncremented!, context),
                builder: (context, state) => counterText(state.counterValue!, context)),
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
              onPressed: () => Navigator.of(context).pushNamed('/second'),
              color: Colors.redAccent,
              child: Text("Go to Second Screen", style: TextStyle(color: Colors.white)),
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
