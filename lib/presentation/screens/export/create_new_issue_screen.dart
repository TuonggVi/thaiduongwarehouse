// ignore_for_file: unused_import

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/issue_bloc/create_new_issue_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/issue_bloc/fill_info_issue_enry_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/issue_event/create_new_issue_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/issue_event/fill_info_issue_entry_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/issue_state/create_new_issue_state.dart';
import 'package:mobile_warehouse_thaiduong/presentation/widgets/button_widget.dart';
import 'package:mobile_warehouse_thaiduong/presentation/widgets/dropdown_search_button.dart';
import '../../dialog/dialog_one_button.dart';
import '../../widgets/exception_widget.dart';
import '../../widgets/text_input_widget.dart';

class CreateNewIssueScreen extends StatefulWidget {
  const CreateNewIssueScreen({super.key});

  @override
  State<CreateNewIssueScreen> createState() => _CreateNewIssueScreenState();
}

class _CreateNewIssueScreenState extends State<CreateNewIssueScreen> {
  TextEditingController controller = TextEditingController();
  // final issueId = TextEditingController();
  // final poNumber = TextEditingController();
  // String selectedDepartment = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
              resizeToAvoidBottomInset: false, 

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
      body: BlocConsumer<CreateIssueBloc, CreaNewIssueState>(
        listener: (context, state) {
          if (state is LoadListDataSuccessState) {
            //  AlertDialogOneBtnCustomized(
            //       context,
            //       "Thông báo",
            //       "Để hoàn hành vui lòng chọn tiếp tục để điền thông tin phiếu",
            //       "Tiếp tục",
            //       () {
            //          Navigator.pushNamed(
            //               context,
            //               '/fill_main_info_issue_screen',
            //             );
            //       },
            //       18,
            //       22,
            //       () {

            //       },false).show();
          }
        },
        builder: (context, state) {
          if (state is CreateNewIssueInitialState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          overflow: TextOverflow.ellipsis,
                          "Danh sách các lô hàng",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20 * SizeConfig.ratioFont,
                            color: Colors.black,
                          ),
                        ),
                        ExceptionErrorState(
                          title: "Phiếu đang rỗng",
                          message: "Chọn Tiếp tục để chọn hàng hóa cần xuất",
                        ),
                      ]),
                  CustomizedButton(
                      text: "Tiếp tục",
                      onPressed: () {
                        BlocProvider.of<FillInfoIssueEntryBloc>(context)
                            .add(GetAllItemIssueEvent(DateTime.now(), const [], -1));
                        Navigator.pushNamed(
                          context,
                          '/fill_info_entry_screen',
                        );
                      })
                ],
              ),
            );
          }
          if (state is UpdateEntryToGoodsIssueSuccess) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          "Danh sách các lô hàng",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 25 * SizeConfig.ratioFont,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 300 * SizeConfig.ratioHeight,
                        child: ListView.builder(
                            itemCount: state.issueEntries.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                leading: const Icon(Icons.list),
                                trailing: Icon(Icons.arrow_drop_down_sharp,
                                    size: 15 * SizeConfig.ratioFont),
                                isThreeLine: true,
                                title: Text(
                                    "Sản phẩm : ${state.issueEntries[index].itemName.toString()}"),
                                subtitle: Text(
                                    "Số lượng yêu cầu : ${state.issueEntries[index].requestQuantity.toString()} \nĐịnh mức yêu cầu : ${state.issueEntries[index].requestSublotSize.toString()} "),
                                onTap: () {
                                  BlocProvider.of<FillInfoIssueEntryBloc>(
                                          context)
                                      .add(GetAllItemIssueEvent(
                                          // issueId.text,
                                          // poNumber.text,
                                          // selectedDepartment,
                                          DateTime.now(),
                                          state.issueEntries,
                                          index));
                                  Navigator.pushNamed(
                                    context,
                                    '/fill_info_entry_screen',
                                  );
                                },
                              );
                            }),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CustomizedButton(
                          text: "Tiếp tục",
                          onPressed: () {
                            BlocProvider.of<FillInfoIssueEntryBloc>(context)
                                .add(GetAllItemIssueEvent(
                                    DateTime.now(), state.issueEntries, -1));
                            Navigator.pushNamed(
                              context,
                              '/fill_info_entry_screen',
                            );
                          }),
                      CustomizedButton(
                          text: "Hoàn thành",
                          onPressed: () {
                            BlocProvider.of<CreateIssueBloc>(context).add(
                                LoadListDataEvent(
                                    DateTime.now(), state.issueEntries));
                            AlertDialogOneBtnCustomized(
                                    context,
                                    "Thông báo",
                                    "Để hoàn hành vui lòng chọn tiếp tục để điền thông tin phiếu",
                                    "Tiếp tục", () {
                              Navigator.pushNamed(
                                context,
                                '/fill_main_info_issue_screen',
                              );
                            }, 18, 22, () {}, false)
                                .show();
                            // Navigator.pushNamed(
                            //   context,
                            //   '/fill_main_info_issue_screen',
                            // );
                          })
                    ],
                  ),
                ]);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
