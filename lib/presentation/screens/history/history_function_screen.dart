import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/history_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/widgets/button_widget.dart';

import '../../bloc/events/history_events.dart';

class HistoryFunctionScreen extends StatelessWidget {
  const HistoryFunctionScreen({super.key});

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
          'Lịch sử',
          style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconCustomizedButton(
              icon: Icons.input_rounded,
              text: "LỊCH SỬ NHẬP",
                onPressed: () {
                BlocProvider.of<HistoryBloc>(context)
                    .add(GetAllInfoImportEvent(DateTime.now()));
                Navigator.pushNamed(context, '/import_history_screen');    
              }),
          IconCustomizedButton(
              icon: Icons.output_rounded,
              text: "LỊCH SỬ XUẤT",
              onPressed: () {
                BlocProvider.of<HistoryBloc>(context)
                    .add(GetAllInfoExportEvent(DateTime.now()));
                Navigator.pushNamed(context, '/export_history_screen');    
              }),
        ],
      )),
    );
  }
}
