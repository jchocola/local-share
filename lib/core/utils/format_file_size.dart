import 'dart:math';

String formatFileSize(int bytes, {int decimals = 2}) {
  if (bytes <= 0) return "0 Bytes";

  // Список единиц измерения, использующих основание 1024
  const suffixes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
  
  // Коэффициент 1024 (2^10)
  const base = 1024; 
  
  // Определяем, какая единица измерения подходит лучше всего
  final i = (log(bytes) / log(base)).floor();
  
  // Вычисляем значение в выбранной единице измерения
  final value = bytes / pow(base, i);
  
  // Форматируем вывод
  return '${value.toStringAsFixed(decimals)} ${suffixes[i]}';
}