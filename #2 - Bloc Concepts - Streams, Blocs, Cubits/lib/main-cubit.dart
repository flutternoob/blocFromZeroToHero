import 'dart:async';
import 'package:bloc/bloc.dart';

//Creating an increment and decrement enum
enum CounterEvent{increment, decrement}

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc(): super(0);

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    try {
      switch (event) {
        case CounterEvent.increment:
          yield state + 1;
          break;
        case CounterEvent.decrement:
          yield state - 1;
          break;
      }
    } catch (error) {
      throw UnimplementedError();
    }
  }
}

Future<void> main(List<String> args) async {
  final CounterBloc counterBloc = CounterBloc();

  //Subscribe to the bloc state stream and print the state values emitted by it
  //Use stream.listen, .listen is deprecated
  final StreamSubscription streamSubscription = counterBloc.stream.listen(print);

  counterBloc.add(CounterEvent.increment);
  counterBloc.add(CounterEvent.increment);
  counterBloc.add(CounterEvent.increment);

  counterBloc.add(CounterEvent.decrement);
  counterBloc.add(CounterEvent.decrement);
  counterBloc.add(CounterEvent.decrement);

  //Used to avoid cancelling the stream subscription immediately
  await Future.delayed(Duration.zero);

  await streamSubscription.cancel();

  await counterBloc.close();
}
