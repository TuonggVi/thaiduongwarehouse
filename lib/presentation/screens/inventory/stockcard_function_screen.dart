import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import 'package:mobile_warehouse_thaiduong/presentation/widgets/button_widget.dart';

import '../../bloc/blocs/inventory_bloc.dart';
import '../../bloc/events/inventory_events.dart';

class StockcardFunctionScreen extends StatelessWidget {
  const StockcardFunctionScreen({super.key});

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
                BlocProvider.of<InventoryBloc>(context)
                    .add(GetWarehouseIdEvent(DateTime.now()));
                Navigator.pushNamed(context, '/scan_item_screen');} 
              ),
          IconCustomizedButton(
              icon: Icons.inventory_2, 
              text: "TRUY XUẤT TỒN KHO", 
               onPressed: () {
                BlocProvider.of<InventoryBloc>(context)
                    .add(GetWarehouseIdEvent(DateTime.now()));
                Navigator.pushNamed(context, '/inventory_screen');} 
              ),
         
              
        ],
      )),
    );
  }
}
