import 'dart:async';

import 'package:bloc/bloc.dart';
import 'internet_cubit.dart';
import 'package:flutter_counter_bloc/constants/enums.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  final InternetCubit internetCubit;
  StreamSubscription? internetStreamSubscription;

  CounterCubit({required this.internetCubit}) : super(CounterState(counterValue: 0)){
   monitorInternetCubit();
  }

  void monitorInternetCubit() {
    internetStreamSubscription = internetCubit.stream.listen((internetState) {
      if(internetState is InternetConnected && internetState.connectionType == ConnectionType.Wifi){
        increment();
      }
      else if(internetState is InternetConnected && internetState.connectionType == ConnectionType.Mobile){
        decrement();
      }
    });
  }

  void increment() => emit(
      CounterState(counterValue: state.counterValue! + 1, wasIncremented: true));

  void decrement() => emit(CounterState(
      counterValue: state.counterValue! - 1, wasIncremented: false));

  @override
  Future<void> close() async {
    internetStreamSubscription!.cancel();
    super.close();
  }
}
