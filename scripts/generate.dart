import 'dart:convert';
import 'dart:io';

void main() async {
  // Step 1: Read the JSON file
  final file = File('class_json.json');
  String contents = await file.readAsString();

  // Step 2: Parse the JSON content into a Map
  Map<String, dynamic> jsonData = jsonDecode(contents);

  // Step 3: Generate Dart class
  String generatedClass =
      '''import 'package:joytime/utils/safety_parser.dart';\n''';
  // Cần đặt tên cho class
  generatedClass += generateDartClass('CancelFlightReq', jsonData);
  Directory dir = Directory('../lib/data');
  dir.createSync(recursive: true);

  File iconFile = File('${dir.path}/cancel_flight.dart');

  iconFile.createSync();
  iconFile.writeAsString(generatedClass);
  // Step 4: Output the generated class
  // print(generatedClass);
}

// Function to generate Dart class code based on JSON structure
String generateDartClass(String className, Map<String, dynamic> jsonData) {
  StringBuffer classBuffer = StringBuffer();

  // Generate the main class
  classBuffer.writeln('class $className {');

  // Step 3.1: Declare fields based on JSON keys and types
  jsonData.forEach((key, value) {
    String type = _getType(key, value);
    if (value is Map) {
      classBuffer.writeln('  final $type? $key;');
    } else {
      classBuffer.writeln('  final $type $key;');
    }
  });

  // Step 3.2: Constructor with required fields
  classBuffer.write('  $className({');
  jsonData.forEach((key, value) {
    if (value is Map) {
      classBuffer.write('this.$key, ');
    } else {
      classBuffer.write('required this.$key, ');
    }
  });
  classBuffer.writeln('});\n');

  // Step 3.3: fromJson factory method
  classBuffer
      .writeln('  factory $className.fromJson(Map<String, dynamic> json) {');
  classBuffer.writeln('    return $className(');
  jsonData.forEach((key, value) {
    String type = _getType(key, value);
    if (type == 'DateTime?') {
      classBuffer.writeln('      $key: DateTime.tryParse(json["$key"] ?? ""),');
    } else if (type.startsWith('List')) {
      if (type == 'List<int>') {
        classBuffer.writeln('      $key: List<int>.from(json["$key"] ?? []),');
      } else if (type == 'List<double>') {
        classBuffer
            .writeln('      $key: List<double>.from(json["$key"] ?? []),');
      } else if (type == 'List<num>') {
        classBuffer.writeln('      $key: List<num>.from(json["$key"] ?? []),');
      } else if (type == 'List<String>') {
        classBuffer
            .writeln('      $key: List<String>.from(json["$key"] ?? []),');
      } else if (type == 'List<dynamic>') {
        classBuffer
            .writeln('      $key: List<dynamic>.from(json["$key"] ?? []),');
      } else {
        String className = convertToClassName(key);
        classBuffer.writeln(
            '      $key:json["$key"]!=null? List<$className>.from(json["$key"].map((x)=>$className.fromJson(x))):[],');
      }
    } else if (type == _capitalize(key)) {
      // If it's a class type based on a dynamic key
      classBuffer.writeln(
          '      $key: json["$key"] !=null ? ${_capitalize(key)}.fromJson(json["$key"]): null,');
    } else {
      switch (type) {
        case 'int':
          classBuffer.writeln('      $key: safeInt(json["$key"]),');
          break;
        case 'double':
          classBuffer.writeln('      $key: safeDouble(json["$key"]),');
          break;
        case 'num':
          classBuffer.writeln('      $key: safeNum(json["$key"]),');
          break;
        case 'bool':
          classBuffer.writeln('      $key: safeBool(json["$key"]),');
          break;
        case 'String':
          classBuffer.writeln('      $key: safeString(json["$key"]),');
          break;
        default:
          classBuffer.writeln('      $key: json["$key"] ?? "",');
      }
      // classBuffer.writeln('      $key: json["$key"] ?? "",');
    }
  });
  classBuffer.writeln('    );');
  classBuffer.writeln('  }\n');

  // Step 3.4: toJson method
  classBuffer.writeln('  Map<String, dynamic> toJson() {');
  classBuffer.writeln('    return {');
  jsonData.forEach((key, value) {
    String type = _getType(key, value);
    if (type == _capitalize(key)) {
      // For nested objects, call `toJson`
      classBuffer.writeln('      "$key": $key?.toJson(),');
    } else if (type.startsWith('List')) {
      //
      if (type == 'List<int>') {
        classBuffer.writeln('      "$key": $key?.map((x)=>x).toList(),');
      } else if (type == 'List<double>') {
        classBuffer.writeln('      "$key": $key?.map((x)=>x).toList(),');
      } else if (type == 'List<num>') {
        classBuffer.writeln('      "$key": $key?.map((x)=>x).toList(),');
      } else if (type == 'List<String>') {
        classBuffer.writeln('      "$key": $key?.map((x)=>x).toList(),');
      } else if (type == 'List<dynamic>') {
        classBuffer.writeln('      "$key": $key?.map((x)=>x).toList(),');
      } else {
        classBuffer
            .writeln('      "$key": $key?.map((x)=>x.toJson()).toList(),');
      }
    } else {
      classBuffer.writeln('      "$key": $key,');
    }
  });
  classBuffer.writeln('    };');
  classBuffer.writeln('  }\n');

  // Close the class
  classBuffer.writeln('}');

  // Step 3.5: Generate nested classes (if there are any)
  jsonData.forEach((key, value) {
    if (value is Map) {
      classBuffer.writeln(
          generateDartClass(_capitalize(key), value as Map<String, dynamic>));
    }
    if (value is List) {
      String type = _getType(key, value);
      if (type == 'List<int>' ||
          type == 'List<double>' ||
          type == 'List<num>' ||
          type == 'List<String>' ||
          type == 'List<dynamic>') {
      } else {
        classBuffer.writeln(generateDartClass(
            convertToClassName(key), value.first as Map<String, dynamic>));
      }
    }
  });

  return classBuffer.toString();
}

// Helper function to get Dart types based on JSON values
String _getType(String key, dynamic value) {
  if (value is int) {
    return 'int';
  } else if (value is double) {
    return 'double';
  } else if (value is num) {
    return 'num';
  } else if (value is bool) {
    return 'bool';
  } else if (value is List) {
    // Assuming all lists contain the same type
    if (value.isNotEmpty && value.first is int) {
      return 'List<int>';
    } else if (value.isNotEmpty && value.first is double) {
      return 'List<double>';
    } else if (value.isNotEmpty && value.first is String) {
      return 'List<String>';
    } else if (value.isNotEmpty && value.first is num) {
      return 'List<num>';
    } else if (value.isNotEmpty && value.first is Map) {
      String className = convertToClassName(key);
      return 'List<$className>';
    } else {
      return 'List<dynamic>';
    }
  } else if (value is Map) {
    return _capitalize(key); // Return class name for nested object
  } else if (value is String && _isDateTime(value)) {
    return 'DateTime?';
  }
  return 'String';
}

String convertToClassName(String input) {
  if (input.endsWith('s')) {
    input = input.substring(0, input.length - 1);
  }

  // Convert to camel case
  final camelCase = input
      .split(RegExp(r'[^a-zA-Z0-9]')) // Split by non-alphanumeric characters
      .where((part) => part.isNotEmpty)
      .map((part) => part[0].toUpperCase() + part.substring(1))
      .join();

  return camelCase;
}

String _capitalize(String s) => s[0].toUpperCase() + s.substring(1);

// Helper function to detect DateTime strings
bool _isDateTime(String value) {
  final RegExp noSeparatorPattern = RegExp(r'^\d{8}$');
  if (noSeparatorPattern.hasMatch(value)) {
    return false;
  }
  try {
    final data = DateTime.parse(value);
    return true;
  } catch (e) {
    return false;
  }
}
