// ignore_for_file: use_key_in_widget_constructors, unnecessary_null_comparison

import 'package:flutter/material.dart';

class CounterState {
  int _value = 1;

  void inc() => _value++;
  void dec() => _value--;
  int get value => _value;

  bool diff(CounterProvider old) {
    return old == null || old._value != _value;
  }
}

class CounterProvider extends InheritedWidget {
  get _value => null;
  final CounterState state = CounterState();

  CounterProvider({required Widget child}) : super(child: child);

  //método para facilitar a o acesso da variável state
  static CounterProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
