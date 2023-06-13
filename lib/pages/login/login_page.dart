// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:copy_to_app/common/components/common_header_wrap.dart';
import 'package:copy_to_app/common/config/theme.dart';
import 'package:copy_to_app/pages/login/widgets/verify_code_input.dart';
import 'package:copy_to_app/utils/app_dialog.dart';
import 'package:copy_to_app/utils/enum_helper.dart';

import '../../common/sqlite/user_db_provider.dart';

final CommonInputDecoration = InputDecoration(
    hintStyle: TextStyle(fontSize: 12),
    contentPadding: EdgeInsets.symmetric(vertical: 20),
    focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: HexColor('#f5f5f5'))),
    enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: HexColor('#f5f5f5'))));

enum LoginType { verifyCode, password }

class VerifyCodeModal {
  String? phone;
  String? verifyCode;
  VerifyCodeModal({
    this.phone,
    this.verifyCode,
  });

  VerifyCodeModal copyWith({
    String? phone,
    String? verifyCode,
  }) {
    return VerifyCodeModal(
      phone: phone ?? this.phone,
      verifyCode: verifyCode ?? this.verifyCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phone': phone,
      'verifyCode': verifyCode,
    };
  }

  factory VerifyCodeModal.fromMap(Map<String, dynamic> map) {
    return VerifyCodeModal(
      phone: map['phone'] != null ? map['phone'] as String : null,
      verifyCode:
          map['verifyCode'] != null ? map['verifyCode'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VerifyCodeModal.fromJson(String source) =>
      VerifyCodeModal.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'VerifyCodeModal(phone: $phone, verifyCode: $verifyCode)';

  @override
  bool operator ==(covariant VerifyCodeModal other) {
    if (identical(this, other)) return true;

    return other.phone == phone && other.verifyCode == verifyCode;
  }

  @override
  int get hashCode => phone.hashCode ^ verifyCode.hashCode;
}

String? checkPhone(String? phone) {
  if (phone?.length != 11) {
    return '手机号码格式不正确';
  }

  return null;
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formGroups = {
    LoginType.password: FormGroup({
      'phone': FormControl<String>(validators: [Validators.required]),
      'password': FormControl<String>(validators: [Validators.required]),
    }),
    LoginType.verifyCode: FormGroup({
      'phone': FormControl<String>(validators: [Validators.required]),
      'verifyCode': FormControl<String>(validators: [Validators.required]),
    })
  };
  late FormGroup form;

  StreamSubscription? sub;

  final formValid = ValueNotifier(false);

  List<String> otherLoginMethodImgUrl = [
    'assets/images/common/login_wechat@2x.png',
    'assets/images/common/login_qq@2x.png',
    'assets/images/common/login_sina@2x.png',
  ];

  LoginType loginType = LoginType.password;

  useLoginType(Map<LoginType, dynamic> value) {
    return value[loginType];
  }

  @override
  void initState() {
    handleChangeForm();

    super.initState();
  }

  @override
  void dispose() {
    sub?.cancel();
    super.dispose();
  }

  void handleSave() async {
    if (form.valid == false) return;

    final formValue = UserModel.fromMap(form.value);

    final message = checkPhone(formValue.phone);

    if (message != null) {
      AppDialog.showToast(context, msg: message);
      return;
    }

    final userDB = UserDBProvider();
    await userDB.open();
    // await userDB.inert(formValue.toJson());
    final userData = await userDB.getUserByPhone(formValue.phone!);

    if (userData == null) {
      AppDialog.showToast(context, msg: '找不到用户, 请先注册~');
      return;
    }

    if (userData.password != formValue.password) {
      AppDialog.showToast(context, msg: '密码不正确~');
      return;
    }

    // TODO 需要处理把登录状态和用户信息存到bloc里面

    context.pop();

    AppDialog.showToast(context, msg: '登录成功!');
  }

  handleChangeLoginType() {
    setState(() {
      final newType = EnumHelper.useEnum(loginType, {
        LoginType.password: LoginType.verifyCode,
        LoginType.verifyCode: LoginType.password
      }) as LoginType;
      loginType = newType;
      form.reset();
      formValid.value = false;

      handleChangeForm();
    });
  }

  handleChangeForm() {
    form = EnumHelper.useEnum(loginType, formGroups);

    sub?.cancel();
    sub = form.statusChanged.listen((event) {
      if (event == ControlStatus.valid) {
        formValid.value = true;
        return;
      }

      formValid.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonHeaderWrap(
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  context.pop();
                },
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: Image.asset(
                    'assets/images/common/tab_icon_back.png',
                  ),
                ),
              ),
              InkWell(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: Image.asset(
                    'assets/images/common/login_help@2x.png',
                  ),
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(30),
                    Text(
                      EnumHelper.useEnum(loginType, {
                        LoginType.password: '密码登录',
                        LoginType.verifyCode: '验证码登录'
                      }),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                    ),
                    Gap(10),
                    Text(
                      'Hi, 欢迎来到豆果美食会做饭很酷~',
                      style: TextStyle(color: HexColor('#c7c7c7')),
                    ),
                  ],
                ),
              ],
            ),
            Gap(60),
            ReactiveForm(
              key: Key(loginType.toString()),
              formGroup: form,
              child: Column(children: [
                ReactiveTextField(
                  formControlName: 'phone',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  autofocus: true,
                  showErrors: (_) => false,
                  onChanged: (value) {
                    print(formGroups[LoginType.password]?.value);
                    print(form.value);
                    print(value.value);
                  },
                  keyboardType: TextInputType.phone,
                  decoration: CommonInputDecoration.copyWith(
                    prefixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '+86',
                          style: TextStyle(color: HexColor('#000000')),
                        ),
                        Gap(10),
                        Image.asset(
                          'assets/images/common/icon_topic_down@2x.png',
                          width: 15,
                          height: 15,
                        ),
                        Gap(10)
                      ],
                    ),
                    hintText: '请输入手机号',
                  ),
                ),
                EnumHelper.useEnum(loginType, {
                  LoginType.password: ReactiveTextField(
                    formControlName: 'password',
                    obscureText: true,
                    showErrors: (_) => false,
                    decoration: CommonInputDecoration.copyWith(
                      hintText: '请输入密码',
                    ),
                  ),
                  LoginType.verifyCode: VerifyCodeInput(
                    form: form,
                  )
                })
              ]),
            ),
            Gap(20),
            /**
                 * 提交按钮
                 */
            ValueListenableBuilder(
              builder: (context, formValid, child) => GestureDetector(
                onTap: handleSave,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: formValid
                          ? ThemeColor.primaryYellow
                          : HexColor('#f0f0f0')),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          '登录',
                          style: TextStyle(
                              color: formValid
                                  ? Colors.black
                                  : HexColor('#b5b5b5'),
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              valueListenable: formValid,
            ),
            Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: handleChangeLoginType,
                    child: Text(EnumHelper.useEnum(loginType, {
                      LoginType.password: '验证码登录',
                      LoginType.verifyCode: '密码登录'
                    }))),
                Text('注册')
              ],
            ),
            Gap(30),
            Row(
              children: [
                Text('其他登录方式'),
              ],
            ),
            Gap(20),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: otherLoginMethodImgUrl
                        .map((e) => Image.asset(
                              e,
                              width: 30,
                              height: 30,
                            ))
                        .toList(),
                  ),
                ),
                Spacer(
                  flex: 1,
                )
              ],
            ),
            Gap(20),
            Align(
              alignment: Alignment.topLeft,
              child: Wrap(children: [
                Text(
                  '登录即同意',
                  style: TextStyle(color: HexColor('#a0a09f')),
                ),
                Text(
                  '《联通/移动同意认证服务条款》',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '《用户协议》',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '《用户协议》',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ]),
            )
          ]),
        )
      ],
    );
  }
}
