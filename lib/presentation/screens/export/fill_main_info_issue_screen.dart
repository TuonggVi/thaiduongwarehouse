// ignore_for_file: unused_import, deprecated_member_use

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/issue_bloc/create_new_issue_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/issue_bloc/fill_info_issue_enry_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/issue_event/fill_info_issue_entry_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/issue_state/create_new_issue_state.dart';
import 'package:mobile_warehouse_thaiduong/presentation/widgets/button_widget.dart';
import '../../widgets/exception_widget.dart';

class FillMainInFoIssueScreen extends StatefulWidget {
  const FillMainInFoIssueScreen({super.key});

  @override
  State<FillMainInFoIssueScreen> createState() =>
      _FillMainInfoIssueScreenState();
}

class _FillMainInfoIssueScreenState extends State<FillMainInFoIssueScreen> {
  final issueId = TextEditingController();

  String selectedDepartment = '';
  String poNumber = '';

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
  
        },
        builder: (context, state) {
          if (state is LoadListDataSuccessState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Text(
                      //   overflow: TextOverflow.ellipsis,
                      //   "Mã NCC",
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.w600,
                      //     fontSize: 20 * SizeConfig.ratioFont,
                      //     color: Colors.black,
                      //   ),
                      // ),
                      // TextInputWidget(contentTextField: supplyId)
                      Container(
                        width: 350 * SizeConfig.ratioWidth,
                        height: 60 * SizeConfig.ratioHeight,
                        margin: EdgeInsets.symmetric(
                            vertical: 5 * SizeConfig.ratioHeight),
                        child: TextField(
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Constants.buttonColor,
                              labelText: "Số phiếu"),
                          controller: issueId,
                          onChanged: (value) => {},
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 350 * SizeConfig.ratioWidth,
                    height: 60 * SizeConfig.ratioHeight,
                    child: DropdownSearch<String>(
                        mode: Mode.MENU,
                        items: state.departments.map((e) => e.name).toList(),
                        showSearchBox: true,
                        label: "Khách hàng/ bộ phận",
                        // hint: "country in menu mode",
                        onChanged: (value) {
                          //  print(value);
                          setState(() {});
                        },
                        selectedItem: selectedDepartment),
                  ),
                  SizedBox(
                    width: 350 * SizeConfig.ratioWidth,
                    height: 60 * SizeConfig.ratioHeight,
                    child: DropdownSearch<String>(
                        mode: Mode.MENU,
                        items: state.listPo.map((e) => e).toList(),
                        showSearchBox: true,
                        label: "Số PO (đối với thành phẩm)",
                        // hint: "country in menu mode",
                        onChanged: (value) {
                          //  print(value);
                          setState(() {});
                        },
                        selectedItem: selectedDepartment),
                  ),
                 
                  CustomizedButton(
                      text: "Hoàn thành",
                      onPressed: () {
                        // BlocProvider.of<FillInfoIssueEntryBloc>(context).add(
                        //     GetAllItemIssueEvent(issueId.text, poNumber,
                        //         selectedDepartment, DateTime.now(), [], -1));
                        // Navigator.pushNamed(
                        //   context,
                        //   '/fill_info_entry_screen',
                        // );
                      })
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