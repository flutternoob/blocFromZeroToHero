import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/cubits/counter_cubit.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(
        primaryColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider<CounterCubit>(
        create: (context) => CounterCubit(),
        child: MyHomePage(title: "Flutter Demo Home Page"),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String? title;

  const MyHomePage({Key? key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("You have pushed this button this many times:"),
            BlocConsumer<CounterCubit, CounterState>(listener: (context, state) {
              if (state.wasIncremented == true) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Incremented!"),
                  duration: Duration(milliseconds: 300),
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Decremented!"),
                  duration: Duration(milliseconds: 300),
                ));
              }
            }, builder: (context, state) {
              if (state.counterValue! < 0) {
                return Text("BRR, Negative ${state.counterValue.toString()}",
                    style: Theme.of(context).textTheme.headline4);
              } else if (state.counterValue! % 2 == 0) {
                return Text("YAAAY ${state.counterValue.toString()}",
                    style: Theme.of(context).textTheme.headline4);
              } else if (state.counterValue! == 5) {
                return Text("HMM, NUMBER 5", style: Theme.of(context).textTheme.headline4);
              } else {
                return Text(state.counterValue.toString(),
                    style: Theme.of(context).textTheme.headline4);
              }
            }),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: () => BlocProvider.of<CounterCubit>(context).decrement(),
                  heroTag: Text("${widget.title}"),
                  tooltip: "Decrement",
                  child: Icon(Icons.remove),
                ),
                FloatingActionButton(
                  onPressed: () => BlocProvider.of<CounterCubit>(context).increment(),
                  heroTag: Text("${widget.title} #2"),
                  tooltip: "Increment",
                  child: Icon(Icons.add),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
