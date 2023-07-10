// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mobile_warehouse_thaiduong/constant.dart';
// import 'package:mobile_warehouse_thaiduong/function.dart';
// import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/adjustment_bloc.dart';
// import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/adjustment_states.dart';

// import '../../bloc/events/adjustment_events.dart';
// import '../../widgets/button_widget.dart';
// import '../../widgets/exception_widget.dart';

// class LotAdjustmentScreen extends StatefulWidget {
//   const LotAdjustmentScreen({super.key});

//   @override
//   State<LotAdjustmentScreen> createState() => _LotAdjustmentScreenState();
// }

// class _LotAdjustmentScreenState extends State<LotAdjustmentScreen> {
//   // String controllerPO = '';
//   // double controllerQuantity = 0;
//   // String controllerNote = '';

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.pushReplacementNamed(context, "/scan_adjustment_screen");
//         return false;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Constants.mainColor,
//           leading: IconButton(
//             icon: const Icon(Icons.west_outlined),
//             onPressed: () {
//               Navigator.pushNamed(context, '/scan_adjustment_screen');
//             },
//           ),
//           title: Text(
//             'Điều chỉnh lô',
//             style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
//           ),
//         ),
//         body: Builder(
//           builder: (BuildContext context) {
//             return BlocConsumer<AdjustmentBloc, AdjustmentState>(
//               listener: (context, state) {},
//               builder: (context, state) {
//                 if (state is GetLotDetailSuccessState) {
//                   return SingleChildScrollView(
//                     child: Container(
//                         padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
//                         child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Container(
//                                 alignment: Alignment.center,
//                                 padding:
//                                     EdgeInsets.all(10 * SizeConfig.ratioHeight),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       overflow: TextOverflow.ellipsis,
//                                       "Thông tin lô cần điều chỉnh",
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.w600,
//                                         fontSize: 20 * SizeConfig.ratioFont,
//                                         color: Colors.black,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 10 * SizeConfig.ratioHeight,
//                                     ),
//                                     Column(
//                                       children: [
//                                         Container(
//                                           padding: const EdgeInsets.fromLTRB(
//                                               25, 10, 0, 0),
//                                           child: Row(
//                                             children: [
//                                               Text(
//                                                 overflow: TextOverflow.ellipsis,
//                                                 "Mã lô:               ",
//                                                 style: TextStyle(
//                                                   fontWeight: FontWeight.w600,
//                                                   fontSize:
//                                                       20 * SizeConfig.ratioFont,
//                                                   color: Colors.black,
//                                                 ),
//                                               ),
//                                               Container(
//                                                 padding:
//                                                     const EdgeInsets.fromLTRB(
//                                                         0, 10, 10, 10),
//                                                 width:
//                                                     180 * SizeConfig.ratioWidth,
//                                                 height:
//                                                     45 * SizeConfig.ratioHeight,
//                                                 decoration: BoxDecoration(
//                                                     border: Border.all(
//                                                       color: Colors.black,
//                                                       width: 1,
//                                                     ),
//                                                     shape: BoxShape.rectangle,
//                                                     borderRadius:
//                                                         const BorderRadius.all(
//                                                             Radius.circular(
//                                                                 8.0))),
//                                                 child: Center(
//                                                   child: Text(
//                                                     state.itemLots[0].lotId
//                                                         .toString(),
//                                                     overflow:
//                                                         TextOverflow.ellipsis,
//                                                     style: TextStyle(
//                                                       fontSize: 20 *
//                                                           SizeConfig.ratioFont,
//                                                       color: Colors.black,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                         Container(
//                                           padding: const EdgeInsets.fromLTRB(
//                                               25, 10, 0, 0),
//                                           child: Row(
//                                             children: [
//                                               Text(
//                                                 overflow: TextOverflow.ellipsis,
//                                                 "Mã hàng:         ",
//                                                 style: TextStyle(
//                                                   fontWeight: FontWeight.w600,
//                                                   fontSize:
//                                                       20 * SizeConfig.ratioFont,
//                                                   color: Colors.black,
//                                                 ),
//                                               ),
//                                               Container(
//                                                 width:
//                                                     180 * SizeConfig.ratioWidth,
//                                                 height:
//                                                     45 * SizeConfig.ratioHeight,
//                                                 decoration: BoxDecoration(
//                                                     border: Border.all(
//                                                       color: Colors.black,
//                                                       width: 1,
//                                                     ),
//                                                     shape: BoxShape.rectangle,
//                                                     borderRadius:
//                                                         const BorderRadius.all(
//                                                             Radius.circular(
//                                                                 8.0))),
//                                                 child: Center(
//                                                   child: Text(
//                                                     state.itemLots[0].item!
//                                                         .itemId
//                                                         .toString(),
//                                                     overflow:
//                                                         TextOverflow.ellipsis,
//                                                     style: TextStyle(
//                                                       fontSize: 20 *
//                                                           SizeConfig.ratioFont,
//                                                       color: Colors.black,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                         Container(
//                                           padding: const EdgeInsets.fromLTRB(
//                                               25, 10, 0, 0),
//                                           child: Row(
//                                             children: [
//                                               Text(
//                                                 overflow: TextOverflow.ellipsis,
//                                                 "Tồn kho:          ",
//                                                 style: TextStyle(
//                                                   fontWeight: FontWeight.w600,
//                                                   fontSize:
//                                                       20 * SizeConfig.ratioFont,
//                                                   color: Colors.black,
//                                                 ),
//                                               ),
//                                               Container(
//                                                 // padding:
//                                                 // const EdgeInsets.fromLTRB(0, 10, 10, 10),
//                                                 width:
//                                                     180 * SizeConfig.ratioWidth,
//                                                 height:
//                                                     45 * SizeConfig.ratioHeight,
//                                                 decoration: BoxDecoration(
//                                                     border: Border.all(
//                                                       color: Colors.black,
//                                                       width: 1,
//                                                     ),
//                                                     shape: BoxShape.rectangle,
//                                                     borderRadius:
//                                                         const BorderRadius.all(
//                                                             Radius.circular(
//                                                                 8.0))),
//                                                 child: Center(
//                                                   child: Text(
//                                                     state.itemLots[0]
//                                                         .beforeQuantity
//                                                         .toString(),
//                                                     overflow:
//                                                         TextOverflow.ellipsis,
//                                                     style: TextStyle(
//                                                       fontSize: 20 *
//                                                           SizeConfig.ratioFont,
//                                                       color: Colors.black,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                         Container(
//                                           padding: const EdgeInsets.fromLTRB(
//                                               25, 10, 0, 0),
//                                           child: Row(
//                                             children: [
//                                               Text(
//                                                 overflow: TextOverflow.ellipsis,
//                                                 "Thực tế:          ",
//                                                 style: TextStyle(
//                                                   fontWeight: FontWeight.w600,
//                                                   fontSize:
//                                                       20 * SizeConfig.ratioFont,
//                                                   color: Colors.black,
//                                                 ),
//                                               ),
//                                               Container(
//                                                 padding: EdgeInsets.symmetric(
//                                                     vertical: 5 *
//                                                         SizeConfig.ratioHeight),
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 width:
//                                                     180 * SizeConfig.ratioWidth,
//                                                 height:
//                                                     50 * SizeConfig.ratioHeight,
//                                                 //color: Colors.grey[200],
//                                                 child: TextField(
//                                                   controller: TextEditingController(
//                                                       text: state.itemLots[0]
//                                                                   .afterQuantity ==
//                                                               null
//                                                           ? ''
//                                                           : state.itemLots[0]
//                                                               .afterQuantity
//                                                               .toString()),
//                                                   decoration:
//                                                       const InputDecoration(
//                                                     border: OutlineInputBorder(
//                                                         borderRadius:
//                                                             BorderRadius.all(
//                                                                 Radius.circular(
//                                                                     8.0))),
//                                                   ),
//                                                   keyboardType:
//                                                       const TextInputType
//                                                               .numberWithOptions(
//                                                           decimal: true),
//                                                   inputFormatters: [
//                                                     FilteringTextInputFormatter
//                                                         .allow(
//                                                             RegExp('[0-9.,]')),
//                                                   ],
//                                                   // onSubmitted: (value) =>
//                                                   //     value != ''
//                                                   //         ? controllerQuantity =
//                                                   //             double.parse(value)
//                                                   //         : controllerQuantity =
//                                                   //             double.parse('0'),
//                                                   onChanged: (value) => value !=
//                                                           ''
//                                                       ? state.itemLots[0]
//                                                               .afterQuantity =
//                                                           double.parse(value)
//                                                       : state.itemLots[0]
//                                                               .afterQuantity =
//                                                           double.parse('0'),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         // Container(
//                                         //   padding: const EdgeInsets.fromLTRB(
//                                         //       25, 10, 0, 0),
//                                         //   child: Row(
//                                         //     children: [
//                                         //       Text(
//                                         //         overflow: TextOverflow.ellipsis,
//                                         //         "PO cũ:                 ",
//                                         //         style: TextStyle(
//                                         //           fontWeight: FontWeight.w600,
//                                         //           fontSize:
//                                         //               20 * SizeConfig.ratioFont,
//                                         //           color: Colors.black,
//                                         //         ),
//                                         //       ),
//                                         //       Container(
//                                         //         // padding:
//                                         //         // const EdgeInsets.fromLTRB(0, 10, 10, 10),
//                                         //         width:
//                                         //             180 * SizeConfig.ratioWidth,
//                                         //         height:
//                                         //             45 * SizeConfig.ratioHeight,
//                                         //         decoration: BoxDecoration(
//                                         //             border: Border.all(
//                                         //               color: Colors.black,
//                                         //               width: 1,
//                                         //             ),
//                                         //             shape: BoxShape.rectangle,
//                                         //             borderRadius:
//                                         //                 const BorderRadius.all(
//                                         //                     Radius.circular(
//                                         //                         8.0))),
//                                         //         child: Center(
//                                         //           child: Text(
//                                         //             state
//                                         //                 .itemLots[0].oldPoNumber
//                                         //                 .toString(),
//                                         //             overflow:
//                                         //                 TextOverflow.ellipsis,
//                                         //             style: TextStyle(
//                                         //               fontWeight:
//                                         //                   FontWeight.w300,
//                                         //               fontSize: 22 *
//                                         //                   SizeConfig.ratioFont,
//                                         //               color: Colors.black,
//                                         //             ),
//                                         //           ),
//                                         //         ),
//                                         //       )
//                                         //     ],
//                                         //   ),
//                                         // ),
//                                         // Container(
//                                         //   padding: const EdgeInsets.fromLTRB(
//                                         //       25, 10, 0, 0),
//                                         //   child: Row(
//                                         //     children: [
//                                         //       Text(
//                                         //         overflow: TextOverflow.ellipsis,
//                                         //         "PO mới:               ",
//                                         //         style: TextStyle(
//                                         //           fontWeight: FontWeight.w600,
//                                         //           fontSize:
//                                         //               20 * SizeConfig.ratioFont,
//                                         //           color: Colors.black,
//                                         //         ),
//                                         //       ),
//                                         //       Container(
//                                         //         padding: EdgeInsets.symmetric(
//                                         //             vertical: 5 *
//                                         //                 SizeConfig.ratioHeight),
//                                         //         alignment:
//                                         //             Alignment.centerRight,
//                                         //         width:
//                                         //             180 * SizeConfig.ratioWidth,
//                                         //         height:
//                                         //             50 * SizeConfig.ratioHeight,
//                                         //         //color: Colors.grey[200],
//                                         //         child: TextField(
//                                         //           controller: TextEditingController(
//                                         //               text: state.itemLots[0]
//                                         //                           .newPoNumber ==
//                                         //                       null
//                                         //                   ? ''
//                                         //                   : state.itemLots[0]
//                                         //                       .newPoNumber
//                                         //                       .toString()
//                                         //                       .toString()),
//                                         //           onChanged: (value) {
//                                         //             state.itemLots[0]
//                                         //                 .newPoNumber = value;
//                                         //           },
//                                         //           decoration:
//                                         //               const InputDecoration(
//                                         //             border: OutlineInputBorder(
//                                         //                 borderRadius:
//                                         //                     BorderRadius.all(
//                                         //                         Radius.circular(
//                                         //                             8.0))),
                                                 
//                                         //           ),
//                                         //         ),
//                                         //       ),
//                                         //     ],
//                                         //   ),
//                                         // ),
//                                         Container(
//                                           padding: const EdgeInsets.fromLTRB(
//                                               25, 10, 0, 0),
//                                           child: Row(
//                                             children: [
//                                               Text(
//                                                 overflow: TextOverflow.ellipsis,
//                                                 "Ghi chú:          ",
//                                                 style: TextStyle(
//                                                   fontWeight: FontWeight.w600,
//                                                   fontSize:
//                                                       20 * SizeConfig.ratioFont,
//                                                   color: Colors.black,
//                                                 ),
//                                               ),
//                                               Container(
//                                                 padding: EdgeInsets.symmetric(
//                                                     vertical: 5 *
//                                                         SizeConfig.ratioHeight),
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 width:
//                                                     180 * SizeConfig.ratioWidth,
//                                                 height:
//                                                     50 * SizeConfig.ratioHeight,
//                                                 //color: Colors.grey[200],
//                                                 child: TextField(
//                                                   controller:
//                                                       TextEditingController(
//                                                           text: state
//                                                                       .itemLots[
//                                                                           0]
//                                                                       .note ==
//                                                                   null
//                                                               ? ''
//                                                               : state
//                                                                   .itemLots[0]
//                                                                   .note
//                                                                   .toString()),
//                                                   onChanged: (value) {
//                                                     state.itemLots[0].note =
//                                                         value;
//                                                   },
//                                                   decoration:
//                                                       const InputDecoration(
                                                        
//                                                    border:
//                                                         OutlineInputBorder(
                                                          
//                                                           borderRadius:
//                                                         BorderRadius.all(
//                                                             Radius.circular(
//                                                                 8.0))
//                                                         ), 
                                                       
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
//                                       child: CustomizedButton(
//                                           text: "Xác nhận",
//                                           onPressed: () {
//                                             BlocProvider.of<AdjustmentBloc>(
//                                                     context)
//                                                 .add(
//                                                     UpdateLotAdjustmentQuantityEvent(
//                                               DateTime.now(),
//                                               '',
//                                               state.itemLots[0],
//                                             ));
//                                           }),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ])),
//                   );
//                   // return Column(
//                   //   children: [
//                   //     SingleChildScrollView(
//                   //       scrollDirection: Axis.horizontal,
//                   //       child: SingleChildScrollView(
//                   //         scrollDirection: Axis.vertical,
//                   //         child: DataTable(
//                   //           columns:const [
//                   //             DataColumn(label: Text('Mã lô')),
//                   //             DataColumn(label: Text('SL')),
//                   //             DataColumn(label: Text('PO')),
//                   //             DataColumn(label: Text('SL mới')),
//                   //             DataColumn(label: Text('PO mới')),
//                   //             DataColumn(label: Text('Note')),
//                   //           ],
//                   //           rows: state
//                   //               .itemLots // Loops through dataColumnText, each iteration assigning the value to element
//                   //               .map(
//                   //                 ((element) => DataRow(
//                   //                       cells: <DataCell>[
//                   //                         DataCell(Text(element.lotId
//                   //                             .toString())), //Extracting from Map element the value
//                   //                         DataCell(
//                   //                             Text(element.beforeQuantity.toString())),
//                   //                         DataCell(
//                   //                           Text(element.oldPoNumber
//                   //                               .toString()),
//                   //                         ),
//                   //                         DataCell(
//                   //                             TextField(
//                   //                               controller:
//                   //                                    TextEditingController(text: element.afterQuantity.toString()),
//                   //                             ),
//                   //                             showEditIcon: true),
//                   //                         DataCell(
//                   //                           TextField(
//                   //                               controller:
//                   //                                    TextEditingController(text: element.newPoNumber ?? ""),
//                   //                             ),
//                   //                             showEditIcon: true),
//                   //                         DataCell(
//                   //                             TextField(
//                   //                               controller:
//                   //                                    TextEditingController(text: element.note ?? ""),
//                   //                             ),
//                   //                             showEditIcon: true),
//                   //                       ],
//                   //                     )),
//                   //               )
//                   //               .toList(),
//                   //         ),
//                   //       ),
//                   //     ),
//                   //     TextButton(onPressed: () {}, child: Text('Xác nhận'))
//                   //   ],
//                   // );
//                 }

//                 if (state is GetLotDetailFailState) {
//                   return Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         ExceptionErrorState(
//                           title: 'Mã lô không tồn tại',
//                           message: "Quét lại mã lô khác",
//                         ),
//                         CustomizedButton(
//                             text: "Trở lại",
//                             onPressed: () {
//                               Navigator.pushNamed(
//                                   context, '/scan_adjustment_screen');
//                             })
//                       ],
//                     ),
//                   );
//                 }
//                 if (state is UpdateLotQuantitySuccessState) {
//                   return Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         ExceptionErrorState(
//                           icon: Icons.check_box_outlined,
//                           title: 'Thành công',
//                           message: "Đã hoàn thành kiểm kê lô",
//                         ),
//                         CustomizedButton(
//                             text: "Trở lại",
//                             onPressed: () {
//                               Navigator.pushNamed(
//                                   context, '/scan_adjustment_screen');
//                             })
//                       ],
//                     ),
//                   );
//                 }
//                 if (state is UpdateLotQuantityFailState) {
//                   return Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         ExceptionErrorState(
//                           title: 'Thất bại',
//                           message: "Không thể hoàn thành kiểm kê lô",
//                         ),
//                         CustomizedButton(
//                             text: "Trở lại",
//                             onPressed: () {
//                               Navigator.pushNamed(
//                                   context, '/scan_adjustment_screen');
//                             })
//                       ],
//                     ),
//                   );
//                 } else {
//                   return Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                           height: 100 * SizeConfig.ratioHeight,
//                         ),
//                         const CircularProgressIndicator(),
//                         SizedBox(
//                           height: 150 * SizeConfig.ratioHeight,
//                         ),
//                         CustomizedButton(
//                             text: "Trở lại",
//                             onPressed: () {
//                               Navigator.pushNamed(
//                                   context, '/scan_adjustment_screen');
//                             })
//                       ],
//                     ),
//                   );
//                 }
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
