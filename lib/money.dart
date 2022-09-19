import 'package:meta/meta.dart';
import 'package:tdd/expression.dart';

import 'bank.dart';

class Money implements Expression {
  @protected
  final int amount;
  @protected
  late String currency;

  Money(this.amount, this.currency);

  factory Money.dollar(int amount) {
    return Money(amount, 'USD');
  }

  factory Money.franc(int amount) {
    return Money(amount, 'CHF');
  }

  String getCurrency() => currency;

  @override
  operator ==(Object other) {
    Money money = other as Money;
    return amount == money.amount && getCurrency() == money.getCurrency();
  }

  Expression times(int multiplier) {
    return Money(amount * multiplier, currency);
  }

  @override
  Expression plus(Expression addend) {
    return Sum(this, addend);
  }

  @override
  Money reduce(Bank bank, String to) {
    int rate = bank.rate(currency, to);
    return Money(amount ~/ rate, to);
  }

  @override
  int get hashCode => 0;
}
