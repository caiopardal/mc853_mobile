import 'package:inscritus/helpers/helpers.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MODULE TEST: Validator helpers', () {
    // test('\nFUNCTION: isNumeric', () {
    //   print('Case: One numeric char');
    //   expect(isNumeric('1'), true);

    //   print('Case: Multiple numeric chars');
    //   expect(isNumeric('1234567890'), true);

    //   print('Case: One double');
    //   expect(isNumeric('1.123'), true);

    //   print('Case: Negative number');
    //   expect(isNumeric('-1'), true);

    //   print('Case: Negative double');
    //   expect(isNumeric('-1.123'), true);

    //   print('Case: One letter');
    //   expect(isNumeric('A'), false);

    //   print('Case: One symbol');
    //   expect(isNumeric('#'), false);

    //   print('Case: Mixed chars');
    //   expect(isNumeric('#A1'), false);
    // });

    test('\nFUNCTION: areDigits', () {
      print('Case: One numeric char');
      expect(areDigits('1'), true);

      print('Case: Multiple numeric chars');
      expect(areDigits('1234567890'), true);

      print('Case: One double');
      expect(areDigits('1.123'), false);

      print('Case: Negative number');
      expect(areDigits('-1'), false);

      print('Case: Negative double');
      expect(areDigits('-1.123'), false);

      print('Case: One letter');
      expect(areDigits('A'), false);

      print('Case: One symbol');
      expect(areDigits('#'), false);

      print('Case: Mixed chars');
      expect(areDigits('#A1'), false);
    });

    test('\nFUNCTION: isAlpha', () {
      print('Case: One Uppercase letter');
      expect(isAlpha('A'), true);

      print('Case: One lowercase letter');
      expect(isAlpha('a'), true);

      print('Case: Multiple uppercase letters');
      expect(isAlpha('ABCDEFGHIJKLMNOPQRSTUVWXYZ'), true);

      print('Case: Multiple lowercase letters');
      expect(isAlpha('abcdefghijklmnopqrstuvwxyz'), true);

      print('Case: One numeric char');
      expect(isAlpha('1'), false);

      print('Case: Multiple numeric chars');
      expect(isAlpha('1234567890'), false);

      print('Case: One double');
      expect(isAlpha('1.123'), false);

      print('Case: Negative number');
      expect(isAlpha('-1'), false);

      print('Case: Negative double');
      expect(isAlpha('-1.123'), false);

      print('Case: One symbol');
      expect(isAlpha('#'), false);

      print('Case: Mixed chars');
      expect(isAlpha('#A1'), false);
    });

    test('\nFUNCTION: doesNotHaveNumeric', () {
      print('Case: One Uppercase letter');
      expect(doesNotHaveNumeric('A'), true);

      print('Case: One lowercase letter');
      expect(doesNotHaveNumeric('a'), true);

      print('Case: Multiple uppercase letters');
      expect(doesNotHaveNumeric('ABCDEFGHIJKLMNOPQRSTUVWXYZ'), true);

      print('Case: Multiple lowercase letters');
      expect(doesNotHaveNumeric('abcdefghijklmnopqrstuvwxyz'), true);

      print('Case: One numeric char');
      expect(doesNotHaveNumeric('1'), false);

      print('Case: Multiple numeric chars');
      expect(doesNotHaveNumeric('1234567890'), false);

      print('Case: One double');
      expect(doesNotHaveNumeric('1.123'), false);

      print('Case: Negative number');
      expect(doesNotHaveNumeric('-1'), false);

      print('Case: Negative double');
      expect(doesNotHaveNumeric('-1.123'), false);

      print('Case: One symbol');
      expect(doesNotHaveNumeric('#'), true);

      print('Case: Mixed chars');
      expect(doesNotHaveNumeric('#A1'), false);

      print('Case: Number with Letters');
      expect(doesNotHaveNumeric('A1 B2'), false);
    });

    test('\nFUNCTION: doesNotHaveAlpha', () {
      print('Case: One Uppercase letter');
      expect(doesNotHaveAlpha('A'), false);

      print('Case: One lowercase letter');
      expect(doesNotHaveAlpha('a'), false);

      print('Case: Multiple uppercase letters');
      expect(doesNotHaveAlpha('ABCDEFGHIJKLMNOPQRSTUVWXYZ'), false);

      print('Case: Multiple lowercase letters');
      expect(doesNotHaveAlpha('abcdefghijklmnopqrstuvwxyz'), false);

      print('Case: One numeric char');
      expect(doesNotHaveAlpha('1'), true);

      print('Case: Multiple numeric chars');
      expect(doesNotHaveAlpha('1234567890'), true);

      print('Case: One double');
      expect(doesNotHaveAlpha('1.123'), true);

      print('Case: Negative number');
      expect(doesNotHaveAlpha('-1'), true);

      print('Case: Negative double');
      expect(doesNotHaveAlpha('-1.123'), true);

      print('Case: One symbol');
      expect(doesNotHaveAlpha('#'), true);

      print('Case: Mixed chars');
      expect(doesNotHaveAlpha('#A1'), false);

      print('Case: Number with Letters');
      expect(doesNotHaveAlpha('A1 B2'), false);
    });
  });
}
