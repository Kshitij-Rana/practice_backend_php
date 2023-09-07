var ipAdress = '192.168.1.70';

var getImageUrl = (images) {
  return 'http://$ipAdress/practice_api/$images';
};
var formatDate = (DateTime? date) {
  if (date == null) return '-';
  return '${date.year}-${date.month}-${date.day}${date.hour}:${date.minute}';
};
