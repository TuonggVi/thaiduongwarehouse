// ignore_for_file: avoid_print, prefer_const_constructors, deprecated_member_use

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import 'package:mobile_warehouse_thaiduong/presentation/dialog/dialog_two_button.dart';

import '../../../constant.dart';
import '../../../domain/entities/item.dart';
import '../../bloc/blocs/isolation_bloc.dart';
import '../../bloc/events/isolation_events.dart';
import '../../bloc/states/isolation_states.dart';
import '../../widgets/button_widget.dart';

class IsolationItemScreen extends StatefulWidget {
  const IsolationItemScreen({super.key});

  @override
  State<IsolationItemScreen> createState() => _IsolationItemScreenState();
}

class _IsolationItemScreenState extends State<IsolationItemScreen> {
  List<Item> itemsDropdownData = [];
  Item? selectedItem;
  String itemId = '';
 // List<Item> listItem = [];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.mainColor,
          leading: IconButton(
            icon: const Icon(Icons.west_outlined),
            onPressed: () {
              Navigator.pushNamed(context, '/isolation_function_screen');
            },
          ),
          title: Text(
            'Cách ly',
            style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
          ),
        ),
        body: BlocConsumer<IsolationBloc, IsolationState>(
            listener: (context, state) {},
            builder: (context, state) {
              // if (state is GetAllItemSuccessState) {
              return Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10 * SizeConfig.ratioHeight),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 340 * SizeConfig.ratioWidth,
                        height: 60 * SizeConfig.ratioHeight,
                        child: DropdownSearch<dynamic>(
                          mode: Mode.MENU,
                          items: state is GetAllItemSuccessState
                              ? state.item.map((e) => e.itemId).toList()
                              : [],

                          showSearchBox: true,
                          label: "Mã sản phẩm",
                          // hint: "country in menu mode",
                          onChanged: (value) {
                            //  print(value);
                            setState(() {
                              state is GetAllItemSuccessState
                                  ? setState(() {
                                      selectedItem = state.item.firstWhere(
                                          (element) => element.itemId == value);
                                      BlocProvider.of<IsolationBloc>(context)
                                          .add(GetLotByItemIdEvent(
                                              DateTime.now(),
                                              selectedItem!.itemId,
 //                                             state.item
                                              ));
                                    })
                                  : {};
                            });
                          },
                          selectedItem:
                              selectedItem == null ? '' : selectedItem!.itemId,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 340 * SizeConfig.ratioWidth,
                      height: 60 * SizeConfig.ratioHeight,
                      child: DropdownSearch<String>(
                        mode: Mode.MENU,
                        items: state is GetAllItemSuccessState
                            ? state.item.map((e) => e.itemId).toList()
                            : [],
                        //  state.item.map((e) => e.itemName.toString()).toList(),
                        showSearchBox: true,
                        label: "Tên sản phẩm",
                        // hint: "country in menu mode",
                        onChanged: (value) {
                          //  print(value);
                          setState(() {
                            state is GetAllItemSuccessState
                                ? setState(() {
                                    selectedItem = state.item.firstWhere(
                                        (element) => element.itemName == value);
                                    BlocProvider.of<IsolationBloc>(context).add(
                                        GetLotByItemIdEvent(DateTime.now(),
                                            selectedItem!.itemId,
//                                             state.item
                                             ));
                                  })
                                : {};
                          });
                        },
                        selectedItem:
                            selectedItem == null ? '' : selectedItem!.itemName,
                      ),
                    ),
                    CustomizedButton(
                        text: "Truy xuất",
                        onPressed: () {
                          BlocProvider.of<IsolationBloc>(context).add(
                              GetLotByItemIdEvent(DateTime.now(),
                                  selectedItem!.itemId, 
                                 // listItem
                                  ));
                        }),
                    const Divider(
                      indent: 30,
                      endIndent: 30,
                      color: Constants.mainColor,
                      thickness: 1,
                    ),
                    BlocConsumer<IsolationBloc, IsolationState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is GetLotByItemIdSuccessState) {
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Container(
                                //     alignment: Alignment.center,
                                //     padding: EdgeInsets.all(
                                //         10 * SizeConfig.ratioHeight),
                                //     child: Column(children: [
                                      // Padding(
                                      //   padding: const EdgeInsets.all(8.0),
                                      //   child: SizedBox(
                                      //     width: 340 * SizeConfig.ratioWidth,
                                      //     height: 60 * SizeConfig.ratioHeight,
                                      //     child: DropdownSearch<String>(
                                      //       mode: Mode.MENU,
                                      //       items: state.listItem
                                      //           .map((e) => e.itemId.toString())
                                      //           .toList(),
                                      //       showSearchBox: true,
                                      //       label: "Mã sản phẩm",
                                      //       // hint: "country in menu mode",
                                      //       onChanged: (value) {
                                      //       //  print(value);
                                      //         setState(() {
                                      //           selectedItem = state.listItem
                                      //               .firstWhere((element) =>
                                      //                   element.itemId ==
                                      //                   value);
                                      //         });
                                      //       },
                                      //       selectedItem: selectedItem == null
                                      //           ? ''
                                      //           : selectedItem!.itemId,
                                      //     ),
                                      //   ),
                                      // ),
                                    //   SizedBox(
                                    //     width: 340 * SizeConfig.ratioWidth,
                                    //     height: 60 * SizeConfig.ratioHeight,
                                    //     child: DropdownSearch<String>(
                                    //       mode: Mode.MENU,
                                    //       items: state.listItem
                                    //           .map((e) => e.itemName.toString())
                                    //           .toList(),
                                    //       showSearchBox: true,
                                    //       label: "Tên sản phẩm",
                                    //       // hint: "country in menu mode",
                                    //       onChanged: (value) {
                                    //         //  print(value);
                                    //         setState(() {
                                    //           selectedItem = state.listItem
                                    //               .firstWhere((element) =>
                                    //                   element.itemName ==
                                    //                   value);
                                    //         });
                                    //       },
                                    //       selectedItem: selectedItem == null
                                    //           ? ''
                                    //           : selectedItem!.itemName,
                                    //     ),
                                    //   ),
                                    //   CustomizedButton(
                                    //       text: "Truy xuất",
                                    //       onPressed: () {
                                    //         BlocProvider.of<IsolationBloc>(
                                    //                 context)
                                    //             .add(GetLotByItemIdEvent(
                                    //                 DateTime.now(),
                                    //                 selectedItem!.itemId
                                    //                     .toString(),
                                    //                 state.listItem));
                                    //       }),
                                    //   const Divider(
                                    //     indent: 30,
                                    //     endIndent: 30,
                                    //     color: Constants.mainColor,
                                    //     thickness: 1,
                                  //   //   ),
                                  //   ]
                                  //  )
                                  // ),
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  "Danh sách các lô hàng",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20 * SizeConfig.ratioFont,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                    height: 360 * SizeConfig.ratioHeight,
                                    child: ListView.builder(
                                        itemCount: state.itemLots.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: 100.0 *
                                                    SizeConfig.ratioHeight,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: ListTile(
                                                    leading:
                                                        const Icon(Icons.list),
                                                    trailing: Icon(
                                                        Icons
                                                            .arrow_drop_down_sharp,
                                                        size: 15 *
                                                            SizeConfig
                                                                .ratioFont),
                                                    title: Text(
                                                        "Mã lô : ${state.itemLots[index].lotId}"),
                                                    subtitle: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                            "Sản phẩm : ${state.itemLots[index].item.itemId.toString()}  \nSố lượng : ${state.itemLots[index].quantity.toString()} \nVị trí : ${state.itemLots[index].location.toString()}"),
                                                        Text(
                                                            "Số PO : ${state.itemLots[index].purchaseOrderNumber.toString()} \nĐịnh mức : ${state.itemLots[index].sublotSize.toString()}"),
                                                      ],
                                                    ),
                                                    isThreeLine: true,
                                                    onTap: () {
                                                      AlertDialogTwoBtnCustomized(
                                                              context,
                                                              'Xác nhận',
                                                              'Bạn có chắc lô này sẽ được cách ly',
                                                              'Xác nhận',
                                                              'Hủy', () {
                                                        BlocProvider.of<
                                                                    IsolationBloc>(
                                                                context)
                                                            .add(
                                                                PostNewIsolationEvent(
                                                                    DateTime
                                                                        .now(),
                                                                    ''));
                                                        Navigator.pushNamed(
                                                            context,
                                                            '/isolation_update_screen');
                                                      }, () {}, 16, 20)
                                                          .show();
                                                    }),
                                              ));
                                        }))
                              ]);
                        } else {
                          return Container()
                          ;
                        }
                      },
                    ),
                  ]));
            }));
  }
}
