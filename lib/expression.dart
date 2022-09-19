import 'package:tdd/bank.dart';
import 'package:tdd/money.dart';

abstract class Expression {
  Money reduce(Bank bank, String to);

  Expression plus(Expression addend);

  Expression times(int multiplier);
}

class Sum implements Expression {
  Expression augend;
  Expression addend;

  Sum(this.augend, this.addend);

  @override
  Money reduce(Bank bank, String to) {
    int amount =
        augend.reduce(bank, to).amount + addend.reduce(bank, to).amount;
    return Money(amount, to);
  }

  @override
  Expression plus(Expression addend) {
    return Sum(this, addend);
  }

  @override
  Expression times(int multiplier) {
    return Sum(augend.times(multiplier), addend.times(multiplier));
  }
}
