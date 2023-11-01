import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';

import '../../../bloc/blocs/other/issue_bloc/list_lot_issue_completed_bloc.dart';
import '../../../bloc/states/other/issue_state/list_completed_lots_issue_state.dart';
// danh sách các lô hàng đã xuất
class ListLotIssueCompletedScreen extends StatelessWidget {
  const ListLotIssueCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
        onWillPop: () async {
        Navigator.pushNamed(context,'/list_goods_issue_completed_screen');
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
              Navigator.pushNamed(
                  context, '/list_goods_issue_completed_screen');
            },
          ),
          backgroundColor: Constants.mainColor,
          title: Text(
            'Danh sách hàng hóa',
            style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
          ),
        ),
        body: BlocConsumer<ListGoodsIssueLotCompletedBloc,
            CompletedGoodsIssueLotState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LoadCompletedGoodsIssueLotSuccessState) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      "Danh sách các lô hàng đã xuất",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25 * SizeConfig.ratioFont,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Divider(
                    indent: 30,
                    endIndent: 30,
                    color: Constants.mainColor,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 500 * SizeConfig.ratioHeight,
                    child: ListView.builder(
                        itemCount: state.goodsIssue.entries!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  // leading: const Icon(Icons.list),
                                  // shape: RoundedRectangleBorder(
                                  //   side: BorderSide(width: 1),
                                  //   borderRadius: BorderRadius.circular(10),
                                  // ),
                                  // trailing: Icon(Icons.edit,
                                  //     size: 15 * SizeConfig.ratioFont),
                                  title: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "Sản phẩm : ${state.goodsIssue.entries![index].item!.itemName}"),
                                      Text(
                                          "Số lượng yêu cầu : ${state.goodsIssue.entries![index].requestQuantity}"),
                                    ],
                                  ),
                                  // subtitle: Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Text(
                                  //         "Số lượng yêu cầu : ${state.goodsIssue.entries![index].requestQuantity} \nĐịnh mức yêu cầu : ${state.goodsIssue.entries![index].requestSublotSize.toString()} "),
                                  //   ],
                                  // ),
                                  //   isThreeLine: true,
                                  onTap: () {},
                                ),
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  itemCount: state
                                      .goodsIssue.entries![index].lots!.length,
                                  itemBuilder: (BuildContext context, int int) {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: ListTile(
                                              // trailing: Icon(Icons.edit,
                                              //     size: 17 *
                                              //         SizeConfig.ratioFont),
                                              title: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 8.0, 0, 8.0),
                                                child: Text(
                                                  "Mã lô : ${state.goodsIssue.entries![index].lots![int].goodsIssueLotId}",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16 *
                                                        SizeConfig.ratioFont,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              subtitle: Column(
                                                // mainAxisAlignment:
                                                //     MainAxisAlignment
                                                //         .spaceBetween,
                                                children: [
                                                  Text(
                                                      "Số lượng : ${state.goodsIssue.entries![index].lots![int].quantity} "),
                                                 
                                                  Text(
                                                      "Ghi chú : ${state.goodsIssue.entries![index].lots![int].note}"),
                                                ],
                                              ),
                                              isThreeLine: true,
                                              onTap: () {},
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  }),
                            ],
                          );
                        }),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
