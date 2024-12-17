# Joytime

A new Flutter project.

## Getting Started

# Navigation (Chuyển màn):
- Lib: https://pub.dev/packages/auto_route

* Cài đặt: 
1. Tạo một router class và annotate nó bằng @AutoRouterConfig sau đó mở rộng "RootStackRouter" từ gói auto_route
Override lại routes getter và bắt đầu thêm routes.
```dart
@AutoRouterConfig()
class AppRouter extends RootStackRouter {

 @override
 List<AutoRoute> get routes => [
   /// routes go here
 ];
}
```
- Trong main thì cần triển khai như sau:
```dart
final _appRouter = GetIt.instance.get<AppRouter>();
```
- Trong MaterialApp gọi đến MaterialApp.router:
```dart
return MaterialApp.router(
      title: 'Joytime',
      debugShowCheckedModeBanner: false,
      // theme: darkTheme,
      supportedLocales: S.delegate.supportedLocales,
      locale: Locale(state.languageCode),
      localizationsDelegates: const [
        S.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate
      ],
      themeMode: ThemeMode.light,
      routeInformationParser: _appRouter.defaultRouteParser(),
      routerDelegate: _appRouter.delegate(
        deepLinkBuilder: (deepLink) {
          return const DeepLink([SplashRoute()]);
        },
        navigatorObservers: () => [AppNavigatorObserver()],
      ),
    );`
```
2. Generate auto Route
- Thêm anotation @RoutePage() vào một page bất kì để tạo ra Route cho page đó:
```dart
@RoutePage()
class HomePage extends StatefulWidget {}
```
3. Chạy script để generate route
- Dùng câu lệnh `flutter packages pub run build_runner build` để generate ra các route đã được chú thích(anotation) trước đó
- Đây là một ví dụ về code sau khi generate
```dart
abstract class $AppRouter extends _i6.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
   
    HomeRoute.name: (routeData) {
      final args =
          routeData.argsAs<HomeRouteArgs>(orElse: () => const HomeRouteArgs());
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.HomePage(
          key: args.key,
          title: args.title,
        ),
      );
    },
  };
}
```
4. Cách sử dụng
- Inject `AppNavigator` vào Class khi muốn sử dụng:
```dart
final AppNavigator navigator;
navigator.replace(HomeRoute(title: 'Home'));
```
- Tham khảo thêm cách dùng tại [Auto route](https://pub.dev/documentation/auto_route/latest/)
# Quản lý Dependency injection(DI) với GetIt
1. Tạo một biến getIt global:
```dart
final getIt = GetIt.instance;
```
2. Trong main đăng kí các dependency trong GetIt thông qua hàm `init()`:
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig(
    name: Flavor.PROD.name,
    color: Colors.red,
    location: BannerLocation.topStart,
  );
  await getIt.init();
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}
```
3. Chú thích(anotation) cho các Class cần đăng kí
- `@Injectable()`: để GetIt khởi tạo một instance mới cho Class, ví dụ:
```dart
@Injectable()
class SignInCubit extends BaseCubit<SignInState> {
  SignInCubit() : super(SignInState());
}
```
- `@LazySingleton()`: để GetIt khởi tạo một singleton cho Class , ví dụ:
```dart
@LazySingleton()
class AppPreferences {
  final SharedPreferences _sharedPreference;
  final EncryptedSharedPreferences _encryptedSharedPreferences;
  AppPreferences(this._sharedPreference, this._encryptedSharedPreferences);
  String get deviceToken {
    return _sharedPreference.getString(SharedPreferenceKeys.deviceToken) ?? '';
  }

  String get languageCode =>
      _sharedPreference.getString(SharedPreferenceKeys.languageCode) ?? '';
  bool get isFirstLogin =>
      _sharedPreference.getBool(SharedPreferenceKeys.isFirstLogin) ?? true;
}
```
- `@LazySingleton(as: AuthRepository)`: để GetIt khởi tạo một singleton cho Class được binding với một abstract class , ví dụ:
```dart
@LazySingleton(as: AuthRepository)
class AuthRepositoryIml implements AuthRepository {
  final AppApiAuthService _appApiService;
  final AppPreferences _appPreferences;
  AuthRepositoryIml(
    this._appApiService,
    this._appPreferences,
  );
  @override
  Future<bool> login({required DataLogin dataLogin}) async {
    var res = await _appApiService.login(
        username: dataLogin.username, password: dataLogin.password);
    if (res.isSuccessed) {
      logger.d("Login successfully...");
      return true;
    }
    return false;
  }

  @override
  bool get isLoggedIn => _appPreferences.isLoggedIn;

  @override
  bool get isFirstLaunchApp => _appPreferences.isFirstLaunchApp;

  @override
  void onSaveFirstLaunch(bool isFirst) {
    _appPreferences.saveIsFirsLaunchApp(isFirst);
  }
}
```
4. Generate code
- Dùng câu lệnh `flutter packages pub run build_runner build` để generate ra các class đã được chú thích(anotation) trước đó
```dart
import 'package:get_it/get_it.dart' as _i1;  
  
extension GetItInjectableX on _i1.GetIt {  
  /// initializes the registration of main-scope dependencies inside of [GetIt]  
  Future<_i1.GetIt> init({  
    String? environment,  
    _i2.EnvironmentFilter? environmentFilter,  
  }) async {  
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final serviceModule = _$ServiceModule();
    gh.lazySingleton<_i3.AppApiAuthService>(() => _i3.AppApiAuthService());
    gh.lazySingleton<_i4.AppApiCMSService>(() => _i4.AppApiCMSService());
    gh.factory<_i5.AppBloc>(() => _i5.AppBloc());
  }  
}
```
- Tham khảo thêm cách dùng tại [Injectable](https://pub.dev/documentation/injectable/latest/)
# Generate path Icon, Image
1. Thêm file icon hoặc ảnh vào thư mục assets
- Icon thì thêm vào file `icons`, Ảnh thì thêm vào thư mục `images` trong root project
* Quy tắc đặt tên:
- Icon: ic + (_)dấu gạch dưới + tên icon + extension(.svg). VD: `ic_money.svg`;
- Ảnh: img + (_)dấu gạch dưới + tên ảnh + extension(.png, .jpeg ...). VD: `img_airline.png`;
2. Chạy lệnh script để generate path
- Từ terminal root project: `cd scripts`
- Chạy lệnh `sh read_asset.sh`
- Sau khi chạy xong thì đường dẫn(path) của icon và ảnh sẽ được lưu trong thư mục `lib/resources/assets`
- File `icons.dart`:
```dart
class IconPath {
  static const icon_path = 'assets/icons';


  static const String ic_phone = '$icon_path/ic_phone.svg';
  static const String ic_search_flight = '$icon_path/ic_search_flight.svg';
  static const String ic_manager = '$icon_path/ic_manager.svg';
}
```
- File `images.dart`:
```dart
class ImagePath {
  static const image_path = 'assets/images';


  static const String img_intro = '$image_path/img_intro.svg';
  static const String img_logo_vn_airlines = '$image_path/img_logo_vn_airlines.png';
}
```
# Tự động generate class từ file Json
* Với mong muốn có thể tự customize các file data model trong dự án thì dưới đây là một số hướng dẫn sử dụng
1. Thêm json muốn generate vào file `class_json.json` trong thư mục `scripts`
2. Trong file `generate.dart` cần đặt tên cho Class cần generate trong function `generateDartClass`:
```dart
  String generatedClass =
      '''import 'package:joytime/utils/safety_parser.dart';\n''';
  // Cần đặt tên cho class
  generatedClass += generateDartClass('Trip', jsonData);
```
- Tìm đường dẫn thư mục cần để ghi lại file, VD:
```dart
  Directory dir = Directory('../lib/data');
```
- Đặt tên file và ghi lại:
```dart

  File iconFile = File('${dir.path}/trip.dart');

  iconFile.createSync();
  iconFile.writeAsString(generatedClass);
```
3. Mở terminal trong thư mục `scripts`, chạy câu lệnh `dart generate.dart`
4. Sau khi chạy thành công thì code sẽ được generate thành các class, VD:
```dart
class Airport {
  final String IATACode;
  final String name;
  final String city;
  final String country;
  final DateTime? at;
  final String timezone;
  final String terminal;
  Airport({
    required this.IATACode,
    required this.name,
    required this.city,
    required this.country,
    required this.at,
    required this.timezone,
    required this.terminal,
  });

  factory Airport.fromJson(Map<String, dynamic> json) {
    return Airport(
      IATACode: safeString(json["IATACode"]),
      name: safeString(json["name"]),
      city: safeString(json["city"]),
      country: safeString(json["country"]),
      at: DateTime.tryParse(json["at"] ?? ""),
      timezone: safeString(json["timezone"]),
      terminal: safeString(json["terminal"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "IATACode": IATACode,
      "name": name,
      "city": city,
      "country": country,
      "at": at,
      "timezone": timezone,
      "terminal": terminal,
    };
  }
}
```
** Lưu ý: Nên format lại code sau khi generate

# Tự động generate cubit
* Tạo ra các file và class liên quan đến cubit của một chức năng chứa sẵn những code được sử dụng chung cho Cubit như `BaseCubit`, `BasePageStateDelegate`. 
1. Mở file `cubit_gen.dart` trong thư mục scripts
2. Đặt tên cho chức năng muốn generate VD:
```dart
String name = 'sign_in';
 ```
- Khi này tên của class chứa UI sẽ là SignInPage, tên của class Cubit là SignInCubit, tên của class State là SignInState
3. Chạy câu lệnh `dart cubit_gen.dart` tại thư mục scripts của dự án
** Lưu ý: Nên format lại code sau khi generate