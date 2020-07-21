import 'package:cpfcnpj/cpfcnpj.dart';
import 'package:inscritus/helpers/ddd.dart';
import 'package:inscritus/helpers/helpers.dart';
import 'package:inscritus/helpers/utils.dart';
import 'package:string_validator/string_validator.dart';

class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }

  static final nameRegExp = new RegExp("^[A-Za-zÀ-ÖØ-öø-ÿ -']+\$");
  static final nameWithNumbersRegExp =
      new RegExp("^[A-Za-zÀ-ÖØ-öø-ÿ0-9-() -']+\$");
  static final digitsRegExp = RegExp('[^0-9]');
  static final repeatedDigitsRegExp = RegExp('([0-9])\1{5}');

  static bool validateUserName(String name) {
    if (name == null) {
      return false;
    }

    name = name.trim();

    return name.split(' ').length > 1 && doesNotHaveNumeric(name);
  }

  static bool validateGenericName(String name) {
    if (name == null) {
      return false;
    }

    name = name.trim();

    return doesNotHaveNumeric(name);
  }

  static bool validateCPF(String cpf) {
    return CPF.isValid(cpf);
  }

  static bool validateWord(String word) {
    if (word == null) {
      return false;
    }

    word = word.trim();

    return word.length > 1 && !doesNotHaveAlpha(word);
  }

  static bool validateWordWithoutNumeric(String word) {
    if (word == null) {
      return false;
    }

    word = word.trim();

    return word.length > 1 &&
        !doesNotHaveAlpha(word) &&
        doesNotHaveNumeric(word);
  }

  static bool nameValidator(String name) {
    return matchesName(name);
  }

  static bool matchesName(String name) {
    return nameRegExp.hasMatch(name);
  }

  static bool matchesNameWithNumber(String name) {
    return nameWithNumbersRegExp.hasMatch(name);
  }

  static bool validatePhone(String phone) {
    String unmasked = unmask(phone);

    if (phone == null || phone.length != 11) {
      return false;
    }

    String ddd = unmasked.substring(0, 2);
    String number = unmasked.substring(2);

    if (!stateByDDD.keys.contains(ddd) || number[0] != '9') {
      return false;
    }
    return isNumeric(phone);
  }
}
