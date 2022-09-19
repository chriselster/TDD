import 'package:tdd/bank.dart';
import 'package:tdd/expression.dart';
import 'package:tdd/money.dart';
import 'package:test/test.dart';

void main() {
  test('multiplication', () {
    Money five = Money.dollar(5);
    expect(Money.dollar(10), equals(five.times(2)));
    expect(Money.dollar(15), equals(five.times(3)));
  });

  test('equality', () {
    expect(Money.dollar(5), equals(Money.dollar(5)));
    expect(Money.dollar(5), isNot(equals(Money.dollar(6))));
    expect(Money.franc(5), isNot(equals(Money.dollar(5))));
  });

  test('currency', () {
    expect(Money.dollar(1).getCurrency(), equals('USD'));
    expect(Money.franc(1).getCurrency(), equals('CHF'));
  });

  test('simple addition', () {
    Money five = Money.dollar(5);
    Expression sum = five.plus(five);
    Bank bank = Bank();
    Money reduced = bank.reduce(sum, 'USD');
    expect(Money.dollar(10), equals(reduced));
  });

  test('plus returns sum', () {
    Money five = Money.dollar(5);
    Expression result = five.plus(five);
    Sum sum = result as Sum;
    expect(five, equals(sum.augend));
    expect(five, equals(sum.addend));
  });

  test('reduce sum', () {
    Expression sum = Sum(Money.dollar(3), Money.dollar(4));
    Bank bank = Bank();
    Money result = bank.reduce(sum, 'USD');
    expect(Money.dollar(7), equals(result));
  });

  test('reduce money', () {
    Bank bank = Bank();
    Money result = bank.reduce(Money.dollar(1), 'USD');
    expect(Money.dollar(1), equals(result));
  });

  test('reduce money different currency', () {
    Bank bank = Bank();
    bank.addRate('CHF', 'USD', 2);
    Money result = bank.reduce(Money.franc(2), 'USD');
    expect(Money.dollar(1), equals(result));
  });

  test('identity rate', () {
    expect(Bank().rate('USD', 'USD'), equals(1));
  });

  test('mixed addition', () {
    Expression fiveBucks = Money.dollar(5);
    Expression tenFrancs = Money.franc(10);
    Bank bank = Bank();
    bank.addRate('CHF', 'USD', 2);
    Money result = bank.reduce(fiveBucks.plus(tenFrancs), 'USD');
    expect(result, equals(Money.dollar(10)));
  });

  test('sum plus money', () {
    Expression fiveBucks = Money.dollar(5);
    Expression tenFrancs = Money.franc(10);
    Bank bank = Bank();
    bank.addRate('CHF', 'USD', 2);
    Expression sum = Sum(fiveBucks, tenFrancs).plus(fiveBucks);
    Money result = bank.reduce(sum, 'USD');
    expect(result, equals(Money.dollar(15)));
  });

  test('sum times', () {
    Expression fiveBucks = Money.dollar(5);
    Expression tenFrancs = Money.franc(10);
    Bank bank = Bank();
    bank.addRate('CHF', 'USD', 2);
    Expression sum = Sum(fiveBucks, tenFrancs).times(2);
    Money result = bank.reduce(sum, 'USD');
    expect(result, equals(Money.dollar(20)));
  });
}
