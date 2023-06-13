// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:copy_to_app/pages/login/login_page.dart';
import 'package:copy_to_app/pages/me/me_page.dart';

// const NEXT_PAGE_DURATION = Duration(milliseconds: 150);
// const CURRENT_PAGE_DURATION = Duration(milliseconds: 200);

// class MyRouteObserver extends RouteObserver {
//   @override
//   void didPop(Route route, Route? previousRoute) {
//     // TODO: implement didPop
//     super.didPop(route, previousRoute);
//   }
// }

// final routeObserver = MyRouteObserver();

// class RouterHistoryState {
//   String name;
//   Widget widget;

//   RouterHistoryState({
//     required this.name,
//     required this.widget,
//   });

//   @override
//   bool operator ==(covariant RouterHistoryState other) {
//     if (identical(this, other)) return true;

//     return other.name == name && other.widget == widget;
//   }

//   @override
//   int get hashCode => name.hashCode ^ widget.hashCode;
// }

// class RouterHelper {
//   StreamController<RouterHistoryState> routeStreamController =
//       StreamController<RouterHistoryState>.broadcast();

//   static RouterHelper? _instance;

//   List<RouterHistoryState> _value = [];

//   List<RouterHistoryState> get value => _value;

//   Stream<RouterHistoryState> get routeStream => routeStreamController.stream;

//   static RouterHelper get instance {
//     if (_instance == null) _instance = RouterHelper();
//     return _instance as RouterHelper;
//   }

//   add(RouterHistoryState data) {
//     _value.add(data);
//     routeStreamController.add(data);
//   }

//   remove(RouterHistoryState data) {
//     _value.remove(data);
//     routeStreamController.add(_value.last);
//   }
// }

final router = GoRouter(initialLocation: '/me', routes: [
  AppRoute(
    path: '/me',
    builder: (state) => const MePage(),
  ),
  AppRoute(path: '/login', builder: (state) => LoginPage()),
]);

class AppRoute extends GoRoute {
  AppRoute(
      {
      // 路由路径
      required path,
      // 构建函数
      required Widget Function(GoRouterState state) builder,
      // 子路由
      List<GoRoute> routes = const []})
      : super(
            path: path,
            routes: routes,
            pageBuilder: (context, state) {
              // 自定义路由过渡
              // return CustomTransitionPage(
              //   key: state.pageKey,
              //   child: PageRoot(
              //     child: builder(state),
              //     path: path,
              //   ),
              //   transitionDuration: NEXT_PAGE_DURATION,
              //   transitionsBuilder:
              //       (context, animation, secondaryAnimation, child) {
              //     // 过渡效果
              //     return SlideTransition(
              //       position:
              //           Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
              //               .animate(CurvedAnimation(
              //                   parent: animation, curve: Curves.easeInOut)),
              //       child: child,
              //     );
              //   },
              // );
              return CupertinoPage(
                  child: Scaffold(
                body: SafeArea(child: builder(state)),
              ));
            });
}

// 定义一个页面根组件
// class PageRoot extends StatefulWidget {
//   PageRoot({super.key, required this.child, required this.path});

//   final Widget child;
//   final String path;

//   @override
//   State<PageRoot> createState() => _PageRootState();
// }

// class _PageRootState extends State<PageRoot>
//     with SingleTickerProviderStateMixin, RouteAware {
//   bool needLog = true;

//   late Animation<Offset> _animation;
//   late AnimationController _controller;
//   late StreamSubscription subscript;

//   // 获取路由信息
//   get RouteInfo => RouterHistoryState(name: widget.path, widget: widget);

//   @override
//   void didUpdateWidget(covariant PageRoot oldWidget) {
//     // 订阅路由变化
//     routeObserver.subscribe(this, ModalRoute.of(context)!);

//     if (needLog) {
//       // 替换路由信息
//       final index = RouterHelper.instance.value
//           .indexWhere((element) => oldWidget == element.widget);
//       if (index >= 0) {
//         RouterHelper.instance.value.replaceRange(index, index + 1, [RouteInfo]);
//       }
//     }

//     super.didUpdateWidget(oldWidget);
//   }

//   @override
//   void didPop() {
//     super.didPop();

//     if (needLog) {
//       // 移除路由信息
//       subscript.cancel();
//       RouterHelper.instance.remove(RouteInfo);
//     }
//     print('${widget.path} ${RouterHelper.instance.value}');
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     // 取消路由订阅
//     routeObserver.unsubscribe(this);
//   }

//   @override
//   void initState() {
//     // 判断是否需要记录路由信息
//     needLog = RouterHelper.instance.value
//         .where((element) => element == RouteInfo)
//         .isEmpty;

//     // 初始化动画控制器
//     _controller = AnimationController(
//       duration: CURRENT_PAGE_DURATION,
//       vsync: this,
//     );

//     // 初始化动画
//     _animation = Tween<Offset>(
//       begin: Offset.zero,
//       end: Offset(-0.5, 0),
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

//     if (needLog) {
//       // 添加路由信息
//       RouterHelper.instance
//           .add(RouterHistoryState(name: widget.path, widget: widget));

//       print('${widget.path} ${RouterHelper.instance.value}');
//     }

//     // 订阅路由变化
//     subscript = RouterHelper.instance.routeStream.listen((data) {
//       print(data.name == widget.path);
//       if (data.name == widget.path) {
//         _controller.reverse();
//       } else {
//         _controller.forward();
//       }
//     });

//     // 延迟订阅路由变化
//     Future.delayed(Duration.zero, () {
//       routeObserver.subscribe(this, ModalRoute.of(context)!);
//     });

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // 页面过渡动画
//     return SlideTransition(
//       position: _animation,
//       child: Scaffold(
//         body: SafeArea(child: widget.child),
//       ),
//     );
//   }
// }
