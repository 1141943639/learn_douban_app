import 'package:copy_to_app/common/cubit/common_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'me_not_login_page.dart';

class MePage extends StatefulWidget {
  const MePage({super.key});

  @override
  State<MePage> createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommonCubit, CommonState>(builder: (_, state) {
      return state.user == null ? MeNotLoginPage() : SizedBox();
    });
  }
}
