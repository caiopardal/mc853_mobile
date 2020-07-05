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
