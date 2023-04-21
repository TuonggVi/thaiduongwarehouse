// ignore_for_file: deprecated_member_use, sized_box_for_whitespace, unused_import

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/goods_issue.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/issue_bloc/create_new_issue_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/issue_bloc/fill_info_issue_enry_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/issue_event/create_new_issue_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/issue_state/fill_info_lot_issue_state.dart';
import '../../../domain/entities/item.dart';

class FillInfoEntryIssueScreen extends StatefulWidget {
  const FillInfoEntryIssueScreen({super.key});

  @override
  State<FillInfoEntryIssueScreen> createState() =>
      _FillInfoEntryIssueScreenState();
}

class _FillInfoEntryIssueScreenState extends State<FillInfoEntryIssueScreen> {
  List<Item> itemsDropdownData = [];
  Item? selectedItem;
  IssueEntryView issueEntryView = IssueEntryView('', 0, 0, '');
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.west, //mũi tên back
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/create_issue_screen');
          },
        ),
        backgroundColor: Constants.mainColor,
        title: Text(
          'Nhập kho',
          style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
        ),
      ),
      // body: BlocConsumer<FillInfoIssueEntryBloc, FillInfoIssueEntryState>(
      //   listener: (context, state) {
          
      //   },
      //   builder: (context, state) {
      //     if (state is LoadItemDataSuccessState) {
      //       if (state.index != -1) {
      //         issueEntryView = state.entries[state.index];
      //       }
      //       return SingleChildScrollView(
      //         child: Container(
      //           alignment: Alignment.center,
      //           padding: EdgeInsets.all(10 * SizeConfig.ratioHeight),
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             children: [
      //               Text(
      //                 overflow: TextOverflow.ellipsis,
      //                 "Thông tin hàng hóa cần xuất",
      //                 style: TextStyle(
      //                   fontWeight: FontWeight.w600,
      //                   fontSize: 20 * SizeConfig.ratioFont,
      //                   color: Colors.black,
      //                 ),
      //               ),
      //               SizedBox(
      //                 height: 10 * SizeConfig.ratioHeight,
      //               ),
      //               Container(
      //                   height: 500 * SizeConfig.ratioHeight,
      //                   child: Column(
      //                     children: [
      //                       SizedBox(
      //                         width: 350 * SizeConfig.ratioWidth,
      //                         height: 60 * SizeConfig.ratioHeight,
      //                         child: DropdownSearch<String>(
      //                             mode: Mode.MENU,
      //                             items:
      //                                 state.items.map((e) => e.itemId).toList(),
      //                             showSearchBox: true,
      //                             label: "Mã sản phẩm",
      //                             // hint: "country in menu mode",
      //                             onChanged: (value) {
      //                               //  print(value);
      //                               setState(() {
      //                                 selectedItem = state.items.firstWhere(
      //                                     (element) => element.itemId == value);
      //                                 issueEntryView.itemName = value;
      //                               });
      //                             },
      //                             selectedItem: selectedItem == null
      //                                 ? ''
      //                                 : selectedItem!.itemId),
      //                       ),
      //                       SizedBox(
      //                         width: 350 * SizeConfig.ratioWidth,
      //                         height: 60 * SizeConfig.ratioHeight,
      //                         child: DropdownSearch<String>(
      //                             mode: Mode.MENU,
      //                             items: state.items
      //                                 .map((e) => e.itemName)
      //                                 .toList(),
      //                             showSearchBox: true,
      //                             label: "Tên sản phẩm",
      //                             // hint: "country in menu mode",
      //                             onChanged: (value) {
      //                               //  print(value);
      //                               setState(() {
      //                                 selectedItem = state.items.firstWhere(
      //                                     (element) =>
      //                                         element.itemName == value);
      //                                 issueEntryView.itemName =
      //                                     selectedItem!.itemName;
      //                               });
      //                             },
      //                             selectedItem: issueEntryView.itemName),
      //                       ),
      //                       SizedBox(
      //                         width: 350 * SizeConfig.ratioWidth,
      //                         height: 60 * SizeConfig.ratioHeight,
      //                         child: DropdownSearch<String>(
      //                           mode: Mode.MENU,
      //                           items: state.items
      //                               .map((e) => e.unit!.name.toString())
      //                               .toList(),
      //                           showSearchBox: true,
      //                           label: "Đơn vị",
      //                           // hint: "country in menu mode",
      //                           onChanged: (value) {
      //                             //  print(value);
      //                             setState(() {
      //                               issueEntryView.unit = value;

      //                               //  unit = value.toString();
      //                             });
      //                           },
      //                           selectedItem: selectedItem == null
      //                               ? ''
      //                               : selectedItem!.unit!.name,
      //                         ),
      //                       ),
      //                       Row(
      //                         mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                         children: [
      //                           Container(
      //                             padding: EdgeInsets.symmetric(
      //                                 vertical: 5 * SizeConfig.ratioHeight),
      //                             alignment: Alignment.centerRight,
      //                             width: 160 * SizeConfig.ratioWidth,
      //                             height: 55 * SizeConfig.ratioHeight,
      //                             //color: Colors.grey[200],
      //                             child: TextField(
      //                               controller: state.index == -1
      //                                   ? TextEditingController()
      //                                   : TextEditingController(
      //                                       text: issueEntryView
      //                                           .requestSublotSize
      //                                           .toString()),
      //                               decoration: InputDecoration(
      //                                   border: OutlineInputBorder(
      //                                       borderRadius:
      //                                           BorderRadius.circular(5)),
      //                                   // filled: true,
      //                                   // fillColor: Constants.buttonColor,
      //                                   labelText: "Nhập số lượng định mức"),
      //                               keyboardType:
      //                                   const TextInputType.numberWithOptions(
      //                                       decimal: true),
      //                               inputFormatters: [
      //                                 FilteringTextInputFormatter.allow(
      //                                     RegExp('[0-9.,]')),
      //                               ],
      //                               onChanged: (value) =>
      //                                   issueEntryView.requestSublotSize =
      //                                       double.parse(value),
      //                             ),
      //                           ),
      //                           Container(
      //                             padding: EdgeInsets.symmetric(
      //                                 vertical: 5 * SizeConfig.ratioHeight),
      //                             alignment: Alignment.centerRight,
      //                             width: 160 * SizeConfig.ratioWidth,
      //                             height: 55 * SizeConfig.ratioHeight,
      //                             //color: Colors.grey[200],
      //                             child: TextField(
      //                               controller: state.index == -1
      //                                   ? TextEditingController()
      //                                   : TextEditingController(
      //                                       text: issueEntryView.requestQuantity
      //                                           .toString()),
      //                               decoration: InputDecoration(
      //                                   border: OutlineInputBorder(
      //                                       borderRadius:
      //                                           BorderRadius.circular(5)),
      //                                   // filled: true,
      //                                   // fillColor: Constants.buttonColor,
      //                                   labelText: "Nhập tổng lượng"),
      //                               keyboardType:
      //                                   const TextInputType.numberWithOptions(
      //                                       decimal: true),
      //                               inputFormatters: [
      //                                 FilteringTextInputFormatter.allow(
      //                                     RegExp('[0-9.,]')),
      //                               ],
      //                               onChanged: (value) => issueEntryView
      //                                   .requestQuantity = double.parse(value),
      //                             ),
      //                           )
      //                         ],
      //                       ),
      //                     ],
      //                   )),
      //               state.index == -1
      //                   ? ElevatedButton(
      //                       onPressed: () async {
      //                         BlocProvider.of<CreateIssueBloc>(context).add(
      //                             AddIssueEntryEvent(issueEntryView,
      //                                 state.entries, DateTime.now()));
      //                         Navigator.pushNamed(
      //                             context, '/create_issue_screen');
      //                         //Navigator.of(context).pop();
      //                       },
      //                       child: const Text('Tạo mới'),
      //                     )
      //                   : ElevatedButton(
      //                       onPressed: () async {
      //                         BlocProvider.of<CreateIssueBloc>(context).add(
      //                             UpdateIssueEntryEvent(
      //                                 issueEntryView,
      //                                 state.entries,
      //                                 state.index,
      //                                 DateTime.now()));
      //                         Navigator.pushNamed(
      //                             context, '/create_issue_screen');
      //                         //Navigator.of(context).pop();
      //                       },
      //                       child: const Text('Cập nhật'),
      //                     )
      //             ],
      //           ),
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