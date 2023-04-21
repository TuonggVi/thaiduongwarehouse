import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import 'package:mobile_warehouse_thaiduong/presentation/widgets/button_widget.dart';

import '../../bloc/blocs/isolation_bloc.dart';
import '../../bloc/events/isolation_events.dart';


class IsolationFunctionScreen extends StatelessWidget {
  const IsolationFunctionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Constants.mainColor,
        leading: IconButton(
            icon: const Icon(Icons.west_outlined),
            onPressed: () {
                 Navigator.pushNamed(context, '/main_screen');
            },
          ),
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
              text: "CÁCH LY HÀNG HÓA", 
              onPressed: () {
                BlocProvider.of<IsolationBloc>(context)
                    .add(GetAllItemEvent(DateTime.now()));
                   Navigator.pushNamed(context, '/isolation_item_screen'   
                      );
              }),
          IconCustomizedButton(
              icon: Icons.list_alt_outlined, 
              text: "DANH SÁCH HÀNG HÓA ĐANG CÁCH LY", 
              onPressed: () {
              BlocProvider.of<IsolationBloc>(context)
                    .add(GetAllIsolationLotEvent(DateTime.now()));
                Navigator.pushNamed(context, '/isolation_update_screen');    
              }), 
        ],
      )),
    );
  }
}
