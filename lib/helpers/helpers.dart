import 'package:string_validator/string_validator.dart';

List<String> states = [
  'AC',
  'AL',
  'AP',
  'AM',
  'BA',
  'CE',
  'DF',
  'ES',
  'GO',
  'MA',
  'MT',
  'MS',
  'MG',
  'PA',
  'PB',
  'PR',
  'PE',
  'PI',
  'RJ',
  'RN',
  'RS',
  'RO',
  'RR',
  'SC',
  'SP',
  'SE',
  'TO',
];
// RegExp numeric = new RegExp(r'^[+-]?\d+(\.\d+)?$');
RegExp digits = new RegExp(r'^[0-9]+$');
RegExp alpha = new RegExp(r'^[a-zA-Z]+$');
RegExp exceptNumeric = new RegExp(r'^([^0-9]*)$');
RegExp exceptAlpha = new RegExp(r'^([^a-zA-Z]*)$');

bool isNumber(String string) {
  return isNumeric(string);
}

bool areDigits(String string) {
  return digits.hasMatch(string);
}

bool isAlpha(String string) {
  return alpha.hasMatch(string);
}

bool doesNotHaveNumeric(String string) {
  return exceptNumeric.hasMatch(string);
}

bool doesNotHaveAlpha(String string) {
  return exceptAlpha.hasMatch(string);
}
