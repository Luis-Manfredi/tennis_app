List months = [
  'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'
];
List weekDays = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'];
var month = DateTime.now().month;
var day = DateTime.now().day;
var year = DateTime.now().year;
var dayName = DateTime.now().weekday;
var currentDay = weekDays[dayName-1];
var monthsName = months[month-1];