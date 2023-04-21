// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/goods_receipt.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/receipt_bloc/completed_receipt_lot_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/receipt_state/completed_receipt_lot_state.dart';
import '../../../function.dart';

class ListCompletedLotReceiptScreen extends StatelessWidget {
  const ListCompletedLotReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    List<GoodsReceiptLot> goodsReceiptLot;

    return Scaffold(
      appBar: AppBar(
         leading: IconButton(
            icon: const Icon(
              Icons.west, //mũi tên back
              color: Colors.white,
            ),
            onPressed: () {
             Navigator.pushNamed(context, '/imported_receipt_screen');
            },
          ),
        backgroundColor: Constants.mainColor,
        title: Text(
          'Danh sách lô đã nhập',
          style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
        ),
      ),
      body: BlocBuilder<CompletedReceiptLotBloc, CompletedReceiptLotState>(
          builder: (context, state) {
        if (state is LoadGoodsReceiptLotSuccessState) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const Divider(
                  indent: 30,
                  endIndent: 30,
                  color: Constants.mainColor,
                  thickness: 1,
                ),
                SizedBox(
                  height: 470 * SizeConfig.ratioHeight,
                  child: ListView.builder(
                      itemCount: state.goodsReceiptLots.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            width: 350 * SizeConfig.ratioWidth,
                            height: 80 * SizeConfig.ratioHeight,
                            color: Constants.buttonColor,
                          ),
                        );
                      }),
                ),
               // CustomizedButton(text: "Truy xuất", onPressed: () {})
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}