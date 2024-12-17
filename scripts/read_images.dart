import 'dart:developer' as developer;
import 'dart:io';

import 'package:path/path.dart' as p;

final String folder = '../assets/images';

Future<List<File>> getAllFile() async {
  List<File> file = [];
  Directory directory = Directory('$folder');
  final listContent = directory.listSync();
  listContent.forEach((element) {
    if (element is File) {
      file.add(element);
    }
  });
  return file;
}

void main() async {
  print('start tool!');
  Directory('$folder').createSync();

  final listFile = await getAllFile();
  developer.log('count: ${listFile.length}');

  List<String> names = [];

  for (var file in listFile) {
    String name = file.path.split('/').last;
    // String name = toCamelCase(file.path.split('/').last);

    print(name);

    names.add(name);
  }

  Directory dir = Directory('../lib/resources/assets');
  dir.createSync(recursive: true);

  File iconFile = File('${dir.path}/images.dart');

  iconFile.createSync();

  String contents =
      'class ImagePath {\n  static const image_path = \'assets/images\';\n\n\n';

  names.forEach((element) {
    contents +=
        '  static const String ${p.basenameWithoutExtension(toCamelCase(element))} = \'\$\image_path/$element\';\n';
  });

  contents += '}';

  iconFile.writeAsString(contents);

  developer.log('OK!');
}

String toCamelCase(String input) {
  List<String> parts = input.split('_');
  return parts.first +
      parts
          .skip(1)
          .map((word) => word[0].toUpperCase() + word.substring(1))
          .join('');
}
