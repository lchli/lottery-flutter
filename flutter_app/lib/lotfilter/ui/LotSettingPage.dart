import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/lotfilter/SettingState.dart';
import 'package:flutterapp/lotfilter/domain/DanMaRepo.dart';
import 'package:flutterapp/lotfilter/infra/DanMaRepoImpl.dart';
import 'package:provider/provider.dart';

import '../SettingCubit.dart';

class _Child extends StatelessWidget {
  TextEditingController _controllerHis = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return BlocBuilder<SettingCubit, SettingState>(
        builder: (context, state) {
          return Padding(
              padding: EdgeInsets.only(top: statusBarHeight),
              child: ListView(
                children: [
                  ListTile(
                    title: Text('导入历史开奖号码'),
                    leading: Icon(Icons.import_export),
                    onTap: () {
                      _showFillHaoMaDialog(
                          context, context.read<SettingCubit>());
                    },
                  ),
                  ListTile(
                    title: Text('版本号1.0'),
                    leading: Icon(Icons.update),
                  ),
                ],
              ));
        });
  }

  _showFillHaoMaDialog(BuildContext contextOuter, SettingCubit cubit) {
    double statusBarHeight = MediaQuery.of(contextOuter).padding.top;

    var sheet = showBottomSheet(
      context: contextOuter,
      builder: (context) {
        final theme = Theme.of(context);
        // Using Wrap makes the bottom sheet height the height of the content.
        // Otherwise, the height will be half the height of the screen.
        return Column(
          children: [
            Container(height: statusBarHeight),
            ListTile(
              title: GestureDetector(
                child: Text(
                  '确定',
                  style: theme.textTheme.subtitle1
                      .copyWith(color: theme.colorScheme.onPrimary),
                  textAlign: TextAlign.right,
                ),
                onTap: () {
                  cubit.importHis(_controllerHis.text);
                  Navigator.of(contextOuter).pop();
                },
              ),
              tileColor: theme.colorScheme.primary,
            ),
            Expanded(
                child: TextField(
                  controller: _controllerHis,
                  maxLines: 100,
                  readOnly: false,
                )),
          ],
        );
      },
    );
  }
}

class LotSettingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingCubit>(
        create: (_) => SettingCubit(DanMaRepoImpl()),
        child: _Child());
  }


}
