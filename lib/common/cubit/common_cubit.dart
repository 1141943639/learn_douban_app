import 'package:bloc/bloc.dart';
import 'package:copy_to_app/common/sqlite/user_db_provider.dart';

part 'common_state.dart';

class CommonCubit extends Cubit<CommonState> {
  CommonCubit() : super(CommonState());
}
