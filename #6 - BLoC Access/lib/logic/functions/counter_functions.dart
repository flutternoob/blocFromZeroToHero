import 'package:flutter/material.dart';

void snackBarFunction(bool counterState, BuildContext context) {
  if (counterState == true) {
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

Text counterText(int counterValue, BuildContext context) {
  if (counterValue < 0) {
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
