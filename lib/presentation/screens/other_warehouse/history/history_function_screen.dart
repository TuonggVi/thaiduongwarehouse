import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/history_bloc/export_history_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/history_bloc/import_history_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/widgets/button_widget.dart';

import '../../../bloc/events/other/history_event/export_history_event.dart';
import '../../../bloc/events/other/history_event/import_history_event.dart';

class HistoryFunctionScreen extends StatelessWidget {
  const HistoryFunctionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
       onWillPop: () async {
        Navigator.pushNamed (context, "/main_screen");
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
                    BlocProvider.of<ImportHistoryBloc>(context)
                      .add(GetAllInfoImportEvent(DateTime.now()));
                  Navigator.pushNamed(context, '/import_history_screen');    
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const ImportHistoryScreen()),
                  // );
                }),
            IconCustomizedButton(
                icon: Icons.output_rounded,
                text: "LỊCH SỬ XUẤT",
                onPressed: () {
                   BlocProvider.of<ExportHistoryBloc>(context)
                      .add(GetAllInfoExportEvent(DateTime.now()));
                  Navigator.pushNamed(context, '/export_history_screen');   
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const ExportHistoryScreen()),
                  // );
                }),
          ],
        )),
      ),
    );
  }
}
