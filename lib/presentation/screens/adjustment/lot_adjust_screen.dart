// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';

import '../../widgets/button_widget.dart';

class LotAdjustmentScreen extends StatefulWidget {
  const LotAdjustmentScreen({super.key});

  @override
  State<LotAdjustmentScreen> createState() => _LotAdjustmentScreenState();
}

class _LotAdjustmentScreenState extends State<LotAdjustmentScreen> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.mainColor,
        leading: IconButton(
          icon: const Icon(Icons.west_outlined),
          onPressed: () {
            Navigator.pushNamed(context, '/scan_adjustment_screen');
          },
        ),
        title: Text(
          'Điều chỉnh lô',
          style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
        ),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 100),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10 * SizeConfig.ratioHeight),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            overflow: TextOverflow.ellipsis,
                            "Thông tin lô cần điều chỉnh",
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
                          Container(
                           padding: const EdgeInsets.fromLTRB(25, 10, 0, 0),
                            child: Row(
                              children: [
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  "Mã lô:                  ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20 * SizeConfig.ratioFont,
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.fromLTRB(
                                      0, 10, 10, 10),
                                  width: 160 * SizeConfig.ratioWidth,
                                  height: 45 * SizeConfig.ratioHeight,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Constants.buttonColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0))),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(25, 10, 0, 0),
                            child: Row(
                              children: [
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  "Mã sản phẩm:    ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20 * SizeConfig.ratioFont,
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.fromLTRB(
                                      0, 10, 10, 10),
                                  width: 160 * SizeConfig.ratioWidth,
                                  height: 45 * SizeConfig.ratioHeight,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Constants.buttonColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0))),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(25, 10, 0, 0),
                            child: Row(
                              children: [
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  "Lượng cũ:            ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20 * SizeConfig.ratioFont,
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                  // padding:
                                  // const EdgeInsets.fromLTRB(0, 10, 10, 10),
                                  width: 160 * SizeConfig.ratioWidth,
                                  height: 45 * SizeConfig.ratioHeight,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Constants.buttonColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0))),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(25, 10, 0, 0),
                            child: Row(
                              children: [
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  "Lượng mới:         ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20 * SizeConfig.ratioFont,
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5 * SizeConfig.ratioHeight),
                                  alignment: Alignment.centerRight,
                                  width: 160 * SizeConfig.ratioWidth,
                                  height: 45 * SizeConfig.ratioHeight,
                                  //color: Colors.grey[200],
                                  child: TextField(
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Constants.buttonColor,
                                      // labelText: "Nhập lượng mới"
                                    ),
                                    keyboardType: const TextInputType
                                        .numberWithOptions(decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[0-9.,]')),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(25, 10, 0, 0),
                            child: Row(
                              children: [
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  "PO cũ:                 ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20 * SizeConfig.ratioFont,
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                  // padding:
                                  // const EdgeInsets.fromLTRB(0, 10, 10, 10),
                                  width: 160 * SizeConfig.ratioWidth,
                                  height: 45 * SizeConfig.ratioHeight,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Constants.buttonColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0))),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(25, 10, 0, 0),
                            child: Row(
                              children: [
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  "PO mới:               ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20 * SizeConfig.ratioFont,
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5 * SizeConfig.ratioHeight),
                                  alignment: Alignment.centerRight,
                                  width: 160 * SizeConfig.ratioWidth,
                                  height: 45 * SizeConfig.ratioHeight,
                                  //color: Colors.grey[200],
                                  child: const TextField(
                                    decoration: InputDecoration(
                                      // labelText: "PO mới",
                                      // labelStyle: TextStyle(
                                      //   color:
                                      //       Color.fromRGBO(136, 136, 136, 1),
                                      //   fontSize: 18,
                                      // ),
                                      filled: true,
                                      fillColor: Constants.buttonColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(25, 10, 0, 0),
                            child: Row(
                              children: [
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  "Ghi chú:              ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20 * SizeConfig.ratioFont,
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5 * SizeConfig.ratioHeight),
                                  alignment: Alignment.centerRight,
                                  width: 160 * SizeConfig.ratioWidth,
                                  height: 45 * SizeConfig.ratioHeight,
                                  //color: Colors.grey[200],
                                  child: const TextField(
                                    decoration: InputDecoration(
                                      // labelText: "Ghi chú",
                                      // labelStyle: TextStyle(
                                      //   color:
                                      //       Color.fromRGBO(136, 136, 136, 1),
                                      //   fontSize: 18,
                                      // ),
                                      filled: true,
                                      fillColor: Constants.buttonColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                            ],
                          ),
                          CustomizedButton(text: "Tiếp tục", onPressed: () {})
                        ],
                      ),
                    ),
                  ]));
        },
      ),
    );
  }
}
