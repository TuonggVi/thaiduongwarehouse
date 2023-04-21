import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/goods_issue.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/issue_event/list_lot_issue_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/widgets/lot_detail_component.dart';

import '../../bloc/blocs/issue_bloc/list_lot_issue_uncompleted_bloc.dart';
import '../../bloc/states/issue_state/list_lot_issue_state.dart';

class ListLotIssueScreen extends StatefulWidget {
  const ListLotIssueScreen({super.key});

  @override
  State<ListLotIssueScreen> createState() => _ListLotIssueScreenState();
}

class _ListLotIssueScreenState extends State<ListLotIssueScreen> {
  String note = '';
  double quantity = 0;
  int tabIndex = 0;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return DefaultTabController(
      length: 2,
      initialIndex: tabIndex,
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.west, //mũi tên back
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/list_goods_issue_screen');
              },
            ),
            bottom: TabBar(
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), // Creates border
                  color: Constants.secondaryColor),
              indicatorColor: Colors.black,
              tabs: const [
                Tab(
                  //icon: Icon(Icons.flight),
                  text: 'DS đề xuất',
                ),
                Tab(
                  // icon: Icon(Icons.directions_transit),
                  text: 'DS dự kiến',
                ),
              ],
            ),
            backgroundColor: Constants.mainColor,
            title: Text(
              'Danh sách hàng hóa',
              style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
            ),
          ),
          body: TabBarView(children: [
            BlocConsumer<ListGoodsIssueLotUncompletedBloc, GoodsIssueLotState>(
                listener: (context, state) {
              
            }, builder: (context, state) {
              if (state is LoadGoodsIssueLotsSuccessState) {
                return SingleChildScrollView(
                  child: ExpansionPanelList.radio(
                    children: state.lotsSuggest
                        .map((e) => ExpansionPanelRadio(
                            canTapOnHeader: true,
                            value: e.lotId.toString(),
                            headerBuilder: ((context, isExpanded) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(width: 2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  leading: const Icon(Icons.list),
                                  isThreeLine: true,
                                  title: Text("Mã lô : ${e.lotId}"),
                                  subtitle: Text(
                                      "Sản phẩm : ${e.item.itemId.toString()} \nVị trí : ${e.location.toString()} \nSố lượng : ${e.quantity.toString()} \nSố PO : ${e.purchaseOrderNumber.toString()}"),
                                  onTap: () {},
                                ),
                              );
                              // LotDetailComponent(
                              //     itemId: e.lotId,
                              //     location: '',
                              //     enableEdit: false,
                              //     lotid: e.lotId,
                              //     numberPO: '264836',
                              //     unit: 'cái',
                              //     quantity: e.quantity,
                              //     sublotSize: 10,
                              //     onPressed: () {});
                            }),
                            body: Column(
                              children: [
                                Container(
                                  width: 300 * SizeConfig.ratioWidth,
                                  height: 60 * SizeConfig.ratioHeight,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 5 * SizeConfig.ratioHeight),
                                  child: TextField(
                                    decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: Constants.buttonColor,
                                        labelText: "Ghi chú"),
                                    onChanged: (value) => note = value,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5 * SizeConfig.ratioHeight),
                                  alignment: Alignment.centerRight,
                                  width: 300 * SizeConfig.ratioWidth,
                                  height: 55 * SizeConfig.ratioHeight,
                                  //color: Colors.grey[200],
                                  child: TextField(
                                    decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: Constants.buttonColor,
                                        labelText:
                                            "Nhập số lượng định cần xuất"),
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[0-9.,]')),
                                    ],
                                    onChanged: (value) =>
                                        quantity = double.parse(value),
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {
                                      BlocProvider.of<
                                                  ListGoodsIssueLotUncompletedBloc>(
                                              context)
                                          .add(AddGoodsIssueLotEvent(
                                              DateTime.now(),
                                              GoodsIssueLot(e.lotId, quantity,
                                                  e.sublotSize, '', note),
                                              state.lotsSuggest,
                                              state.lotsExpected));
                                      DefaultTabController.of(context)
                                          .animateTo(1);
                                    },
                                    child: const Text('Xác nhận'))
                              ],
                            )))
                        .toList(),
                  ),
                );
                // ListView.builder(
                //     itemCount: state.lotsSuggest.length,
                //     itemBuilder: (BuildContext context, int index) {
                //       return LotDetailComponent(
                //           itemId: state.lotsSuggest[index].item.itemId,
                //           location: '',
                //           enableEdit: false,
                //           lotid: '220123_NCC',
                //           numberPO: '264836',
                //           unit: 'cái',
                //           quantity: 100,
                //           sublotSize: 10,
                //           onPressed: () {
                //             BlocProvider.of<ListGoodsIssueLotUncompletedBloc>(
                //                     context)
                //                 .add(AddGoodsIssueLotEvent(
                //                     DateTime.now(),
                //                     state.lotsSuggest[index],
                //                     state.lotsSuggest,
                //                     state.lotsExpected));
                //           });
                //     });
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
            BlocConsumer<ListGoodsIssueLotUncompletedBloc, GoodsIssueLotState>(
                listener: (context, state) {
          
            }, builder: (context, state) {
              if (state is LoadGoodsIssueLotsSuccessState) {
                return ListView.builder(
                    itemCount: state.lotsExpected.length,
                    itemBuilder: (BuildContext context, int index) {
                      return LotDetailComponent(
                          itemId: state.lotsExpected[index].goodsIssueLotId
                              .toString(),
                          location: '',
                          enableEdit: false,
                          lotid: '220123_NCC',
                          numberPO: '264836',
                          unit: 'cái',
                          quantity: state.lotsExpected[index].quantity,
                          sublotSize: 10,
                          onPressed: () {});
                    });
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
          ])),
    );
  }
}