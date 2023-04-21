import 'package:flutter/material.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import 'package:mobile_warehouse_thaiduong/presentation/widgets/lot_detail_component.dart';

class ListLotIssueCompletedScreen extends StatelessWidget {
  const ListLotIssueCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
            icon: const Icon(
              Icons.west, //mũi tên back
              color: Colors.white,
            ),
            onPressed: () {
             Navigator.pushNamed(context, '/export_main_screen');
            },
          ),
          backgroundColor: Constants.mainColor,
          title: Text(
            'Danh sách hàng hóa',
            style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
          ),
        ),
        body: ListView.builder(
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return LotDetailComponent(
                  itemId: 'CDP001',
                  location: '',
                  enableEdit: false,
                  lotid: '220123_NCC',
                  numberPO: '264836',
                  unit: 'cái',
                  quantity: 100,
                  sublotSize: 10,
                  onPressed: () {});
            }),
      ),
    );
  }
}