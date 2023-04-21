// ignore_for_file: deprecated_member_use

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';

import '../../../constant.dart';
import '../../bloc/blocs/warning_bloc.dart';
import '../../bloc/events/warning_events.dart';
import '../../bloc/states/warning_states.dart';
import '../../widgets/button_widget.dart';

const List<String> expirationDate = <String> ['6 tháng', '1 năm', '2 năm'];

class WarningExpiredScreen extends StatefulWidget {
  const WarningExpiredScreen({super.key});

  @override
  State<WarningExpiredScreen> createState() => _WarningExpiredScreenState();
}

class _WarningExpiredScreenState extends State<WarningExpiredScreen> {
  @override
  Widget build(BuildContext context) {
    String expirationDate = '';
    SizeConfig().init(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.mainColor,
          leading: IconButton(
            icon: const Icon(Icons.west_outlined),
            onPressed: () {
              BlocProvider.of<WarningBloc>(context).add(
              ExpirationWarningEvent(DateTime.now(), expirationDate));
              Navigator.pushNamed(context, '/warning_function_screen');
            },
          ),
          title: Text(
            'Cảnh báo',
            style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
          ),
        ),
        body: Column(children: [
          Container(
            padding: const EdgeInsets.fromLTRB(8, 10, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 340 * SizeConfig.ratioWidth,
                  height: 60 * SizeConfig.ratioHeight,
                  child: DropdownSearch<String?>(
                      mode: Mode.MENU,
                      items: const ['6 tháng', '1 năm', '2 năm'],
                      showSearchBox: true,
                      label: "Hạn sử dụng còn lại",
                      // hint: "country in menu mode",
                      onChanged: (value) {
                        //  print(value);
                        setState(() {
                          expirationDate = value!;
                        });
                      },
                      selectedItem: expirationDate),
                ),
              ],
            ),
          ),
          CustomizedButton(
              text: "Truy xuất",
              onPressed: () {
                BlocProvider.of<WarningBloc>(context).add(
                    ExpirationWarningEvent(DateTime.now(), expirationDate));
              }),
          const Divider(
            indent: 30,
            endIndent: 30,
            color: Constants.mainColor,
            thickness: 1,
          ),
          BlocConsumer<WarningBloc, WarningState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is ExpirationWarningSuccessState) {
                  return Column(
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
                      SizedBox(
                          height: 450 * SizeConfig.ratioHeight,
                          child: ListView.builder(
                              itemCount: state.itemLot.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                     child: Container(
                                    height: 100.0 * SizeConfig.ratioHeight,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  child: ListTile(
                                      leading: const Icon(Icons.list),

                                      // shape: RoundedRectangleBorder(
                                      //   side: const BorderSide(width: 1),
                                      //   borderRadius: BorderRadius.circular(10),
                                      // ),
                                      trailing: Icon(
                                          Icons.arrow_drop_down_sharp,
                                          size: 15 * SizeConfig.ratioFont),
                                      title: Text(
                                          "Mã lô : ${state.itemLot[index].lotId}"),
                                      subtitle: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              "Sản phẩm : ${state.itemLot[index].item.itemId.toString()}  \nSố lượng : ${state.itemLot[index].quantity.toString()} \nVị trí : ${state.itemLot[index].purchaseOrderNumber.toString()}"),
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
                  return Container();
                  //const Center(child: CircularProgressIndicator());
                }
              }),
        ]));
  }
}
