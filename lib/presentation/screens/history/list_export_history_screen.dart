// ignore_for_file: prefer_const_constructors, avoid_print, deprecated_member_use, unused_import
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import '../../../constant.dart';
import '../../bloc/blocs/history_bloc.dart';
import '../../bloc/events/history_events.dart';
import '../../bloc/states/history_states.dart';
import '../../widgets/button_widget.dart';

class ListExportHistoryScreen extends StatefulWidget {
  const ListExportHistoryScreen({super.key});

  @override
  State<ListExportHistoryScreen> createState() =>
      _ListExportHistoryScreenState();
}

class _ListExportHistoryScreenState extends State<ListExportHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.mainColor,
          leading: IconButton(
            icon: const Icon(Icons.west_outlined),
            onPressed: () {
              Navigator.pushNamed(context, '/export_history_screen');
            },
          ),
          title: Text(
            'Lịch sử nhập kho',
            style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
          ),
        ),
        // body: Column(children: [
        //   BlocConsumer<HistoryBloc, HistoryState>(
        //       listener: (context, state) {},
        //       builder: (context, state) {
        //         if (state is TestHistorySuccessState  || 
        //         state is AccessImportHistorySuccessState
        //         // state is AccessExportHistoryByReceiverSuccessState||
        //         // state is AccessExportHistoryByItemIdSuccessState 
        //         ) 

        //         {
        //           return Column(
        //             children: [
        //               Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Text(
        //                   overflow: TextOverflow.ellipsis,
        //                   "Danh sách các lô hàng",
        //                   style: TextStyle(
        //                     fontWeight: FontWeight.w600,
        //                     fontSize: 20 * SizeConfig.ratioFont,
        //                     color: Colors.black,
        //                   ),
        //                 ),
        //               ),
        //               SizedBox(
        //                   height: 500 * SizeConfig.ratioHeight,
        //                   child: ListView.builder(
        //                       // shrinkWrap: true,
        //                       itemCount: state.goodReceiptLots.length,
        //                       itemBuilder: (BuildContext context, int index) {
        //                         return Padding(
        //                             padding: const EdgeInsets.all(8.0),
        //                             child: Container(
        //                               height: 110.0 * SizeConfig.ratioHeight,
        //                               decoration: BoxDecoration(
        //                                 border: Border.all(
        //                                   width: 1,
        //                                 ),
        //                                 borderRadius: BorderRadius.circular(10),
        //                               ),
        //                               child: ListTile(
        //                                   leading: const Icon(Icons.list),
        //                                   // shape: RoundedRectangleBorder(
        //                                   //   side: BorderSide(width: 1),
        //                                   //   borderRadius:
        //                                   //       BorderRadius.circular(10),
        //                                   // ),
        //                                   trailing: Icon(
        //                                       Icons.arrow_drop_down_sharp,
        //                                       size: 15 * SizeConfig.ratioFont),
        //                                   title: Text(
        //                                       "Mã lô : ${state.goodReceiptLots[index].goodsReceiptLotId}"),
        //                                   subtitle: Row(
        //                                     mainAxisAlignment:
        //                                         MainAxisAlignment.spaceBetween,
        //                                     children: [
        //                                       Text(
        //                                           "Tên sản phẩm : ${state.goodReceiptLots[index].goodsReceiptLotId.toString()}  \nSố lượng xuất : ${state.goodReceiptLots[index].quantity.toString()} \nGhi chú : ${state.goodReceiptLots[index].location.toString()}"),
        //                                       Text(
        //                                           "Kho hàng : ${state.goodReceiptLots[index].purchaseOrderNumber.toString()} \nBộ phận : ${state.goodReceiptLots[index].sublotSize.toString()}"),
        //                                     ],
        //                                   ),
        //                                   isThreeLine: true,
        //                                   onTap: () {}),
        //                             ));
        //                       })),
        //               CustomizedButton(
        //                 onPressed: () {
        //                   BlocProvider.of<HistoryBloc>(context)
        //                       .add(GetAllInfoExportEvent(
        //                     DateTime.now(),
        //                   ));
        //                   Navigator.pushNamed(
        //                     context,
        //                     '/export_history_screen',
        //                   );
        //                 },
        //                 text: "Trở lại",
        //               )
        //             ],
        //           );
        //         } else {
        //           print(state);
        //           return const Center(child: CircularProgressIndicator());
        //         }
             // }
              
              );
       // ]));
  }
}
