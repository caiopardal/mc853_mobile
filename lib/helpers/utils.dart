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
