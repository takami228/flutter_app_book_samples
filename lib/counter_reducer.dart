import 'package:flutter_app/counter_state.dart';
import 'package:flutter_app/increment_action.dart';
import 'package:redux/redux.dart';

CounterState counterReducer(CounterState state, IncrementAction action) {
  return CounterState(counter: state.counter + 1);
}

final reducers = combineReducers<CounterState>(
    [TypedReducer<CounterState, IncrementAction>(counterReducer)]);
