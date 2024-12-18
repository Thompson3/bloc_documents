// ignore_for_file: unnecessary_this, prefer_const_constructors_in_immutables

part of 'counter_cubit.dart';

class CounterState extends Equatable {
  final int counterValue;
  final bool wasIncremented;

  CounterState({required this.counterValue, required this.wasIncremented});

// to bring in equatable for proper comparison when testing the isolated file or any other
  @override
  List<Object?> get props => [this.counterValue, this.wasIncremented];

  get connectionType => null;
}
