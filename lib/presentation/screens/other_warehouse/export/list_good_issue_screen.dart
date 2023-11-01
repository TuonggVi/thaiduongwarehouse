import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/goods_issue.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/issue_bloc/list_lot_issue_uncompleted_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/other/issue_event/list_goods_issue_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/other/issue_state/list_goods_issue_state.dart';
import '../../../../function.dart';
import '../../../bloc/blocs/other/issue_bloc/list_goods_issue_uncompleted_bloc.dart';
import '../../../bloc/events/other/issue_event/list_lot_issue_event.dart';
import '../../../dialog/dialog_one_button.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/exception_widget.dart';

// danh sách phiếu cần xuất
class ListGoodIssueScreen extends StatefulWidget {
  const ListGoodIssueScreen({super.key});

  @override
  State<ListGoodIssueScreen> createState() => _ListGoodIssueScreenState();
}

class _ListGoodIssueScreenState extends State<ListGoodIssueScreen> {
  List<GoodsIssue> goodsIssue = [];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, '/export_main_screen');
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
              Navigator.pushNamed(context, '/export_main_screen');
            },
          ),
          backgroundColor: Constants.mainColor,
          title: Text(
            'Xuất kho',
            style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
          ),
        ),
        body: BlocConsumer<ListGoodsIssueUncompletedBloc, GoodsIssueState>(
          listener: (context, state) {
            if (state is PatchRequestQuantityFailState) {
              AlertDialogOneBtnCustomized(
                      context,
                      'Thất bại',
                      'Không thể hoàn thành việc cập nhật',
                      'Trở lại',
                      'Fail_image.png', () {
                Navigator.pushNamed(context, '/list_goods_issue_screen');
              }, 15, 20, () {}, false)
                  .show();
            }
            // if (state is PatchRequestQuantitySuccessState) {
            //   AlertDialogOneBtnCustomized(
            //           context,
            //           'Thành công',
            //           'Đã hoàn thành việc cập nhật',
            //           'Tiếp tục',
            //           'Success_image.png', () {
            //     BlocProvider.of<ListGoodsIssueUncompletedBloc>(context).add(
            //         LoadGoodsIssuesEvent(
            //             DateTime.now(),
            //   GoodsIssueLot('', null, '', null, '', []),

            //         ));
            //     Navigator.pushNamed(context, '/list_goods_issue_screen');
            //   }, 15, 20, () {}, false)
            //       .show();
            // }
          },
          builder: (context, state) {
            if (state is LoadGoodsIssuesSuccessState) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        "Danh sách các phiếu cần xuất",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 22 * SizeConfig.ratioFont,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: ExpansionPanelList.radio(
                        children:
                            state.listGoodsIssues.asMap().entries.map((entry) {
                          final int index1 = entry.key;
                          final GoodsIssue e = entry.value;

                          return ExpansionPanelRadio(
                            backgroundColor: Colors.grey[200],
                            canTapOnHeader: true,
                            value: e.goodsIssueId.toString(),
                            headerBuilder: (context, isExpanded) {
                              return ListTile(
                                //leading: const Icon(Icons.list),
                                // trailing: Icon(
                                //     Icons.arrow_drop_down_sharp,
                                //     size: 15 * SizeConfig.ratioFont),
                                //      tileColor: Colors.grey[200],

                                isThreeLine: true,
                                title: Text("Số phiếu : ${e.goodsIssueId}"),
                                subtitle: Text(
                                    "Người nhận : ${e.receiver.toString()} "),
                              );
                            },
                            body: Column(
                              children: [
                                SizedBox(
                                  height: e.entries!.length *
                                      120 *
                                      SizeConfig.ratioHeight,
                                  child: ListView.builder(
                                      itemCount: e.entries!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: ListTile(
                                              trailing: e.entries![index]
                                                          .requestQuantity! <=
                                                      e.entries![index]
                                                          .actualQuantity!
                                                  ? Column(
                                                      children: const [
                                                        Icon(
                                                          Icons.check,
                                                          color: Colors.green,
                                                        ),
                                                        Text(
                                                          'Đã xuất',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green),
                                                        )
                                                      ],
                                                    )
                                                  : const Icon(
                                                      Icons.post_add_outlined),
                                              isThreeLine: true,
                                              title: Text(
                                                  "Sản phẩm : ${e.entries![index].item!.itemName}"),
                                              subtitle: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          width: 120 *
                                                              SizeConfig
                                                                  .ratioWidth,
                                                          height: 45 *
                                                              SizeConfig
                                                                  .ratioHeight,
                                                          child: TextField(
                                                            controller:
                                                                // quantity,
                                                                TextEditingController(
                                                                    text: e.entries![index].requestQuantity ==
                                                                            null
                                                                        ? ''
                                                                        : e.entries![index]
                                                                            .requestQuantity
                                                                            .toString()),
                                                            onSubmitted: (value) => value !=
                                                                    ''
                                                                ? e
                                                                        .entries![
                                                                            index]
                                                                        .requestQuantity =
                                                                    double.parse(
                                                                        value)
                                                                : e
                                                                        .entries![
                                                                            index]
                                                                        .requestQuantity =
                                                                    double.parse(
                                                                        '0'),
                                                            decoration:
                                                                InputDecoration(
                                                                    border: OutlineInputBorder(
                                                                        borderRadius: BorderRadius.circular(
                                                                            5)),
                                                                    // filled: true,
                                                                    // fillColor: Constants.buttonColor,
                                                                    labelStyle: TextStyle(
                                                                        fontSize: 15 *
                                                                            SizeConfig
                                                                                .ratioFont),
                                                                    labelText:
                                                                        "Số lượng yêu cầu"),
                                                            keyboardType:
                                                                const TextInputType
                                                                        .numberWithOptions(
                                                                    decimal:
                                                                        true),
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter
                                                                  .allow(RegExp(
                                                                      '[0-9.,]')),
                                                            ],
                                                            onChanged: (value) => e
                                                                    .entries![index]
                                                                    .requestQuantity =
                                                                double.parse(
                                                                    value),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 120 *
                                                              SizeConfig
                                                                  .ratioWidth,
                                                          height: 45 *
                                                              SizeConfig
                                                                  .ratioHeight,
                                                          child: TextField(
                                                            controller:
                                                                // quantity,
                                                                TextEditingController(
                                                                    text: e.entries![index].actualQuantity ==
                                                                            null
                                                                        ? ''
                                                                        : e.entries![index]
                                                                            .actualQuantity
                                                                            .toString()),
                                                            onSubmitted: (value) => value !=
                                                                    ''
                                                                ? e
                                                                        .entries![
                                                                            index]
                                                                        .actualQuantity =
                                                                    double.parse(
                                                                        value)
                                                                : e
                                                                        .entries![
                                                                            index]
                                                                        .actualQuantity =
                                                                    double.parse(
                                                                        '0'),
                                                            decoration:
                                                                InputDecoration(
                                                                    border: OutlineInputBorder(
                                                                        borderRadius: BorderRadius.circular(
                                                                            5)),
                                                                    // filled: true,
                                                                    // fillColor: Constants.buttonColor,
                                                                    labelStyle: TextStyle(
                                                                        fontSize: 15 *
                                                                            SizeConfig
                                                                                .ratioFont),
                                                                    labelText:
                                                                        "Số lượng đã xuất"),
                                                            keyboardType:
                                                                const TextInputType
                                                                        .numberWithOptions(
                                                                    decimal:
                                                                        true),
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter
                                                                  .allow(RegExp(
                                                                      '[0-9.,]')),
                                                            ],
                                                            onChanged: (value) => e
                                                                    .entries![index]
                                                                    .actualQuantity =
                                                                double.parse(
                                                                    value),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                BlocProvider.of<
                                                            ListGoodsIssueLotUncompletedBloc>(
                                                        context)
                                                    .add(LoadGoodsIssueLotEvent(
                                                        DateTime.now(),
                                                        e.entries![index].item!
                                                            .itemId,
                                                        e.goodsIssueId
                                                            .toString(),
                                                        state.goodIssueLot));
                                                Navigator.pushNamed(context,
                                                    '/list_goods_issue_lot_screen');
                                              },
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    BlocProvider.of<
                                                ListGoodsIssueUncompletedBloc>(
                                            context)
                                        .add(PatchRequestQuantityEvent(
                                      DateTime.now(),
                                      index1,
                                      state.listGoodsIssues[index1],

                                      // state.listGoodsIssues,
                                      // goodsIssue[state.index],
                                    ));
                                    Navigator.pushNamed(
                                        context, '/list_goods_issue_screen');
                                  },
                                  child: const Text('Cập nhật'),
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            }
            if (state is LoadGoodsIssuesFailState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Center(
                        child: ExceptionErrorState(
                          title: state.detail,
                          message: "Vui lòng thử lại sau",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                      child: CustomizedButton(
                          text: "Trở lại",
                          onPressed: () {
                            // BlocProvider.of<FillInfoIssueEntryBloc>(context)
                            //     .add(GetAllItemIssueEvent(DateTime.now(), [], -1));
                            Navigator.pushNamed(
                              context,
                              '/export_main_screen',
                            );
                          }),
                    )
                  ],
                ),
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
