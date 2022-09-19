import 'package:tdd/expression.dart';
import 'package:tdd/money.dart';

class Bank {
  Map<Pair, int> rates = {};

  Money reduce(Expression source, String to) {
    return source.reduce(this, to);
  }

  int rate(String from, String to) {
    if (from == to) return 1;
    return rates[Pair(from, to)] as int;
  }

  void addRate(String from, String to, int rate) {
    rates[Pair(from, to)] = rate;
  }
}

class Pair {
  String from;
  String to;

  Pair(this.from, this.to);

  @override
  operator ==(Object object) {
    Pair pair = object as Pair;
    return from == pair.from && to == pair.to;
  }

  @override
  int get hashCode => 0;
}
