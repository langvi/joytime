import 'package:injectable/injectable.dart';
import 'package:joytime/bloc/base_cubit.dart';
part 'sign_in_state.dart';

@Injectable()
class SignInCubit extends BaseCubit<SignInState> {
  SignInCubit() : super(SignInState());
}
