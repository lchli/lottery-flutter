// Step 5: Add a lazily loading infinite scrolling ListView.
// Also, add a heart icon so users can favorite word pairings.
// Save the word pairings in the State class.
// Make the hearts tappable and save the favorites list in the
// State class.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/lotfilter/app/FilterAppServiceImpl.dart';
import 'package:flutterapp/lotfilter/client/FilterAppService.dart';
import 'package:flutterapp/lotfilter/ui/FilterPage.dart';
import 'package:flutterapp/user/UserModelVM.dart';
import 'package:flutterapp/user/app/UserAppServiceImpl.dart';
import 'package:flutterapp/user/domain/User.dart';
import 'package:flutterapp/user/infas/UserRepoImpl.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

import 'InitBinding.dart';
import 'MainPage.dart';
import 'client/ResultDto.dart';
import 'client/UserAppService.dart';
import 'lotfilter/DanMaPre1.dart';
import 'lotfilter/DanMaPre1Controller.dart';
import 'lotfilter/DanMaPre2Controller.dart';
import 'lotfilter/DanMaPre3Controller.dart';
import 'lotfilter/PreController.dart';
import 'lotfilter/HeweiPreController.dart';
import 'lotfilter/KuaduPreController.dart';
import 'lotfilter/MainPageController.dart';
import 'lotfilter/Routes.dart';
import 'lotfilter/domain/DanMaRepo.dart';
import 'lotfilter/infra/DanMaRepoImpl.dart';
import 'lotfilter/ui/LotteryRepo.dart';
import 'user/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
          ClampingScrollWrapper.builder(context, widget),
          maxWidth: 1200,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(480, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ],
          background: Container(color: Color(0xFFF5F5F5))),
      initialRoute: "/",
      initialBinding: InitBinding(),
      getPages: [
        GetPage(
            name: Routes.HOME,
            page: () => MainPage(),
            binding: BindingsBuilder(() {
             // Get.lazyPut<DanMaRepo>(() => DanMaRepoImpl());
              Get.lazyPut<MainPageController>(() => MainPageController());
            })),
        GetPage(
            name: Routes.danma_pre,
            page: () => DanMaPre1(),
            binding: BindingsBuilder(() {
              Get.lazyPut<PreController>(() => DanMaPre1Controller(),tag: Routes.danma_pre);
            })),
        GetPage(
            name: Routes.danma_pre2,
            page: () => DanMaPre1(),
            binding: BindingsBuilder(() {
              Get.lazyPut<PreController>(() => DanMaPre2Controller(),tag: Routes.danma_pre2);
            })),
        GetPage(
            name: Routes.danma_pre3,
            page: () => DanMaPre1(),
            binding: BindingsBuilder(() {
              Get.lazyPut<PreController>(() => DanMaPre3Controller(),tag: Routes.danma_pre3);
            })),
        GetPage(
            name: Routes.hewei_pre,
            page: () => DanMaPre1(),
            binding: BindingsBuilder(() {
              Get.lazyPut<PreController>(() => HeweiPreController(),tag: Routes.hewei_pre);
            })),
        GetPage(
            name: Routes.kuadu_pre,
            page: () => DanMaPre1(),
            binding: BindingsBuilder(() {
              Get.lazyPut<PreController>(() => KuaduPreController(),tag: Routes.kuadu_pre);
            })),
      ],
    );
  }

  static UserAppService provideUserAppService() {
    return UserAppServiceImpl(UserRepoImpl());
  }

  static FilterAppService provideFilterAppService() {
    return FilterAppServiceImpl();
  }

  static DanMaRepo provideDanMaRepo() {
    return DanMaRepoImpl();
  }
}

class SplashPage extends StatefulWidget {
  @override
  createState() => new SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  void initState() {
    super.initState();
    _checkUserSession();
  }

  _checkUserSession() async {
    var userModel = Provider.of<UserModelVM>(context, listen: false); //todo
    Result<User> res = await userModel.getUserSession();
    if (res.hasError() || res.data == null) {
      Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(
        builder: (context) {
          return new Login();
        },
      ), (Route<dynamic> route) => false);
    } else {
      _gotoMain();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Text("");
  }

  void _gotoMain() {
    Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(
      builder: (context) {
        return new MainPage();
      },
    ), (Route<dynamic> route) => false);
  }
}
