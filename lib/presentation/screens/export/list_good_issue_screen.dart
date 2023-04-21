// ignore_for_file: unused_field, prefer_final_fields, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/goods_issue.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/issue_bloc/list_lot_issue_uncompleted_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/issue_state/list_goods_issue_state.dart';
import '../../../function.dart';
import '../../bloc/blocs/issue_bloc/list_goods_issue_uncompleted_bloc.dart';
import '../../bloc/events/issue_event/list_lot_issue_event.dart';

class ListGoodIssueScreen extends StatefulWidget {
  const ListGoodIssueScreen({super.key});

  @override
  State<ListGoodIssueScreen> createState() => _ListGoodIssueScreenState();
}

class _ListGoodIssueScreenState extends State<ListGoodIssueScreen> {
  int _index = 0;
  List<GoodsIssue> goodsIssue = [];
  // void _showModalSheet(int i, GoodsIssue issue) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (builder) {
  //         return BlocProvider.value(
  //           value: BlocProvider.of<ListGoodsIssueLotUncompletedBloc>(context),
  //           child: SizedBox(
  //             height: 470 * SizeConfig.ratioHeight,
  //             child: ListView.builder(
  //                 itemCount: issue.entries!.length,
  //                 itemBuilder: (BuildContext context, int index) {
  //                   return GestureDetector(
  //                     onTap: () {
  //                       Navigator.pushNamed(
  //                           context, '/list_goods_issue_lot_screen');
  //                            BlocProvider.of<ListGoodsIssueLotUncompletedBloc>(
  //                               context)
  //                           .add(LoadGoodsIssueLotSuggestEvent(DateTime.now(),
  //                               issue.entries![index].item!.itemId.toString()));
  //                     },
  //                     child: Padding(
  //                       padding: const EdgeInsets.all(10),
  //                       child: Container(
  //                         decoration: BoxDecoration(
  //                           boxShadow: [
  //                             BoxShadow(
  //                               color: Constants.buttonColor.withOpacity(0.5),
  //                               spreadRadius: 5,
  //                               blurRadius: 2,
  //                               offset:
  //                                   Offset(4, 8), // changes position of shadow
  //                             ),
  //                           ],
  //                         ),
  //                         width: 300 * SizeConfig.ratioWidth,
  //                         height: 80 * SizeConfig.ratioHeight,
  //                         // color: Constants.buttonColor,
  //                         child: Column(
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           //crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Text(
  //                               overflow: TextOverflow.ellipsis,
  //                               "Tên SP: ${issue.entries![index].item!.itemName.toString()}",
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.w600,
  //                                 fontSize: 28 * SizeConfig.ratioFont,
  //                                 color: Colors.black,
  //                               ),
  //                             ),
  //                             Text(
  //                               overflow: TextOverflow.ellipsis,
  //                               "SL yêu cầu",
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.w400,
  //                                 fontSize: 18 * SizeConfig.ratioFont,
  //                                 color: Colors.black,
  //                               ),
  //                             ),
  //                             Text(
  //                               overflow: TextOverflow.ellipsis,
  //                               "SL đã xuất",
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.w400,
  //                                 fontSize: 18 * SizeConfig.ratioFont,
  //                                 color: Colors.black,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   );
  //                 }),
  //           ),
  //         );
  //       });
  //}

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
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
          'Xuất kho',
          style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
        ),
      ),
      // body: BlocBuilder<ListGoodsIssueUncompletedBloc, GoodsIssueState>(
      //   builder: (context, state) {
      //     if (state is LoadGoodsIssuesSuccessState) {
      //       return SingleChildScrollView(
      //         scrollDirection: Axis.vertical,
      //         child: Column(
      //           children: [
      //             Padding(
      //               padding: const EdgeInsets.all(8.0),
      //               child: Text(
      //                 overflow: TextOverflow.ellipsis,
      //                 "Danh sách các phiếu hàng cần xuất",
      //                 style: TextStyle(
      //                   fontWeight: FontWeight.w600,
      //                   fontSize: 20 * SizeConfig.ratioFont,
      //                   color: Colors.black,
      //                 ),
      //               ),
      //             ),
      //             SingleChildScrollView(
      //               child: ExpansionPanelList.radio(
      //                 children: state.goodsIssues
      //                     .map((e) => ExpansionPanelRadio(
      //                           canTapOnHeader: true,
      //                           value: e.goodsIssueId.toString(),
      //                           headerBuilder: ((context, isExpanded) {
      //                             return ListTile(
      //                               //leading: const Icon(Icons.list),
      //                               // trailing: Icon(
      //                               //     Icons.arrow_drop_down_sharp,
      //                               //     size: 15 * SizeConfig.ratioFont),
      //                               isThreeLine: true,
      //                               title: Text("Số phiếu : ${e.goodsIssueId}"),
      //                               subtitle: Text(
      //                                   "Receiver : ${e.receiver.toString()} "),
      //                             );
      //                           }),
      //                           body: Column(
      //                             children: [
      //                               // Padding(
      //                               //   padding: const EdgeInsets.all(8.0),
      //                               //   child: Text(
      //                               //     overflow: TextOverflow.ellipsis,
      //                               //     "Danh sách các phiếu hàng cần xuất",
      //                               //     style: TextStyle(
      //                               //       fontWeight: FontWeight.w600,
      //                               //       fontSize: 20 * SizeConfig.ratioFont,
      //                               //       color: Colors.black,
      //                               //     ),
      //                               //   ),
      //                               // ),
      //                               SizedBox(
      //                                 height: e.entries!.length *
      //                                     100 *
      //                                     SizeConfig.ratioHeight,
      //                                 child: ListView.builder(
      //                                     itemCount: e.entries!.length,
      //                                     itemBuilder: (BuildContext context,
      //                                         int index) {
      //                                       return Padding(
      //                                         padding:
      //                                             const EdgeInsets.all(8.0),
      //                                         child: ListTile(
      //                                           shape: RoundedRectangleBorder(
      //                                             side: const BorderSide(width: 2),
      //                                             borderRadius:
      //                                                 BorderRadius.circular(20),
      //                                           ),
      //                                           leading: const Icon(Icons.list),
      //                                           isThreeLine: true,
      //                                           title: Text(
      //                                               "Sản phẩm : ${e.entries![index].item!.itemName}"),
      //                                           subtitle: Text(
      //                                               "Số lượng yêu cầu : ${e.entries![index].requestQuantity.toString()} \nĐịnh mức yêu cầu : ${e.entries![index].requestSublotSize.toString()} "),
      //                                           onTap: () {
      //                                             BlocProvider.of<
      //                                                         ListGoodsIssueLotUncompletedBloc>(
      //                                                     context)
      //                                                 .add(LoadGoodsIssueLotEvent(
      //                                                     DateTime.now(),
      //                                                     e.entries![index]
      //                                                         .item!.itemId,
      //                                                     e.entries![index].lots
      //                                                         as List<
      //                                                             GoodsIssueLot>));
      //                                             Navigator.pushNamed(context,
      //                                                 '/list_goods_issue_lot_screen');
      //                                           },
      //                                         ),
      //                                       );
      //                                       //   GestureDetector(
      //                                       //     onTap: () {
      //                                       //       // BlocProvider.of<ListGoodsIssueEntryBloc>(context)
      //                                       //       //     .add(LoadGoodsIssueEntryEvent(DateTime.now()));
      //                                       //       // Navigator.pushNamed(
      //                                       //       //     context, '/list_goods_issue_entry_screen');

      //                                       //       // bỏ qua trang issue entry
      //                                       //       setState(() {
      //                                       //         BlocProvider.of<
      //                                       //                     ListGoodsIssueLotUncompletedBloc>(
      //                                       //                 context)
      //                                       //             .add(LoadGoodsIssueLotEvent(
      //                                       //                 DateTime.now(),
      //                                       //                 e.entries![index].item!
      //                                       //                     .itemId,  e.entries![index].lots as List<GoodsIssueLot>));
      //                                       //         Navigator.pushNamed(context,
      //                                       //             '/list_goods_issue_lot_screen');
      //                                       //         //goodsIssue = state.goodsIssues;
      //                                       //       });
      //                                       //     },
      //                                       //     child: Padding(
      //                                       //       padding: const EdgeInsets.all(10),
      //                                       //       child: Container(
      //                                       //         decoration: BoxDecoration(
      //                                       //           boxShadow: [
      //                                       //             BoxShadow(
      //                                       //               color: Constants.buttonColor
      //                                       //                   .withOpacity(0.5),
      //                                       //               spreadRadius: 5,
      //                                       //               blurRadius: 2,
      //                                       //               offset: const Offset(4,
      //                                       //                   8), // changes position of shadow
      //                                       //             ),
      //                                       //           ],
      //                                       //         ),
      //                                       //         width:
      //                                       //             300 * SizeConfig.ratioWidth,
      //                                       //         height:
      //                                       //             80 * SizeConfig.ratioHeight,
      //                                       //         child: Column(
      //                                       //           mainAxisAlignment:
      //                                       //               MainAxisAlignment.center,
      //                                       //           //crossAxisAlignment: CrossAxisAlignment.start,
      //                                       //           children: [
      //                                       //             Text(
      //                                       //               overflow:
      //                                       //                   TextOverflow.ellipsis,
      //                                       //               "Số lượng : ${e.entries![index].requestQuantity}",
      //                                       //               style: TextStyle(
      //                                       //                 fontWeight:
      //                                       //                     FontWeight.w600,
      //                                       //                 fontSize: 28 *
      //                                       //                     SizeConfig.ratioFont,
      //                                       //                 color: Colors.black,
      //                                       //               ),
      //                                       //             ),
      //                                       //             Text(
      //                                       //               overflow:
      //                                       //                   TextOverflow.ellipsis,
      //                                       //               "Tên sp : ${e.entries![index].item!.itemName}",
      //                                       //               style: TextStyle(
      //                                       //                 fontWeight:
      //                                       //                     FontWeight.w400,
      //                                       //                 fontSize: 18 *
      //                                       //                     SizeConfig.ratioFont,
      //                                       //                 color: Colors.black,
      //                                       //               ),
      //                                       //             ),
      //                                       //           ],
      //                                       //         ),
      //                                       //       ),
      //                                       //     ),
      //                                       //   );
      //                                     }),
      //                               ),
      //                             ],
      //                           ),
      //                         ))
      //                     .toList(),
      //               ),
      //             ),
      //           ],
      //         ),
      //       );
      //     } else {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //   },
      // ),
    );
  }
}