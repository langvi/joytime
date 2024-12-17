import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
final getIt = GetIt.instance;

