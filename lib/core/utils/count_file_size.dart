import 'dart:io';

int countFilesSize({required List<File> files}) {
  int total = 0;

  for (var file in files) {
    total += file.lengthSync();
  }
  return total;
}
