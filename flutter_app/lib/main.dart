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
import 'package:provider/provider.dart';

import 'MainPage.dart';
import 'client/ResultDto.dart';
import 'client/UserAppService.dart';
import 'lotfilter/domain/DanMaRepo.dart';
import 'lotfilter/infra/DanMaRepoImpl.dart';
import 'lotfilter/ui/LotteryRepo.dart';
import 'user/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: DanMaRepoImpl(),
        child:  MaterialApp(home:MainPage()),

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
    var userModel = Provider.of<UserModelVM>(context, listen: false);//todo
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
