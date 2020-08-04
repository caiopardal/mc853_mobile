import 'package:flutter_test/flutter_test.dart';
import 'package:inscritus/helpers/utils.dart';

void main() {
  group('MODULE TEST: Unmask', () {
    test('\nFunction: unmask', () {
      print('Case: With non-alphanumeric');
      expect(
        unmask('1 ,.<>/\\!@#\$\%^&*()-_+=\'\"{[]} 2 3'),
        '123',
      );

      print('Case: Alphanumeric only');
      expect(
        maskPhone('123'),
        '123',
      );

      print('Case: empty input');
      expect(
        unmask(''),
        '',
      );
    });

    test('\nFunction: maskPhone', () {
      print('Case: Correct case');
      expect(
        maskPhone('11911111111'),
        '(11) 91111-1111',
      );

      print('Case: Gargabe input');
      expect(
        maskPhone('dsaf89ujweads'),
        'dsaf89ujweads',
      );

      print('Case: empty input');
      expect(
        maskPhone(''),
        '',
      );
    });

    test('\nFunction: maskCPF', () {
      print('Case: Correct case');
      expect(
        maskCPF('83173895029'),
        '831.738.950-29',
      );

      print('Case: Gargabe input');
      expect(
        maskCPF('dsaf89ujweads'),
        'dsaf89ujweads',
      );

      print('Case: empty input');
      expect(
        maskCPF(''),
        '',
      );
    });
  });
}
