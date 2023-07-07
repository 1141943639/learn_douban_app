// import 'package:copy_to_app/common/components/common_header_wrap.dart';
// import 'package:copy_to_app/common/config/theme.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hexcolor/hexcolor.dart';

// class MeNotLoginPage extends StatefulWidget {
//   const MeNotLoginPage({super.key});

//   @override
//   State<MeNotLoginPage> createState() => _MeNotLoginPageState();
// }

// class _MeNotLoginPageState extends State<MeNotLoginPage> with RouteAware {
//   bool showOtherLoginMethod = false;
//   List<String> otherLoginMethodImgUrl = [
//     'assets/images/common/login_wechat@2x.png',
//     'assets/images/common/login_qq@2x.png',
//     'assets/images/common/login_sina@2x.png',
//     'assets/images/common/login_phone@2x.png',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // 头部
//         CommonHeaderWrap(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               InkWell(
//                 child: SizedBox(
//                   width: 20,
//                   height: 20,
//                   child: Image.asset(
//                     'assets/images/common/navi_item_setting@2x.png',
//                   ),
//                 ),
//               ),
//               InkWell(
//                 child: SizedBox(
//                   width: 20,
//                   height: 20,
//                   child: Image.asset(
//                     'assets/images/common/navi_item_messages.png',
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         // 文本
//         Container(
//           margin: const EdgeInsets.only(top: 30),
//           child: const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 30),
//             child: Row(
//               children: [
//                 Text(
//                   '豆果美食\n会做饭很酷~',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         // 登录入口
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // 手机号登录
//                 InkWell(
//                   onTap: () {
//                     context.push('/login');
//                   },
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(30),
//                     child: Container(
//                       height: 50,
//                       color: ThemeColor.primaryYellow,
//                       child: const Center(
//                         child: Text(
//                           '手机号登录',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Gap(20),
//                 // 使用Apple登录
//                 InkWell(
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: HexColor('#f6f6f6'),
//                         borderRadius: BorderRadius.circular(30),
//                         border: Border.all(width: 2)),
//                     height: 50,
//                     child: const Center(
//                       child: Text(
//                         '通过 Apple 登录',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Gap(40),
//                 GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       showOtherLoginMethod = !showOtherLoginMethod;
//                     });
//                   },
//                   child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           '其他登录方式',
//                           style: TextStyle(color: HexColor('#8e8e8e')),
//                         ),
//                         Gap(5),
//                         Image.asset(
//                           showOtherLoginMethod
//                               ? 'assets/images/common/icon_topic_up@2x.png'
//                               : 'assets/images/common/icon_topic_down@2x.png',
//                           width: 15,
//                           height: 15,
//                         )
//                       ]),
//                 ),
//                 Gap(30),

//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 30),
//                   height: 30,
//                   child: showOtherLoginMethod
//                       ? Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: otherLoginMethodImgUrl
//                               .map((e) => Image.asset(
//                                     e,
//                                     width: 30,
//                                     height: 30,
//                                   ))
//                               .toList(),
//                         )
//                       : SizedBox(),
//                 )
//               ],
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
