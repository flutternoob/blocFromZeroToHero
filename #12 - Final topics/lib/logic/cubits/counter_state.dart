part of 'counter_cubit.dart';

class CounterState {
  final int? counterValue;
  final bool? wasIncremented;

  CounterState({required this.counterValue, this.wasIncremented});

  Map<String, dynamic> toMap() {
    return {
      "counterValue": counterValue,
      "wasIncremented": wasIncremented
    };
  }

  factory CounterState.fromMap(Map<String, dynamic>? map) {
    return CounterState(
      counterValue: map!["counterValue"],
      wasIncremented: map["wasIncremented"]
    );
  }

  String toJson() => json.encode(toMap());

  factory CounterState.fromJson(String source) => CounterState.fromMap(json.decode(source));
}