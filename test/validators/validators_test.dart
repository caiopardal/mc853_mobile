import 'package:flutter_test/flutter_test.dart';
import 'package:inscritus/helpers/validators.dart';

void main() {
  group('MODULE TEST: Validator', () {
    test('\nFUNCTION: validateName', () {
      print('Case: One word');
      expect(Validators.validateUserName('Test AAAA'), false);

      print('Case: Multiple words');
      expect(Validators.validateUserName('Test Case'), true);

      print('Case: Int');
      expect(Validators.validateUserName('1'), false);

      print('Case: Double');
      expect(Validators.validateUserName('1.123'), false);

      print('Case: One symbol');
      expect(Validators.validateUserName('#'), false);

      print('Case: Mixed chars');
      expect(Validators.validateUserName('#A1'), false);

      print('Case: Letters and numbers');
      expect(Validators.validateUserName('A1 B2'), false);
    });

    test('\nFUNCTION: validateCPF', () {
      print('Case: Correct case');
      expect(
        Validators.validateCPF('83173895029'),
        true,
      );

      print('Case: Longer input');
      expect(
        Validators.validateCPF('831738950290'),
        false,
      );

      print('Case: Shorter input');
      expect(
        Validators.validateCPF('8317389502'),
        false,
      );

      print('Case: Input with letter');
      expect(
        Validators.validateCPF('83I73895029'),
        false,
      );

      print('Case: Input with symbol');
      expect(
        Validators.validateCPF('83!73895029'),
        false,
      );

      print('Case: Gargabe input');
      expect(
        Validators.validateCPF('dsaf89ujweads'),
        false,
      );

      print('Case: empty input');
      expect(
        Validators.validateCPF(''),
        false,
      );
    });

    test('\nFUNCTION: validatePhone', () {
      print('Case: Correct case for mobile phones');
      expect(
        Validators.validatePhone('11911111111'),
        true,
      );

      print('Case: Correct case for land lines');
      expect(
        Validators.validatePhone('11911111111'),
        true,
      );

      print('Case: Longer input');
      expect(
        Validators.validatePhone('111111111111'),
        false,
      );

      print('Case: Shorter input');
      expect(
        Validators.validatePhone('111111111'),
        false,
      );

      print('Case: Input with letter');
      expect(
        Validators.validatePhone('I1111111111'),
        false,
      );

      print('Case: Input with symbol');
      expect(
        Validators.validatePhone('!1111111111'),
        false,
      );

      print('Case: Gargabe input');
      expect(
        Validators.validatePhone('dsaf89ujweads'),
        false,
      );

      print('Case: empty input');
      expect(
        Validators.validatePhone(''),
        false,
      );
    });

    test('\nFUNCTION: validateWord', () {
      print('Case: One word');
      expect(Validators.validateWord('Test'), true);

      print('Case: Multiple words');
      expect(Validators.validateWord('Test Case'), true);

      print('Case: Int');
      expect(Validators.validateWord('1'), false);

      print('Case: Double');
      expect(Validators.validateWord('1.123'), false);

      print('Case: One symbol');
      expect(Validators.validateWord('#'), false);

      print('Case: Mixed chars');
      expect(Validators.validateWord('#A1'), true);

      print('Case: Letters and numbers');
      expect(Validators.validateWord('A1 B2'), true);
    });

    test('\nFUNCTION: validateWordWithoutNumeric', () {
      print('Case: One word');
      expect(Validators.validateWordWithoutNumeric('Test'), true);

      print('Case: Multiple words');
      expect(Validators.validateWordWithoutNumeric('Test Case'), true);

      print('Case: Int');
      expect(Validators.validateWordWithoutNumeric('1'), false);

      print('Case: Double');
      expect(Validators.validateWordWithoutNumeric('1.123'), false);

      print('Case: One symbol');
      expect(Validators.validateWordWithoutNumeric('#'), false);

      print('Case: Mixed chars');
      expect(Validators.validateWordWithoutNumeric('#A1'), false);

      print('Case: Letters and numbers');
      expect(Validators.validateWordWithoutNumeric('A1 B2'), false);
    });
  });
}
