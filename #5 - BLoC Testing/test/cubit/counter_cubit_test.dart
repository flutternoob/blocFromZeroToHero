import 'package:flutter_counter_bloc/cubits/counter_cubit.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group("CounterCubit", (){

    CounterCubit? counterCubit;

    setUp((){
      counterCubit = CounterCubit();
    });
    tearDown((){
      counterCubit!.close();
    });

    test("Initial state of CounterCubit is CounterState(counterValue: 0)", () {
      expect(counterCubit!.state, CounterState(counterValue: 0));
    });

    blocTest<CounterCubit, CounterState>(
      'the CounterCubit should emit a CounterState(counterValue:1, wasIncremented:true) when the increment function is called',
      build: () => counterCubit!,
      act: (cubit) => cubit.increment(),
      expect: () => <CounterState>[CounterState(counterValue: 1, wasIncremented: true)],
    );

    blocTest<CounterCubit, CounterState>(
      'the CounterCubit should emit a CounterState(counterValue:-1, wasIncremented:false) when the decrement function is called',
      build: () => counterCubit!,
      act: (cubit) => cubit.decrement(),
      expect: () => <CounterState>[CounterState(counterValue: -1, wasIncremented: false)],
    );
  });
}
