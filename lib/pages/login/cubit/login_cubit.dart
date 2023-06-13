import 'package:bloc/bloc.dart';
import 'package:copy_to_app/utils/timer.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());
}
