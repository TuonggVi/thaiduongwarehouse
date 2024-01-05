// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/location.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/lot_adjustment.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/adjustment_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/other/adjustment_states.dart';

import '../../../../domain/entities/item.dart';
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

  Map<int, TextEditingController> controllers = {};
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
                  double totalQuantity = 0;
                  List<ItemLotSublot> itemLotSublot = [];
                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    reverse: true,
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
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ListTile(
                                    // trailing: Icon(Icons.edit,
                                    //     size: 17 * SizeConfig.ratioFont),
                                    title: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Mã lô: ${state.itemLots[0].lotId}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20 * SizeConfig.ratioFont,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize:
                                                  20 * SizeConfig.ratioFont,
                                              color: Colors.black,
                                            ),
                                            "Mã hàng: ${state.itemLots[0].item?.itemId}"),
                                      ],
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize:
                                                      20 * SizeConfig.ratioFont,
                                                  color: Colors.black,
                                                ),
                                                "Đối với từng vị trí"),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: state
                                                  .itemLot.itemLotSubLot.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                ItemLotSublot sublot =
                                                    ItemLotSublot(
                                                  state
                                                      .itemLot
                                                      .itemLotSubLot[index]
                                                      .locationId,
                                                  state
                                                      .itemLot
                                                      .itemLotSubLot[index]
                                                      .quantityPerLocation,
                                                  state
                                                      .itemLot
                                                      .itemLotSubLot[index]
                                                      .newQuantityPerLocation,
                                                );
                                                itemLotSublot.add(sublot);

                                                totalQuantity += state
                                                        .itemLot
                                                        .itemLotSubLot[index]
                                                        .newQuantityPerLocation ??
                                                    0;
                                                return ListTile(
                                                    title: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                "${state.itemLot.itemLotSubLot[index].locationId}"),
                                                          ],
                                                        ),
                                                        Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                const Text(
                                                                    "Tồn kho:"),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child:
                                                                      Container(
                                                                    width: 120 *
                                                                        SizeConfig
                                                                            .ratioWidth,
                                                                    height: 40 *
                                                                        SizeConfig
                                                                            .ratioHeight,
                                                                    decoration: BoxDecoration(
                                                                        border: Border.all(
                                                                          color:
                                                                              Colors.black45,
                                                                          width:
                                                                              1,
                                                                        ),
                                                                        shape: BoxShape.rectangle,
                                                                        borderRadius: const BorderRadius.all(Radius.circular(5.0))),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        state
                                                                            .itemLot
                                                                            .itemLotSubLot[index]
                                                                            .quantityPerLocation
                                                                            .toString(),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              20 * SizeConfig.ratioFont,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                const Text(
                                                                    "Thực tế:"),
                                                                Container(
                                                                  padding: EdgeInsets.symmetric(
                                                                      vertical: 10 *
                                                                          SizeConfig
                                                                              .ratioHeight),
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
                                                                  width: 120 *
                                                                      SizeConfig
                                                                          .ratioWidth,
                                                                  height: 60 *
                                                                      SizeConfig
                                                                          .ratioHeight,
                                                                  child:
                                                                      TextField(
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20 *
                                                                                SizeConfig.ratioFont),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    textAlignVertical:
                                                                        TextAlignVertical
                                                                            .center,
                                                                    controller:
                                                                        controllers[
                                                                            index],
                                                                    onSubmitted: (value) => value ==
                                                                            ''
                                                                        ? state.itemLot.itemLotSubLot[index].newQuantityPerLocation =
                                                                            double.parse(
                                                                                '0')
                                                                        : state
                                                                            .itemLot
                                                                            .itemLotSubLot[index]
                                                                            .newQuantityPerLocation = double.parse(value),
                                                                    decoration:
                                                                        InputDecoration(
                                                                      border: OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(5)),
                                                                      labelStyle:
                                                                          TextStyle(
                                                                              fontSize: 15 * SizeConfig.ratioFont),
                                                                    ),
                                                                    keyboardType: const TextInputType
                                                                            .numberWithOptions(
                                                                        decimal:
                                                                            true),
                                                                    inputFormatters: [
                                                                      FilteringTextInputFormatter
                                                                          .allow(
                                                                              RegExp(r'^\d+\.?\d{0,1}')),
                                                                    ],

                                                                    // tham số đầu vào value chứa giá trị người dùng nhập vào
                                                                    onChanged: (value) => value ==
                                                                            ''
                                                                        ? state.itemLot.itemLotSubLot[index].newQuantityPerLocation =
                                                                            double.parse(
                                                                                '0')
                                                                        : state
                                                                            .itemLot
                                                                            .itemLotSubLot[index]
                                                                            .newQuantityPerLocation = double.parse(value),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    subtitle: Container());
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize:
                                                      20 * SizeConfig.ratioFont,
                                                  color: Colors.black,
                                                ),
                                                "Đối với lô hàng"),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: 1,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return ListTile(
                                                    title: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            const Text(
                                                                "Tồn kho:"),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Container(
                                                                width: 120 *
                                                                    SizeConfig
                                                                        .ratioWidth,
                                                                height: 40 *
                                                                    SizeConfig
                                                                        .ratioHeight,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        border: Border
                                                                            .all(
                                                                          color:
                                                                              Colors.black45,
                                                                          width:
                                                                              1,
                                                                        ),
                                                                        shape: BoxShape
                                                                            .rectangle,
                                                                        borderRadius:
                                                                            const BorderRadius.all(Radius.circular(5.0))),
                                                                child: Center(
                                                                  child: Text(
                                                                    state
                                                                        .itemLots[
                                                                            0]
                                                                        .beforeQuantity
                                                                        .toString(),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize: 20 *
                                                                          SizeConfig
                                                                              .ratioFont,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),

                                                        // đối với lô hàng
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            const Text(
                                                                "Thực tế:"),
                                                            Container(
                                                              padding: EdgeInsets.symmetric(
                                                                  vertical: 10 *
                                                                      SizeConfig
                                                                          .ratioHeight),
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              width: 120 *
                                                                  SizeConfig
                                                                      .ratioWidth,
                                                              height: 60 *
                                                                  SizeConfig
                                                                      .ratioHeight,
                                                              child: TextField(
                                                                  textAlign: TextAlign
                                                                      .center,
                                                                  textAlignVertical:
                                                                      TextAlignVertical
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontSize: 20 *
                                                                          SizeConfig
                                                                              .ratioFont),
                                                                  controller: TextEditingController(
                                                                      text: totalQuantity == null
                                                                          ? ''
                                                                          : totalQuantity
                                                                              .toString()),
                                                                  // controllers[
                                                                  //     index],
                                                                  onSubmitted: (value) => value ==
                                                                          ''
                                                                      ? totalQuantity =
                                                                          //  state.itemLots[0].afterQuantity  =
                                                                          double.parse(
                                                                              '0')
                                                                      : totalQuantity = double.parse(
                                                                          value),
                                                                  decoration:
                                                                      InputDecoration(
                                                                    border: OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5)),
                                                                    labelStyle: TextStyle(
                                                                        fontSize:
                                                                            20 *
                                                                                SizeConfig.ratioFont),
                                                                    //  labelText: "Thực tế"
                                                                  ),
                                                                  keyboardType:
                                                                      const TextInputType.numberWithOptions(
                                                                          decimal:
                                                                              true),
                                                                  inputFormatters: [
                                                                    FilteringTextInputFormatter
                                                                        .allow(RegExp(
                                                                            r'[0-9.,]')),
                                                                  ],
                                                                  // tham số đầu vào value chứa giá trị người dùng nhập vào
                                                                  onChanged: (value) => value ==
                                                                          ''
                                                                      ? totalQuantity =
                                                                          double.parse('0')
                                                                      : totalQuantity = double.parse(value)),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    subtitle: Container());
                                              },
                                            ),
                                          ),
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: 1,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return ListTile(
                                                  title: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        const Text("Ghi chú:"),
                                                        Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 10 *
                                                                      SizeConfig
                                                                          .ratioHeight),
                                                          alignment: Alignment
                                                              .centerRight,
                                                          width: 120 *
                                                              SizeConfig
                                                                  .ratioWidth,
                                                          height: 60 *
                                                              SizeConfig
                                                                  .ratioHeight,
                                                          child: TextField(
                                                            style: TextStyle(
                                                                fontSize: 20 *
                                                                    SizeConfig
                                                                        .ratioFont),
                                                            textAlign: TextAlign
                                                                .center,
                                                            textAlignVertical:
                                                                TextAlignVertical
                                                                    .center,
                                                            controller: TextEditingController(
                                                                text: state
                                                                            .itemLots[
                                                                                0]
                                                                            .note ==
                                                                        null
                                                                    ? ''
                                                                    : state
                                                                        .itemLots[
                                                                            0]
                                                                        .note
                                                                        .toString()),
                                                            onChanged: (value) {
                                                              state.itemLots[0]
                                                                  .note = value;
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
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  subtitle: Container());
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    isThreeLine: true,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Column(
                                    children: [
                                      CustomizedButton(
                                          text: "Xác nhận",
                                          onPressed: () {
                                            BlocProvider.of<AdjustmentBloc>(
                                                    context)
                                                .add(
                                                    UpdateLotAdjustmentQuantityEvent(
                                              DateTime.now(),
                                              '',
                                              LotAdjustment(
                                                state.itemLots[0].lotId,
                                                state.itemLots[0].note,
                                                state.itemLots[0].employee,
                                                DateTime.now(),
                                                totalQuantity,
                                                state
                                                    .itemLots[0].beforeQuantity,
                                                itemLotSublot,
                                                Item(
                                                    state.itemLots[0].item!
                                                        .itemId,
                                                    state.itemLots[0].item!
                                                        .itemName,
                                                    state
                                                        .itemLots[0].item!.unit,
                                                    state.itemLots[0].item!
                                                        .itemClass,
                                                    state.itemLots[0].item!
                                                        .minimumStockLevel,
                                                    state.itemLots[0].item!
                                                        .price),
                                                null,
                                              ),
                                            ));
                                          }),
                                      CustomizedButton(
                                          text: "Trở lại",
                                          onPressed: () {
                                            BlocProvider.of<AdjustmentBloc>(
                                                    context)
                                                .add(GetLotEvent(
                                                    DateTime.now(), ''));
                                            Navigator.pushNamed(context,
                                                '/scan_adjustment_screen');
                                          })
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ]),
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
                              BlocProvider.of<AdjustmentBloc>(context)
                                  .add(GetLotEvent(DateTime.now(), ''));
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
                              BlocProvider.of<AdjustmentBloc>(context)
                                  .add(GetLotEvent(DateTime.now(), ''));
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
                              BlocProvider.of<AdjustmentBloc>(context)
                                  .add(GetLotEvent(DateTime.now(), ''));
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
                              BlocProvider.of<AdjustmentBloc>(context)
                                  .add(GetLotEvent(DateTime.now(), ''));
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
