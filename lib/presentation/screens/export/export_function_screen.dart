

// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/issue_bloc/create_new_issue_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/issue_bloc/list_goods_issue_uncompleted_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/issue_event/create_new_issue_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/issue_event/list_goods_issue_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/screens/export/list_good_issue_completed_screen.dart';
import 'package:mobile_warehouse_thaiduong/presentation/screens/export/list_good_issue_screen.dart';
import 'package:mobile_warehouse_thaiduong/presentation/widgets/button_widget.dart';

class ExportFunctionScreen extends StatelessWidget {
  const ExportFunctionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.west, //mũi tên back
              color: Colors.white,
            ),
            onPressed: () {
             Navigator.pushNamed(context, '/main_screen');
            },
          ),
        backgroundColor: Constants.mainColor,
        title: Text(
          'Xuất kho',
          style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconCustomizedButton(
              icon: Icons.note_add,
              text: "TẠO PHIẾU MỚI",
              onPressed: () {
                //  BlocProvider.of<CreateIssueBloc>(context)
                //     .add(LoadDepartmentIdsEvent(DateTime.now()));
                Navigator.pushNamed(context, '/create_issue_screen');
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const CreateNewIssueScreen()),
                // );
              }),
          IconCustomizedButton(
              icon: Icons.list_alt_outlined,
              text: "DANH SÁCH PHIẾU CẦN XUẤT",
              onPressed: () {
                 BlocProvider.of<ListGoodsIssueUncompletedBloc>(context)
                    .add(LoadGoodsIssuesEvent(DateTime.now()));
                Navigator.pushNamed(context, '/list_goods_issue_screen');
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const ListGoodIssueScreen()),
                // );
              }),
          IconCustomizedButton(
              icon: Icons.fact_check_outlined,
              text: "DANH SÁCH PHIẾU ĐÃ XUẤT",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const ListGoodIssueCompletedScreen()),
                );
              }),
        ],
      )),
    );
  }
}
