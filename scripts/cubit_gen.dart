import 'dart:io';

void main() async {
  /// Đặt tên
  String name = 'sign_in';
  String fileNameState = '${name}_state';
  String fileNameCubit = '${name}_cubit';
  String fileNamePage = '${name}_page';
  //
  // generate Cubit file
  String stringClassCubit = generateDartClassCubit(name, fileNameState);
  String stringClassState = generateDartClassState(name, fileNameCubit);
  String stringClassPage = generateDartClassPage(name, fileNameCubit);
  Directory dir = Directory('../lib/ui/$name/cubit');
  dir.createSync(recursive: true);
  File cubitFile = File('${dir.path}/$fileNameCubit.dart');
  cubitFile.createSync();
  cubitFile.writeAsString(stringClassCubit);
  File stateFile = File('${dir.path}/$fileNameState.dart');
  stateFile.createSync();
  stateFile.writeAsString(stringClassState);
  // file page
  Directory dirPage = Directory('../lib/ui/$name');
  dirPage.createSync(recursive: true);
  File pageFile = File('${dirPage.path}/$fileNamePage.dart');
  pageFile.createSync();
  pageFile.writeAsString(stringClassPage);
}

String generateDartClassState(String name, String fileNameCubit) {
  String nameClassState = '${convertToPascalCase(name)}State';
  String partOfState = '''part of '$fileNameCubit.dart';''';
  StringBuffer classBuffer = StringBuffer();
  classBuffer.writeln(partOfState);
  classBuffer.writeln('class $nameClassState {');
  classBuffer.writeln('$nameClassState copyWith(){');
  classBuffer.writeln('return $nameClassState();}');
  classBuffer.writeln('}');
  return classBuffer.toString();
}

String generateDartClassCubit(String name, String fileNameState) {
  String nameClass = '${convertToPascalCase(name)}Cubit';
  String nameClassState = '${convertToPascalCase(name)}State';
  String partOfState = '''part '$fileNameState.dart';''';
  StringBuffer classBuffer = StringBuffer();
  String data =
      '''import 'package:injectable/injectable.dart';\nimport 'package:joytime/bloc/base_cubit.dart';\n$partOfState\n''';
  classBuffer.writeln(data);
  classBuffer.writeln('\n@Injectable()');
  classBuffer.writeln('class $nameClass extends BaseCubit<$nameClassState>{');
  classBuffer.writeln('$nameClass():super($nameClassState());');
  classBuffer.writeln('}');
  return classBuffer.toString();
}

String generateDartClassPage(String name, String fileNameCubit) {
  String nameClass = '${convertToPascalCase(name)}Page';
  String nameCubitClass = '${convertToPascalCase(name)}Cubit';
  String nameClassState = '_${nameClass}State';
  StringBuffer classBuffer = StringBuffer();
  String data =
      '''import 'package:auto_route/auto_route.dart';\nimport 'package:flutter/material.dart';''';
  classBuffer.writeln(data);
  classBuffer.writeln('''import 'package:flutter_bloc/flutter_bloc.dart';''');
  classBuffer
      .writeln('''import 'package:joytime/bloc/base_stateful_widget.dart';''');
  classBuffer.writeln('''import './cubit/$fileNameCubit.dart';''');
  classBuffer.writeln('@RoutePage()');
  classBuffer.writeln('class $nameClass extends StatefulWidget {');
  classBuffer.writeln('const $nameClass({Key? key}) : super(key: key);');
  classBuffer.writeln('@override');
  classBuffer.writeln('$nameClassState createState() => $nameClassState();');
  classBuffer.writeln('}');
  classBuffer.writeln(
      'class $nameClassState extends BasePageStateDelegate<$nameClass, $nameCubitClass> {');
  classBuffer.writeln('@override');
  classBuffer.writeln('Widget buildWidgets(BuildContext context) {');
  classBuffer.writeln('return Container();');
  classBuffer.writeln('}');
  classBuffer.writeln('}');
  return classBuffer.toString();
}

String convertToPascalCase(String input) {
  return input
      .split('_') // Tách chuỗi thành danh sách các từ
      .map((word) =>
          word[0].toUpperCase() +
          word.substring(1)) // Viết hoa chữ cái đầu của từng từ
      .join(); // Ghép lại các từ thành chuỗi
}
