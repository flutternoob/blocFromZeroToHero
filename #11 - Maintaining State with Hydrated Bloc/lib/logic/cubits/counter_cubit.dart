import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'internet_cubit.dart';
import 'package:flutter_counter_bloc/constants/enums.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> with HydratedMixin {

  CounterCubit() : super(CounterState(counterValue: 0));

  void increment() => emit(
      CounterState(counterValue: state.counterValue! + 1, wasIncremented: true));

  void decrement() => emit(CounterState(
      counterValue: state.counterValue! - 1, wasIncremented: false));

  @override
  CounterState fromJson(Map<String, dynamic> json) {
    return CounterState.fromMap(json);
  }

  @override
  Map<String, dynamic> toJson(CounterState state) {
    return state.toMap();
  }
}