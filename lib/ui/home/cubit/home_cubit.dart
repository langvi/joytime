import 'package:injectable/injectable.dart';
import 'package:joytime/bloc/base_cubit.dart';

part 'home_state.dart';

@Injectable()
class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit() : super(HomeState());
  int counter = 0;
  void count() async {
    // showLoading();
    // await Future.delayed(Duration(seconds: 1));
    counter++;
    emit(state.copyWith(count: counter));
    // hideLoading();
  }

  void seActive(bool value) async {
    // showLoading();
    // await Future.delayed(Duration(seconds: 1));
    emit(state.copyWith(isActive: value));
    // hideLoading();
  }
}
