import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/receipt_bloc/completed_receipt_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/receipt_bloc/completed_receipt_lot_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/other/receipt_event/completed_receipt_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/other/receipt_event/completed_receipt_lot_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/other/receipt_state/completed_receipt_state.dart';
import 'package:mobile_warehouse_thaiduong/presentation/widgets/button_widget.dart';
import 'package:mobile_warehouse_thaiduong/presentation/widgets/customized_date_picker.dart';
import '../../../../function.dart';
import '../../../widgets/exception_widget.dart';
// danh sách các phiếu đã nhập
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
        .parse(DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(const Duration(days: 30))));
    DateTime endDate = DateFormat('yyyy-MM-dd')
        .parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    return WillPopScope(
       onWillPop: () async {
        Navigator.pushNamed(context, "/main_receipt_screen");
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
                    width: 175 * SizeConfig.ratioWidth,
                    height: 80 * SizeConfig.ratioHeight,
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
                    width: 175 * SizeConfig.ratioWidth,
                    height: 80 * SizeConfig.ratioHeight,
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
              Text(
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                "Danh sách các phiếu nhập \n đã hoàn thành",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 25 * SizeConfig.ratioFont,
                  color: Colors.black,
                ),
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
                    return SizedBox(
                      height: 360 * SizeConfig.ratioHeight,
                      child: ListView.builder(
                          itemCount: state.receipts.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  // shape: RoundedRectangleBorder(
                                  //   side: BorderSide(width: 1),
                                  //   borderRadius: BorderRadius.circular(10),
                                  // ),
                                  leading: const Icon(Icons.list),
                                  trailing: Icon(Icons.arrow_drop_down_sharp,
                                      size: 15 * SizeConfig.ratioFont),
                                  title: Text(
                                      "${state.receipts[index].goodsReceiptId}"),
                                  subtitle: Text(
                                      "NCC : ${state.receipts[index].supply.toString()}  \nNgày tạo : ${DateFormat('yyyy-MM-dd').parse(state.receipts[index].timestamp.toString())}"),
                                  onTap: () {
                                    BlocProvider.of<CompletedReceiptLotBloc>(
                                            context)
                                        .add(LoadReceiptLotCompletedEvent(
                                            DateTime.now(),
                                            state.receipts[index]));
                                    Navigator.pushNamed(
                                        context, '/imported_receipt_lot_screen');
                                  },
                                ),
                              ),
                            );
                          }),
                    );
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
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          ExceptionErrorState(
                            title: state.detail,
                            message: "Chọn lại khoảng thời gian phù hợp",
                          ),
                          CustomizedButton(
                              text: "Trở lại",
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/main_receipt_screen');
                              })
                        ],
                      ),
                    );
                  } else {
                    return SingleChildScrollView(
                        child: Column(
                      //   mainAxisAlignment: MainAxisAlignment.,
                      children: [
                        SizedBox(
                          height: 150 * SizeConfig.ratioHeight,
                        ),
                        const CircularProgressIndicator(),
                        SizedBox(
                          height: 150 * SizeConfig.ratioHeight,
                        ),
                        // CustomizedButton(
                        //     text: "Trở lại",
                        //     onPressed: () {
                        //       Navigator.pushNamed(
                        //           context, '/main_receipt_screen');
                        //     })
                      ],
                    ));
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
      ),
    );
  }
}
