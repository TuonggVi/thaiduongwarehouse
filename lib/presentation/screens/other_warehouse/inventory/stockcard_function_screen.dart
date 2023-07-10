import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import 'package:mobile_warehouse_thaiduong/presentation/widgets/button_widget.dart';

import '../../../bloc/blocs/other/inventory_bloc.dart';
import '../../../bloc/events/other/inventory_events.dart';

class StockcardFunctionScreen extends StatelessWidget {
  const StockcardFunctionScreen({super.key});

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
            'Tồn kho',
            style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
          ),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconCustomizedButton(
                icon: Icons.qr_code_scanner_outlined,
                text: "QUÉT MÃ SẢN PHẨM",
                onPressed: () {
                  Navigator.pushNamed(context, '/scan_item_screen');
                }),
            IconCustomizedButton(
                icon: Icons.inventory_2,
                text: "TRUY XUẤT TỒN KHO",
                onPressed: () {
                  BlocProvider.of<InventoryBloc>(context)
                      .add(GetWarehouseIdEvent(DateTime.now()));
                  Navigator.pushNamed(context, '/inventory_screen');
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const ProductStockcardScreen()),
                  // );
                }),
            // IconCustomizedButton(
            //     icon: Icons.storm_rounded, text: "TỒN KHO NGUYÊN VẬT LIỆU", onPressed: () {
            //       Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) =>
            //                       const MaterialStockcardScreen()),
            //             );
            //     }),
          ],
        )),
      ),
    );
  }
}
