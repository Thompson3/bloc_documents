// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_class/business_logic/cubit/counter_cubit.dart';

void main() {
  group('CounterCubit', () {
    late CounterCubit counterCubit;

    setUp(() {
      counterCubit = CounterCubit();
    });

    tearDown(() {
      counterCubit.close();
    });

    test(
      'initial state is CounterState(counterValue: 0, wasIncremented: true)',
      () {
        expect(
          counterCubit.state,
          CounterState(counterValue: 0, wasIncremented: true),
        );
      },
    );

    // for the body testing, if the blocprovider is well arranged

    blocTest<CounterCubit, CounterState>(
      'the cubit should emit CounterState(counterValue: 1, wasIncremented: true) when cubit.increment() function is called',
      build: () => counterCubit,
      act: (cubit) => cubit.increment(),
      expect: () => [CounterState(counterValue: 1, wasIncremented: true)],
    );

    // for button testing if its accurate or not

    blocTest<CounterCubit, CounterState>(
      'the cubit should emit CounterState(counterValue: -1, wasIncremented: false) when cubit.decrement() function is called',
      build: () => counterCubit,
      act: (cubit) => cubit.decrement(),
      expect: () => [CounterState(counterValue: -1, wasIncremented: false)],
    );
  });
}
