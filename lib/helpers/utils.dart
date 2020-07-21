import 'package:inscritus/helpers/validators.dart';

String timeFormat(String time) {
  var hour = time.substring(0, 2);
  var minutes = time.substring(3);

  return hour + 'h' + minutes;
}

String dateFormat(String date) {
  const monthNames = [
    'Jan',
    'Fev',
    'Mar',
    'Abr',
    'Mai',
    'Jun',
    'Jul',
    'Ago',
    'Set',
    'Out',
    'Nov',
    'Dez',
  ];

  var day = date.substring(8);
  var month = int.parse(date.substring(5, 7));
  var year = date.substring(0, 4);

  return day + ' ' + monthNames[month - 1] + ' ' + year;
}

bool isEmailAddress(String input) {
  final matcher = new RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  return matcher.hasMatch(input);
}

String unmask(String maskedText) {
  return maskedText.replaceAll(new RegExp(r'[^A-Za-z0-9]'), '');
}

String maskPhone(String phone) {
  try {
    if (!Validators.validatePhone(phone)) {
      throw Exception();
    }

    return '(' +
        phone.substring(0, 2) +
        ') ' +
        phone.substring(2, 7) +
        '-' +
        phone.substring(7, phone.length);
  } catch (e) {
    return phone;
  }
}

String maskCPF(String cpf) {
  try {
    if (!Validators.validateCPF(cpf)) {
      throw Exception();
    }

    return cpf.substring(0, 3) +
        '.' +
        cpf.substring(3, 6) +
        '.' +
        cpf.substring(6, 9) +
        '-' +
        cpf.substring(9, cpf.length);
  } catch (e) {
    return cpf;
  }
}
