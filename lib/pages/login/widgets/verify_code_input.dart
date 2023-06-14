import 'package:copy_to_app/pages/login/cubit/login_cubit.dart';
import 'package:copy_to_app/widgets/multiple_value_listenable_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../login_page.dart';

class VerifyCodeInput extends StatefulWidget {
  VerifyCodeInput({super.key, required this.form});

  final FormGroup form;

  @override
  State<VerifyCodeInput> createState() => _VerifyCodeInputState();
}

class _VerifyCodeInputState extends State<VerifyCodeInput> {
  late ValueNotifier<VerifyCodeModal> formValue =
      ValueNotifier(VerifyCodeModal.fromMap(widget.form.value));

  @override
  void initState() {
    super.initState();

    widget.form.valueChanges.listen((event) {
      formValue.value = VerifyCodeModal.fromMap(event!);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  LoginState get loginState => context.read<LoginCubit>().state;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ReactiveTextField(
            formControlName: 'verifyCode',
            showErrors: (_) => false,
            style: TextStyle(fontSize: 12),
            textAlignVertical: TextAlignVertical.center,
            decoration: commonInputDecoration.copyWith(
              hintText: '请输入验证码',
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (loginState.countdownTimer.isCountdown) return;

            loginState.countdownTimer.start();
            // widget.form.controls.update('verifyCode', (value) => );
          },
          child: MultipleValueListenableBuilder(
            multipleValueListenable: [
              formValue,
              loginState.countdownTimer.time
            ],
            builder: (_, values, ___) {
              final formValue = values[0] as VerifyCodeModal;
              final time = values[1] as int;

              return Text(
                loginState.countdownTimer.isCountdown ? '已发送${time}s' : '获取验证码',
                style: TextStyle(
                    fontSize: 12,
                    color: formValue.phone == null ||
                            checkPhone(formValue.phone) != null ||
                            loginState.countdownTimer.isCountdown
                        ? HexColor('#dcdcdc')
                        : HexColor('#1fdef8')),
              );
            },
          ),
        )
      ],
    );
  }
}
