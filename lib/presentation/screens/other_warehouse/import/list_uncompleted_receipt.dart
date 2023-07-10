import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/receipt_bloc/uncompleted_receipt_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/receipt_bloc/uncompleted_receipt_lot_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/other/receipt_state/uncomplted_receipt_state.dart';
import '../../../../function.dart';
import '../../../bloc/events/other/receipt_event/uncompleted_receipt_lot_event.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/exception_widget.dart';
// danh sách phiếu chưa hoàn thành
class ListUncompletedGoodReceiptScreen extends StatelessWidget {
  const ListUncompletedGoodReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
       onWillPop: () async {
        Navigator.pushNamed(context, "/main_receipt_screen");
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.west, //mũi tên back
              color: Colors.white,
            ),
            onPressed: () {
              
              Navigator.pushNamed(context, '/main_receipt_screen');
            },
          ),
          backgroundColor: Constants.mainColor,
          title: Text(
            'Danh sách phiếu chưa hoàn thành',
            style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: 10 * SizeConfig.ratioHeight,
              ),
              Text(
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                "Danh sách các phiếu nhập \n chưa hoàn thành",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 25 * SizeConfig.ratioFont,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: ((value) {}),
                  controller: TextEditingController(),
                  decoration: const InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              BlocBuilder<ExportingReceiptBloc, ReceiptExportingState>(
                builder: (context, state) {
                  if (state is LoadReceiptExportingStateSuccess) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 400 * SizeConfig.ratioHeight,
                          child: ListView.builder(
                              itemCount: state.receipts.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                     decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                    child: ListTile(
                                      // shape: RoundedRectangleBorder(
                                      //   side: BorderSide(width: 1),
                                      //   borderRadius: BorderRadius.circular(10),
                                      // ),
                                      leading:  Icon(Icons.list),
                                      trailing: Icon(Icons.arrow_drop_down_sharp,
                                          size: 15 * SizeConfig.ratioFont),
                                      title: Text(
                                          "Mã đơn : ${state.receipts[index].goodsReceiptId}"),
                                      subtitle: Text(
                                          "NCC : ${state.receipts[index].supply.toString()}  \nNgày tạo : ${state.receipts[index].timestamp.toString()}"),
                                          // load danh sách lô nhập kho có trong phiếu sang giao diện mới
                                          // nhấn vào phiếu => hiển thị ds lô ở giao diện lô chưa hoàn thành
                                      onTap: () {
                                        BlocProvider.of<ExportingReceiptLotBloc>(
                                                context)
                                            .add(LoadUncompletedReceiptLotEvent(
                                                DateTime.now(), state.receipts[index]));
                                        Navigator.pushNamed(
                                            context, '/importing_receipt_lot_screen');
                                      },
                                    ),
                                  ),
                                );
                              }),
                        ),
                         CustomizedButton(
                              text: "Trở lại",
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/main_receipt_screen');
                              })
                      ],
                    );
                  }
                  if (state is LoadReceiptExportingStateFail) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          ExceptionErrorState(
                            title: state.detail,
                            message: "Vui lòng quay lại sau",
                          ),
                          CustomizedButton(
                              text: "Trở lại",
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/main_receipt_screen');
                              })
                        ],
                      ),
                    );
                  } else {
                    return SingleChildScrollView(
                        child: Column(
                      //   mainAxisAlignment: MainAxisAlignment.,
                      children: [
                        SizedBox(
                          height: 200 * SizeConfig.ratioHeight,
                        ),
                        const CircularProgressIndicator(),
                        SizedBox(
                          height: 150 * SizeConfig.ratioHeight,
                        ),
                        CustomizedButton(
                            text: "Trở lại",
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/main_receipt_screen');
                            })
                      ],
                    ));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
