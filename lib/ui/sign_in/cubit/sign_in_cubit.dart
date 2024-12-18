import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:joytime/bloc/base_cubit.dart';
import 'package:joytime/data/repository/auth_repository.dart';
part 'sign_in_state.dart';

@Injectable()
class SignInCubit extends BaseCubit<SignInState> {
  SignInCubit(this.authRepository) : super(SignInState());
  final AuthRepository authRepository;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  void signIn() async {
    await runBlocCatching(
      action: () async {
        var res = await authRepository.signIn(
            username: usernameController.text,
            password: passwordController.text);
        navigator.showFlushBar("Sign in successfully!");
      },
    );
  }
}
