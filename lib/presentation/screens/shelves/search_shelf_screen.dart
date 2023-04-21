// ignore_for_file: prefer_const_constructors, deprecated_member_use
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';

import '../../../constant.dart';
import '../../bloc/blocs/shelve_bloc.dart';
import '../../bloc/events/shelve_events.dart';
import '../../bloc/states/shelve_states.dart';
import '../../widgets/button_widget.dart';

class SearchShelfScreen extends StatefulWidget {
  const SearchShelfScreen({super.key});

  @override
  State<SearchShelfScreen> createState() => _SearchShelfScreennState();
}

class _SearchShelfScreennState extends State<SearchShelfScreen> {
  String location = '';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.west_outlined),
            onPressed: () {
              Navigator.pushNamed(context, '/shelves_function_screen');
            },
          ),
          backgroundColor: Constants.mainColor,
          title: Text(
            'Kệ kho',
            style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
          ),
        ),
        body: BlocConsumer<ShelveBloc, ShelveState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetAllLocationSuccessState) {
                return Column(children: [
                  Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 340 * SizeConfig.ratioWidth,
                        height: 60 * SizeConfig.ratioHeight,
                        child: DropdownSearch<String?>(
                            mode: Mode.MENU,
                            items: state.location,
                            showSearchBox: true,
                            label: "Vị trí",
                            onChanged: (value) {
                              //  print(value);
                              setState(() {
                                location = value!;
                              });
                            },
                            selectedItem: location),
                      ),
                    ),
                    CustomizedButton(
                        text: "Tìm kiếm",
                        onPressed: () {
                          BlocProvider.of<ShelveBloc>(context).add(
                              GetLotByLocationEvent(DateTime.now(), location, state.location));
                        }),
                    const Divider(
                      indent: 30,
                      endIndent: 30,
                      color: Constants.mainColor,
                      thickness: 1,
                    ),
                  
                  ])
                ]);
              }
              if (state is GetLotByLocationSuccessState) {
                return Column(
                  children: [
                     Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 340 * SizeConfig.ratioWidth,
                        height: 60 * SizeConfig.ratioHeight,
                        child: DropdownSearch<String?>(
                            mode: Mode.MENU,
                            items: state.listLocation,
                            showSearchBox: true,
                            label: "Vị trí",
                            onChanged: (value) {
                              //  print(value);
                              setState(() {
                                location = value!;
                              });
                            },
                            selectedItem: location),
                      ),
                    ),
                    CustomizedButton(
                        text: "Tìm kiếm",
                        onPressed: () {
                          BlocProvider.of<ShelveBloc>(context).add(
                              GetLotByLocationEvent(DateTime.now(), location, state.listLocation));
                        }),
                    const Divider(
                      indent: 30,
                      endIndent: 30,
                      color: Constants.mainColor,
                      thickness: 1,
                    ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                        overflow: TextOverflow.ellipsis,
                        "Danh sách các lô hàng",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20 * SizeConfig.ratioFont,
                          color: Colors.black,
                        ),
                    ),
                      ),
                    SizedBox(
                        height: 430 * SizeConfig.ratioHeight,
                        child: ListView.builder(
                            itemCount: state.itemLot.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                   child: Container(
                                    height: 110.0 * SizeConfig.ratioHeight,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                child: ListTile(
                                    leading: const Icon(Icons.list),
                                    // shape: RoundedRectangleBorder(
                                    //   side: BorderSide(width: 1),
                                    //   borderRadius: BorderRadius.circular(10),
                                    // ),
                                    trailing: Icon(Icons.arrow_drop_down_sharp,
                                        size: 15 * SizeConfig.ratioFont),
                                    title: Text(
                                        "Mã lô : ${state.itemLot[index].lotId}"),
                                    subtitle: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            "Sản phẩm : ${state.itemLot[index].item.itemId.toString()}  \nSố lượng : ${state.itemLot[index].quantity.toString()} \nVị trí : ${state.itemLot[index].location.toString()}"),
                                        Text(
                                            "Số PO : ${state.itemLot[index].purchaseOrderNumber.toString()} \nĐịnh mức : ${state.itemLot[index].sublotSize.toString()}"),
                                      ],
                                    ),
                                    isThreeLine: true,
                                    onTap: () {}),
                              ));
                            })),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
