
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/adjustment_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/other/adjustment_states.dart';

import '../../../bloc/events/other/adjustment_events.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/exception_widget.dart';

class LotAdjustmentScreen extends StatefulWidget {
  const LotAdjustmentScreen({super.key});

  @override
  State<LotAdjustmentScreen> createState() => _LotAdjustmentScreenState();
}

class _LotAdjustmentScreenState extends State<LotAdjustmentScreen> {
  // String controllerPO = '';
  // double controllerQuantity = 0;
  // String controllerNote = '';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, "/scan_adjustment_screen");
        return false;
      },
      child: Scaffold(
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
            return BlocConsumer<AdjustmentBloc, AdjustmentState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is GetLotDetailSuccessState) {
                  return SingleChildScrollView(
                    child: Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                padding:
                                    EdgeInsets.all(10 * SizeConfig.ratioHeight),
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
                                    Row(
                                         mainAxisAlignment:
                                              MainAxisAlignment.center, 
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,                                       
                                          children: [
                                            Text(
                                              overflow: TextOverflow.ellipsis,
                                              "Mã lô:",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize:
                                                    20 * SizeConfig.ratioFont,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
                                              child: Text(
                                                overflow: TextOverflow.ellipsis,
                                                "Mã hàng:",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize:
                                                      20 * SizeConfig.ratioFont,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
                                              child: Text(
                                                overflow: TextOverflow.ellipsis,
                                                "Tồn kho:",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize:
                                                      20 * SizeConfig.ratioFont,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                         padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
                                              child: Text(
                                                overflow: TextOverflow.ellipsis,
                                                "Thực tế:",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize:
                                                      20 * SizeConfig.ratioFont,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                                       padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
                                              child: Text(
                                                overflow: TextOverflow.ellipsis,
                                                "Ghi chú: ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize:
                                                      20 * SizeConfig.ratioFont,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                           padding: const EdgeInsets.fromLTRB(8, 5,8,0 ),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                width:
                                                    180 * SizeConfig.ratioWidth,
                                                height:
                                                    45 * SizeConfig.ratioHeight,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.black,
                                                      width: 1,
                                                    ),
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                8.0))),
                                                child: Center(
                                                  child: Text(
                                                    state.itemLots[0].lotId
                                                        .toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 20 *
                                                          SizeConfig.ratioFont,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(8, 5,8,0 ),
                                              child: Container(
                                                 padding:
                                                    const EdgeInsets.all(10),
                                                width:
                                                    180 * SizeConfig.ratioWidth,
                                                height:
                                                    45 * SizeConfig.ratioHeight,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.black,
                                                      width: 1,
                                                    ),
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                8.0))),
                                                child: Center(
                                                  child: Text(
                                                    state.itemLots[0].item!.itemId
                                                        .toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 20 *
                                                          SizeConfig.ratioFont,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                width:
                                                    180 * SizeConfig.ratioWidth,
                                                height:
                                                    45 * SizeConfig.ratioHeight,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.black,
                                                      width: 1,
                                                    ),
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                8.0))),
                                                child: Center(
                                                  child: Text(
                                                    state.itemLots[0]
                                                        .beforeQuantity
                                                        .toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 20 *
                                                          SizeConfig.ratioFont,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(8, 5,8,0 ),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5 *
                                                        SizeConfig.ratioHeight),
                                                alignment: Alignment.centerRight,
                                                width:
                                                    180 * SizeConfig.ratioWidth,
                                                height:
                                                    50 * SizeConfig.ratioHeight,
                                                //color: Colors.grey[200],
                                                child: TextField(
                                                  controller: TextEditingController(
                                                      text: state.itemLots[0]
                                                                  .afterQuantity ==
                                                              null
                                                          ? ''
                                                          : state.itemLots[0]
                                                              .afterQuantity
                                                              .toString()),
                                                  decoration:
                                                      const InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8.0))),
                                                  ),
                                                  keyboardType:
                                                      const TextInputType
                                                              .numberWithOptions(
                                                          decimal: true),
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp('[0-9.,]')),
                                                  ],
                                                  onChanged: (value) =>
                                                      value != ''
                                                          ? state.itemLots[0]
                                                                  .afterQuantity =
                                                              double.parse(value)
                                                          : state.itemLots[0]
                                                                  .afterQuantity =
                                                              double.parse('0'),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                             padding: const EdgeInsets.fromLTRB(8, 5,8,0 ),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5 *
                                                        SizeConfig.ratioHeight),
                                                alignment: Alignment.centerRight,
                                                width:
                                                    180 * SizeConfig.ratioWidth,
                                                height:
                                                    50 * SizeConfig.ratioHeight,
                                                //color: Colors.grey[200],
                                                child: TextField(
                                                  controller:
                                                      TextEditingController(
                                                          text: state.itemLots[0]
                                                                      .note ==
                                                                  null
                                                              ? ''
                                                              : state.itemLots[0]
                                                                  .note
                                                                  .toString()),
                                                  onChanged: (value) {
                                                    state.itemLots[0].note =
                                                        value;
                                                  },
                                                  decoration:
                                                      const InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8.0))),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 80, 0, 0),
                                      child: CustomizedButton(
                                          text: "Xác nhận",
                                          onPressed: () {
                                            BlocProvider.of<AdjustmentBloc>(
                                                    context)
                                                .add(
                                                    UpdateLotAdjustmentQuantityEvent(
                                              DateTime.now(),
                                              '',
                                              state.itemLots[0],
                                            ));
                                          }),
                                    )
                                  ],
                                ),
                              ),
                            ])),
                  );
                }

                if (state is GetLotDetailFailState) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ExceptionErrorState(
                          title: 'Mã lô không tồn tại',
                          message: "Quét lại mã lô khác",
                        ),
                        CustomizedButton(
                            text: "Trở lại",
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/scan_adjustment_screen');
                            })
                      ],
                    ),
                  );
                }
                if (state is UpdateLotQuantitySuccessState) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ExceptionErrorState(
                          icon: Icons.check_box_outlined,
                          title: 'Thành công',
                          message: "Đã hoàn thành kiểm kê lô",
                        ),
                        CustomizedButton(
                            text: "Trở lại",
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/scan_adjustment_screen');
                            })
                      ],
                    ),
                  );
                }
                if (state is UpdateLotQuantityFailState) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ExceptionErrorState(
                          title: 'Thất bại',
                          message: "Không thể hoàn thành kiểm kê lô",
                        ),
                        CustomizedButton(
                            text: "Trở lại",
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/scan_adjustment_screen');
                            })
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 100 * SizeConfig.ratioHeight,
                        ),
                        const CircularProgressIndicator(),
                        SizedBox(
                          height: 150 * SizeConfig.ratioHeight,
                        ),
                        CustomizedButton(
                            text: "Trở lại",
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/scan_adjustment_screen');
                            })
                      ],
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
