import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/other/issue_event/list_lot_issue_completed_event.dart';
import '../../../../function.dart';
import '../../../bloc/blocs/other/issue_bloc/list_goods_issue_completed_bloc.dart';
import '../../../bloc/blocs/other/issue_bloc/list_lot_issue_completed_bloc.dart';
import '../../../bloc/events/other/issue_event/list_goods_issue_completed_event.dart';
import '../../../bloc/states/other/issue_state/list_completed_goods_issue_state.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/customized_date_picker.dart';
import '../../../widgets/exception_widget.dart';
// danh sách các phiếu nhập đã hoàn thành
class ListGoodIssueCompletedScreen extends StatefulWidget {
  const ListGoodIssueCompletedScreen({super.key});

  @override
  State<ListGoodIssueCompletedScreen> createState() =>
      _ListGoodIssueCompletedScreenState();
}

class _ListGoodIssueCompletedScreenState
    extends State<ListGoodIssueCompletedScreen> {
  DateTime startDate = DateFormat('yyyy-MM-dd')
      .parse(DateTime.now().subtract(const Duration(days: 50)).toString());

  DateTime endDate = DateFormat('yyyy-MM-dd').parse(DateTime.now().toString());
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return WillPopScope(
        onWillPop: () async {
        Navigator.pushNamed(context,'/export_main_screen');
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
              BlocBuilder<ListGoodsIssueCompletedBloc, CompletedGoodsIssueState>(
                builder: (context, state) {
                  if (state is LoadCompletedGoodsIssueInitState) {
                    return ExceptionErrorState(
                      title: '',
                      message: "Chọn thời gian để truy xuất",
                    );
                  }
                  if (state is LoadCompletedGoodsIssuesSuccessState) {
                    return SizedBox(
                      height: 380 * SizeConfig.ratioHeight,
                      child: ListView.builder(
                          itemCount: state.goodsIssues.length,
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
                                  title: Text(state
                                      .goodsIssues[index].goodsIssueId
                                      .toString()),
                                  subtitle: Text(
                                      "Người nhận : ${state.goodsIssues[index].receiver.toString()}  \nNgày tạo : ${DateFormat('yyyy-MM-dd').parse(state.goodsIssues[index].timestamp.toString())}"),
                                  onTap: () {
                                    BlocProvider.of<
                                                ListGoodsIssueLotCompletedBloc>(
                                            context)
                                        .add(LoadGoodsIssueLotCompletedEvent(
                                            DateTime.now(),
                                            state.goodsIssues[index]));
                                    Navigator.pushNamed(context,
                                        '/list_goods_issue_lot_completed_screen');
                                  },
                                ),
                              ),
                            );
                          }),
                    );
                  }
                  if (state is LoadCompletedGoodsIssuesFailState) {
                    return ExceptionErrorState(
                      title: state.detail,
                      message: "Vui lòng quay lại sau",
                    );
                  } else {
                    return Dialog(
                      // The background color
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            // The loading indicator
                            CircularProgressIndicator(),
                            SizedBox(
                              height: 15,
                            ),
                            // Some text
                            Text('Loading...')
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
              CustomizedButton(
                  text: "Truy xuất",
                  onPressed: () {
                    BlocProvider.of<ListGoodsIssueCompletedBloc>(context).add(
                        LoadCompletedGoodsIssuesEvent(
                            DateTime.now(), startDate, endDate));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
