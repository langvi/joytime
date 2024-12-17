import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:joytime/bloc/common/common_state.dart';

@Injectable()
class CommonCubit extends Cubit<CommonState> {
  CommonCubit() : super(CommonState());
  void setLoading(bool value) {
    emit(state.copyWith(isLoading: value));
  }
}
