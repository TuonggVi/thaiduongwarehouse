import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import 'package:mobile_warehouse_thaiduong/presentation/widgets/button_widget.dart';

import '../../../bloc/blocs/other/isolation_bloc.dart';
import '../../../bloc/events/other/isolation_events.dart';

class IsolationFunctionScreen extends StatelessWidget {
  const IsolationFunctionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
       onWillPop: () async {
        Navigator.pushNamed(context, "/main_screen");
        return false;
      },
      child: Scaffold(
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
            'Cách ly',
            style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
          ),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconCustomizedButton(
                icon: Icons.remove_moderator_outlined,
                text: "THÊM MỚI",
                onPressed: () {
                  Navigator.pushNamed(context, '/isolation_item_screen');
                  //  Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) =>
                  //                 const IsolationItemScreen()),
                  //       );
                }),
            IconCustomizedButton(
                icon: Icons.list_alt_outlined,
                text: "DANH SÁCH HÀNG HÓA ĐANG CÁCH LY",
                onPressed: () {
                  BlocProvider.of<IsolationBloc>(context)
                      .add(GetAllIsolationLotEvent(DateTime.now()));
                  Navigator.pushNamed(context, '/list_isolated_screen');
                }),
          ],
        )),
      ),
    );
  }
}
