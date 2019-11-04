import 'package:scoped_model/scoped_model.dart';

//Modelの役割は状態を管理すること
class CounterModel extends Model {
  //private
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;

    notifyListeners();
  }
}
