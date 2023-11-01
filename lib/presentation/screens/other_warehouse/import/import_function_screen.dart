import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/receipt_bloc/uncompleted_receipt_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/other/receipt_event/uncompleted_receipt_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/widgets/button_widget.dart';

class ImportFunctionScreen extends StatelessWidget {
  const ImportFunctionScreen({super.key});
  
 

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
            'Nhập kho',
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
                  // BlocProvider.of<CreateReceiptBloc>(context)
                  //     .add(GetAllItemEvent(DateTime.now()));
                  Navigator.pushNamed(context, '/create_receipt_screen');
                }),
            IconCustomizedButton(
                icon: Icons.add_location_alt,
                text: "DS PHIẾU CHƯA HOÀN THÀNH",
                onPressed: () {
               
                  BlocProvider.of<ExportingReceiptBloc>(context)
                      .add(LoadUncompletedGoodsReceiptEvent(DateTime.now()));
                  Navigator.pushNamed(context, '/importing_receipt_screen');
      
                }),
            IconCustomizedButton(
                icon: Icons.list_alt_outlined,
                text: "DS PHIẾU ĐÃ HOÀN THÀNH",
                onPressed: () {
                  Navigator.pushNamed(context, '/imported_receipt_screen');
                }),
          ],
        )),
      ),
    );
  }
}
