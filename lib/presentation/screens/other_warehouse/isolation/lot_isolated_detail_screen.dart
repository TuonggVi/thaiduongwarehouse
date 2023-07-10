// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mobile_warehouse_thaiduong/constant.dart';
// import 'package:mobile_warehouse_thaiduong/function.dart';
// import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/adjustment_bloc.dart';
// import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/isolation_bloc.dart';
// import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/adjustment_states.dart';
// import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/isolation_states.dart';

// import '../../bloc/events/adjustment_events.dart';
// import '../../widgets/button_widget.dart';
// import '../../widgets/exception_widget.dart';

// class LotDetailIsolatedScreen extends StatefulWidget {
//   const LotDetailIsolatedScreen({super.key});

//   @override
//   State<LotDetailIsolatedScreen> createState() => _LotDetailIsolatedScreenState();
// }

// class _LotDetailIsolatedScreenState extends State<LotDetailIsolatedScreen> {
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Constants.mainColor,
//         leading: IconButton(
//           icon: const Icon(Icons.west_outlined),
//           onPressed: () {
//             Navigator.pushNamed(context, '/isolation_function_screen');
//           },
//         ),
//         title: Text(
//           'Cách ly lô hàng',
//           style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
//         ),
//       ),
//       body: Builder(
//         builder: (BuildContext context) {
//           return BlocConsumer<IsolationBloc, IsolationState>(
//             listener: (context, state) {
//               // TODO: implement listener
//             },
//             builder: (context, state) {
//               if (state is GetLotByLotIdSuccessState) {
//                 return SingleChildScrollView(
//                   child: Container(
//                       padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
//                       child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             Container(
//                               alignment: Alignment.center,
//                               padding:
//                                   EdgeInsets.all(10 * SizeConfig.ratioHeight),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     overflow: TextOverflow.ellipsis,
//                                     "Thông tin lô cần cách ly",
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 20 * SizeConfig.ratioFont,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 10 * SizeConfig.ratioHeight,
//                                   ),
//                                   Column(
//                                     children: [
//                                       Container(
//                                         padding: const EdgeInsets.fromLTRB(
//                                             25, 10, 0, 0),
//                                         child: Row(
//                                           children: [
//                                             Text(
//                                               overflow: TextOverflow.ellipsis,
//                                               "Mã lô:                  ",
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.w600,
//                                                 fontSize:
//                                                     20 * SizeConfig.ratioFont,
//                                                 color: Colors.black,
//                                               ),
//                                             ),
//                                             Container(
//                                               padding:
//                                                   const EdgeInsets.fromLTRB(
//                                                       0, 10, 10, 10),
//                                               width:
//                                                   160 * SizeConfig.ratioWidth,
//                                               height:
//                                                   45 * SizeConfig.ratioHeight,
//                                               decoration: const BoxDecoration(
//                                                   shape: BoxShape.rectangle,
//                                                   color: Constants.buttonColor,
//                                                   borderRadius:
//                                                       BorderRadius.all(
//                                                           Radius.circular(
//                                                               8.0))),
//                                               child: Center(
//                                                 child: Text(
//                                                   state.itemLot.lotId,
//                                                   overflow:
//                                                       TextOverflow.ellipsis,
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.w300,
//                                                     fontSize: 22 *
//                                                         SizeConfig.ratioFont,
//                                                     color: Colors.black,
//                                                   ),
//                                                 ),
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                       Container(
//                                         padding: const EdgeInsets.fromLTRB(
//                                             25, 10, 0, 0),
//                                         child: Row(
//                                           children: [
//                                             Text(
//                                               overflow: TextOverflow.ellipsis,
//                                               "Mã sản phẩm:    ",
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.w600,
//                                                 fontSize:
//                                                     20 * SizeConfig.ratioFont,
//                                                 color: Colors.black,
//                                               ),
//                                             ),
//                                             Container(
//                                               width:
//                                                   160 * SizeConfig.ratioWidth,
//                                               height:
//                                                   45 * SizeConfig.ratioHeight,
//                                               decoration: const BoxDecoration(
//                                                   shape: BoxShape.rectangle,
//                                                   color: Constants.buttonColor,
//                                                   borderRadius:
//                                                       BorderRadius.all(
//                                                           Radius.circular(
//                                                               8.0))),
//                                               child: Center(
//                                                 child: Text(
//                                                   state.itemLot.item!.itemId
//                                                       .toString(),
//                                                   overflow:
//                                                       TextOverflow.ellipsis,
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.w300,
//                                                     fontSize: 22 *
//                                                         SizeConfig.ratioFont,
//                                                     color: Colors.black,
//                                                   ),
//                                                 ),
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                       Container(
//                                         padding: const EdgeInsets.fromLTRB(
//                                             25, 10, 0, 0),
//                                         child: Row(
//                                           children: [
//                                             Text(
//                                               overflow: TextOverflow.ellipsis,
//                                               "Số lượng:            ",
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.w600,
//                                                 fontSize:
//                                                     20 * SizeConfig.ratioFont,
//                                                 color: Colors.black,
//                                               ),
//                                             ),
//                                             Container(
//                                               // padding:
//                                               // const EdgeInsets.fromLTRB(0, 10, 10, 10),
//                                               width:
//                                                   160 * SizeConfig.ratioWidth,
//                                               height:
//                                                   45 * SizeConfig.ratioHeight,
//                                               decoration: const BoxDecoration(
//                                                   shape: BoxShape.rectangle,
//                                                   color: Constants.buttonColor,
//                                                   borderRadius:
//                                                       BorderRadius.all(
//                                                           Radius.circular(
//                                                               8.0))),
//                                               child: Center(
//                                                 child: Text(
//                                                   state.itemLot.quantity
//                                                       .toString(),
//                                                   overflow:
//                                                       TextOverflow.ellipsis,
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.w300,
//                                                     fontSize: 22 *
//                                                         SizeConfig.ratioFont,
//                                                     color: Colors.black,
//                                                   ),
//                                                 ),
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
                                     
//                                       Container(
//                                         padding: const EdgeInsets.fromLTRB(
//                                             25, 10, 0, 0),
//                                         child: Row(
//                                           children: [
//                                             Text(
//                                               overflow: TextOverflow.ellipsis,
//                                               "PO:                 ",
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.w600,
//                                                 fontSize:
//                                                     20 * SizeConfig.ratioFont,
//                                                 color: Colors.black,
//                                               ),
//                                             ),
//                                             Container(
//                                               // padding:
//                                               // const EdgeInsets.fromLTRB(0, 10, 10, 10),
//                                               width:
//                                                   160 * SizeConfig.ratioWidth,
//                                               height:
//                                                   45 * SizeConfig.ratioHeight,
//                                               decoration: const BoxDecoration(
//                                                   shape: BoxShape.rectangle,
//                                                   color: Constants.buttonColor,
//                                                   borderRadius:
//                                                       BorderRadius.all(
//                                                           Radius.circular(
//                                                               8.0))),
//                                               child: Center(
//                                                 child: Text(
//                                                   state.itemLot
//                                                       .purchaseOrderNumber
//                                                       .toString(),
//                                                   overflow:
//                                                       TextOverflow.ellipsis,
//                                                   style: TextStyle(
//                                                     fontWeight: FontWeight.w300,
//                                                     fontSize: 22 *
//                                                         SizeConfig.ratioFont,
//                                                     color: Colors.black,
//                                                   ),
//                                                 ),
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
                                     
                                      
//                                   Padding(
//                                     padding: const EdgeInsets.all(10.0),
//                                     child: CustomizedButton(
//                                         text: "Xác nhận",
//                                         onPressed: () {
                                        
//                                           BlocProvider.of<AdjustmentBloc>(
//                                                   context)
//                                               .add(
//                                                   UpdateLotAdjustmentQuantityEvent(
//                                                       DateTime.now(),
//                                                       '',
//                                                       state.lotAdjust,
//                                                       controllerPO,
//                                                       controllerQuantity,
//                                                       controllerNote));
//                                         }),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ])),
//                 );
//               }

//               if (state is GetLotDetailFailState) {
//                 return Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       ExceptionErrorState(
//                         title: 'Mã lô không tồn tại',
//                         message: "Quét lại mã lô khác",
//                       ),
//                       CustomizedButton(
//                           text: "Trở lại",
//                           onPressed: () {
//                             Navigator.pushNamed(
//                                 context, '/scan_adjustment_screen');
//                           })
//                     ],
//                   ),
//                 );
//               }
//               if (state is UpdateLotQuantitySuccessState) {
//                 return Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       ExceptionErrorState(
//                         icon: Icons.check_box_outlined,
//                         title: 'Thành công',
//                         message: "Đã hoàn thành kiểm kê lô",
//                       ),
//                       CustomizedButton(
//                           text: "Trở lại",
//                           onPressed: () {
//                             Navigator.pushNamed(
//                                 context, '/scan_adjustment_screen');
//                           })
//                     ],
//                   ),
//                 );
//               }
//               if (state is UpdateLotQuantityFailState) {
//                 return Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       ExceptionErrorState(
//                         title: 'Thất bại',
//                         message: "Không thể hoàn thành kiểm kê lô",
//                       ),
//                       CustomizedButton(
//                           text: "Trở lại",
//                           onPressed: () {
//                             Navigator.pushNamed(
//                                 context, '/scan_adjustment_screen');
//                           })
//                     ],
//                   ),
//                 );
//               } else {
//                 return Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         height: 100 * SizeConfig.ratioHeight,
//                       ),
//                       const CircularProgressIndicator(),
//                       SizedBox(
//                         height: 150 * SizeConfig.ratioHeight,
//                       ),
//                       CustomizedButton(
//                           text: "Trở lại",
//                           onPressed: () {
//                             Navigator.pushNamed(
//                                 context, '/scan_adjustment_screen');
//                           })
//                     ],
//                   ),
//                 );
//               }
//             },
//           );
//         },
//       ),
//     );
//   }
// }