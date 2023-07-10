import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/goods_issue.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/issue_bloc/create_new_issue_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/issue_bloc/fill_info_issue_enry_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/other/issue_event/create_new_issue_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/other/issue_state/fill_info_lot_issue_state.dart';
import '../../../dialog/dialog_one_button.dart';

// điền thông tin hàng hóa cần xuất goodsIssueEntry (yêu cầu)
class FillInfoEntryIssueScreen extends StatefulWidget {
  const FillInfoEntryIssueScreen({super.key});

  @override
  State<FillInfoEntryIssueScreen> createState() =>
      _FillInfoEntryIssueScreenState();
}

class _FillInfoEntryIssueScreenState extends State<FillInfoEntryIssueScreen> {
  // List<Item> itemsDropdownData = [];
  //Item? selectedItem;
  GoodsIssueEntry issueEntryView =
      GoodsIssueEntry(null, null, null, null, null);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, '/create_issue_screen');
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
        body: BlocConsumer<FillInfoIssueEntryBloc, FillInfoIssueEntryState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LoadItemDataSuccessState) {
              if (state.index != -1) {
                issueEntryView = state.goodsIssue!.entries![state.index];
              }
              return SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10 * SizeConfig.ratioHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        overflow: TextOverflow.ellipsis,
                        "Thông tin hàng hóa cần xuất",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20 * SizeConfig.ratioFont,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 10 * SizeConfig.ratioHeight,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 350 * SizeConfig.ratioWidth,
                              height: 60 * SizeConfig.ratioHeight,
                              child: DropdownSearch<String>(
                                  mode: Mode.MENU,
                                  items:
                                      state.items.map((e) => e.itemId).toList(),
                                  showSearchBox: true,
                                  label: "Mã PO",
                                  // hint: "country in menu mode",
                                  onChanged: (value) {
                                    //  print(value);
                                    setState(() {
                                      issueEntryView.item = state.items
                                          .firstWhere((element) =>
                                              element.itemId == value);
                                      // issueEntryView.item!.itemName =
                                      //     value.toString();
                                    });
                                  },
                                  selectedItem: issueEntryView.item == null
                                      ? ''
                                      : issueEntryView.item!.itemId),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 350 * SizeConfig.ratioWidth,
                              height: 60 * SizeConfig.ratioHeight,
                              child: DropdownSearch<String>(
                                  mode: Mode.MENU,
                                  items:
                                      state.items.map((e) => e.itemId).toList(),
                                  showSearchBox: true,
                                  label: "Mã hàng",
                                  // hint: "country in menu mode",
                                  onChanged: (value) {
                                    //  print(value);
                                    setState(() {
                                      issueEntryView.item = state.items
                                          .firstWhere((element) =>
                                              element.itemId == value);
                                      // issueEntryView.item!.itemName =
                                      //     value.toString();
                                    });
                                  },
                                  selectedItem: issueEntryView.item == null
                                      ? ''
                                      : issueEntryView.item!.itemId),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 350 * SizeConfig.ratioWidth,
                              height: 60 * SizeConfig.ratioHeight,
                              child: DropdownSearch<String>(
                                  mode: Mode.MENU,
                                  items: state.items
                                      .map((e) => e.itemName)
                                      .toList(),
                                  showSearchBox: true,
                                  label: "Tên hàng",
                                  // hint: "country in menu mode",
                                  onChanged: (value) {
                                    //  print(value);
                                    setState(() {
                                      issueEntryView.item = state.items
                                          .firstWhere((element) =>
                                              element.itemName == value);
                                      // issueEntryView.item!.itemName =
                                      //     issueEntryView.item!.itemName;
                                    });
                                  },
                                  selectedItem: issueEntryView.item == null
                                      ? ''
                                      : issueEntryView.item!.itemName),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 350 * SizeConfig.ratioWidth,
                              height: 60 * SizeConfig.ratioHeight,
                              child: DropdownSearch<String>(
                                mode: Mode.MENU,
                                items: state.items
                                    .map((e) => e.unit!.toString())
                                    .toList(),
                                showSearchBox: true,
                                label: "Đơn vị",
                                // hint: "country in menu mode",
                                onChanged: (value) {
                                  //  print(value);
                                  setState(() {
                                    issueEntryView.item!.unit = value;

                                    //  unit = value.toString();
                                  });
                                },
                                selectedItem: issueEntryView.item == null
                                    ? ''
                                    : issueEntryView.item!.unit,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5 * SizeConfig.ratioHeight),
                                alignment: Alignment.centerRight,
                                width: 160 * SizeConfig.ratioWidth,
                                height: 55 * SizeConfig.ratioHeight,
                                //color: Colors.grey[200],
                                child: TextField(
                                  controller: TextEditingController(
                                      text: issueEntryView.requestSublotSize ==
                                              null
                                          ? ''
                                          : issueEntryView.requestSublotSize
                                              .toString()),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      // filled: true,
                                      // fillColor: Constants.buttonColor,
                                      labelText: "Định mức"),
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[0-9.,]')),
                                  ],
                                  onSubmitted: (value) => value != ''
                                      ? issueEntryView.requestSublotSize =
                                          double.parse(value)
                                      : issueEntryView.requestSublotSize =
                                          double.parse('0'),
                                  onChanged: (value) => value != ''
                                      ? issueEntryView.requestSublotSize =
                                          double.parse(value)
                                      : issueEntryView.requestSublotSize =
                                          double.parse('0'),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5 * SizeConfig.ratioHeight),
                                alignment: Alignment.centerRight,
                                width: 160 * SizeConfig.ratioWidth,
                                height: 55 * SizeConfig.ratioHeight,
                                //color: Colors.grey[200],
                                child: TextField(
                                  // controller: state.index == -1
                                  //     ? TextEditingController()
                                  //     : TextEditingController(
                                  //         text: issueEntryView.requestQuantity
                                  //             .toString()),
                                  controller: TextEditingController(
                                      text:
                                          issueEntryView.requestQuantity == null
                                              ? ''
                                              : issueEntryView.requestQuantity
                                                  .toString()),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      // filled: true,
                                      // fillColor: Constants.buttonColor,
                                      labelText: "Tổng lượng"),
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[0-9.,]')),
                                  ],
                                  onSubmitted: (value) => value != ''
                                      ? issueEntryView.requestQuantity =
                                          double.parse(value)
                                      : issueEntryView.requestQuantity =
                                          double.parse('0'),
                                  onChanged: (value) => value != ''
                                      ? issueEntryView.requestQuantity =
                                          double.parse(value)
                                      : issueEntryView.requestQuantity =
                                          double.parse('0'),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (issueEntryView.item == null ||
                              issueEntryView.requestQuantity == null) {
                            AlertDialogOneBtnCustomized(
                                    context,
                                    "Cảnh báo",
                                    "Vui lòng điền đầy đủ các thông tin trong phần bắt buộc",
                                    "Trở lại",
                                    'warning_image.png', () {
                              // Navigator.pushNamed(
                              //   context,
                              //   '/fill_main_info_issue_screen',
                              // );
                            }, 18, 22, () {}, false)
                                .show();
                          } else {
                            state.index == -1
                                ? {
                                    BlocProvider.of<CreateIssueBloc>(context)
                                        .add(AddIssueEntryEvent(
                                            issueEntryView,
                                            state.goodsIssue as GoodsIssue,
                                            DateTime.now())),
                                    Navigator.pushNamed(
                                        context, '/create_issue_screen')
                                  }
                                : {
                                    BlocProvider.of<CreateIssueBloc>(context)
                                        .add(UpdateIssueEntryEvent(
                                            issueEntryView,
                                            state.goodsIssue as GoodsIssue,
                                            state.index,
                                            DateTime.now())),
                                    Navigator.pushNamed(
                                        context, '/create_issue_screen'),
                                  };
                          }
                        },
                        child: state.index == -1
                            ? const Text('Tạo mới')
                            : const Text('Cập nhật'),
                      )
                    ],
                  ),
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
