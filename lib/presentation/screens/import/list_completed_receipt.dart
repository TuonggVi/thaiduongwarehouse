import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/receipt_bloc/completed_receipt_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/receipt_bloc/completed_receipt_lot_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/receipt_event/completed_receipt_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/receipt_event/completed_receipt_lot_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/receipt_state/completed_receipt_state.dart';
import 'package:mobile_warehouse_thaiduong/presentation/widgets/button_widget.dart';
import 'package:mobile_warehouse_thaiduong/presentation/widgets/customized_date_picker.dart';
import '../../../function.dart';
import '../../widgets/exception_widget.dart';

class ListCompletedReceiptScreen extends StatefulWidget {
  const ListCompletedReceiptScreen({super.key});

  @override
  State<ListCompletedReceiptScreen> createState() =>
      _ListCompletedReceiptScreenState();
}

class _ListCompletedReceiptScreenState
    extends State<ListCompletedReceiptScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    DateTime startDate = DateFormat('yyyy-MM-dd')
        .parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    DateTime endDate = DateFormat('yyyy-MM-dd')
        .parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.west, //mũi tên back
              color: Colors.white,
            ),
            onPressed: () {
             Navigator.pushNamed(context, '/main_receipt_screen');
            },
          ),
        backgroundColor: Constants.mainColor,
        title: Text(
          'Danh sách phiếu đã nhập',
          style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: 5 * SizeConfig.ratioHeight),
                  width: 160 * SizeConfig.ratioWidth,
                  height: 60 * SizeConfig.ratioHeight,
                  child: CustomizeDatePicker(
                    name: "Từ ngày",
                    fontColor: Colors.black,
                    fontWeight: FontWeight.normal,
                    initDateTime: startDate,
                    okBtnClickedFunction: (pickedTime) {
                      startDate = pickedTime;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: 5 * SizeConfig.ratioHeight),
                  width: 160 * SizeConfig.ratioWidth,
                  height: 60 * SizeConfig.ratioHeight,
                  child: CustomizeDatePicker(
                    name: "Đến ngày",
                    fontColor: Colors.black,
                    fontWeight: FontWeight.normal,
                    initDateTime: endDate,
                    okBtnClickedFunction: (pickedTime) {
                      endDate = pickedTime;
                    },
                  ),
                ),
              ],
            ),
            const Divider(
              indent: 30,
              endIndent: 30,
              color: Constants.mainColor,
              thickness: 1,
            ),
            BlocBuilder<CompletedReceiptBloc, CompletedReceiptState>(
              builder: (context, state) {
                if (state is CompletedReceiptInitState) {
                  return ExceptionErrorState(
                    title: '',
                    message: "Chọn thời gian để truy xuất",
                  );
                }
                if (state is LoadReceiptCompletedStateSuccess) {
                  return ListView.builder(
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: const Icon(Icons.list),
                          trailing: Icon(Icons.arrow_drop_down_sharp,
                              size: 15 * SizeConfig.ratioFont),
                          title: Text(state.receipts[index].goodsReceiptId),
                          subtitle: Text(state.receipts[index].timestamp.toString()),
                          onTap: () {
                            BlocProvider.of<CompletedReceiptLotBloc>(context)
                                .add(LoadReceiptLotEvent(DateTime.now()));
                          },
                        );
                      });
                  // return SizedBox(
                  //     child: ExpansionPanelList(
                  //   animationDuration: Duration(seconds: 2),
                  //   dividerColor: Colors.black,
                  //   elevation: 1,
                  //   expansionCallback: (int index, bool isExpanded) {
                  //     setState(() {
                  //       showExpand = !isExpanded;
                  //     });
                  //   },
                  //   expandedHeaderPadding: EdgeInsets.all(10),
                  //   children: [
                  //     ExpansionPanel(
                  //       canTapOnHeader: true,
                  //       headerBuilder: (BuildContext context, bool isExpanded) {
                  //         return ListTile(
                  //           title: Text(''),
                  //         );
                  //       },
                  //       body: ListTile(
                  //           title: Text(''),
                  //           subtitle: const Text(
                  //               'To delete this panel, tap the trash can icon'),
                  //           trailing: const Icon(Icons.delete),
                  //           onTap: () {
                  //             setState(() {
                  //               //_data.removeWhere((Item currentItem) => item == currentItem);
                  //             });
                  //           }),
                  //       isExpanded: showExpand,
                  //     )
                  //   ],
                  // ));
                }
                if (state is LoadReceiptCompletedStateFail) {
                  return ExceptionErrorState(
                    title: state.detail,
                    message: "Vui lòng quay lại sau",
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            CustomizedButton(
                text: "Truy xuất",
                onPressed: () {
                  BlocProvider.of<CompletedReceiptBloc>(context).add(
                      LoadCompletedGoodsReceiptEvent(
                          DateTime.now(), startDate, endDate));
                })
          ],
        ),
      ),
    );
  }
}