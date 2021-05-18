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

///Used a stateless widget since state is handled by the Block library in this case. I referred the
///following link: https://stackoverflow.com/questions/58864869/flutter-state-management-bloc-stateless-vs-stateful-widget
class MyHomePage extends StatelessWidget {
  final String? title;

  const MyHomePage({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("You have pushed this button this many times:"),
            BlocConsumer<CounterCubit, CounterState>(
              ///Refactored the if...else block into a function to show the SnackBar Widget
                listener: (context, state) => snackBarFunction(state.wasIncremented, context),
                ///Refactored the if...else block into a function that returns a Text widget
                builder: (context, state) => counterText(state.counterValue!, context)),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: () => BlocProvider.of<CounterCubit>(context).decrement(),
                  heroTag: Text("$title"),
                  tooltip: "Decrement",
                  child: Icon(Icons.remove),
                ),
                FloatingActionButton(
                  onPressed: () => BlocProvider.of<CounterCubit>(context).increment(),
                  heroTag: Text("$title #2"),
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

///This function is used to show the snack bar widget depending on whether the counter was incremented
///or decremented
void snackBarFunction(bool? counterState, context) {
  if (counterState == true) {
    ///Scaffold.of(context).showSnackBar(snackBar) is deprecated
    ///Using ScaffoldMessenger.of(context).showSnackBar(snackBar) instead
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
}

///This function is used to change the returned Text widget in accordance with the value of the counter
Text counterText(int? counterValue, context) {
  if (counterValue! < 0) {
    return Text("BRR, Negative $counterValue",
        style: Theme.of(context).textTheme.headline4);
  } else if (counterValue % 2 == 0) {
    return Text("YAAAY $counterValue",
        style: Theme.of(context).textTheme.headline4);
  } else if (counterValue == 5) {
    return Text("HMM, NUMBER 5", style: Theme.of(context).textTheme.headline4);
  } else {
    return Text("$counterValue",
        style: Theme.of(context).textTheme.headline4);
  }
}
