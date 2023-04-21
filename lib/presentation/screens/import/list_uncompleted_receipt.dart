import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/receipt_bloc/uncompleted_receipt_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/receipt_bloc/uncompleted_receipt_lot_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/receipt_state/uncomplted_receipt_state.dart';
import '../../../function.dart';
import '../../bloc/events/receipt_event/uncompleted_receipt_lot_event.dart';
import '../../widgets/exception_widget.dart';

class ListUncompletedGoodReceiptScreen extends StatelessWidget {
  const ListUncompletedGoodReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
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
              overflow: TextOverflow.ellipsis,
              "Danh sách các đơn nhập",
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
                  return SizedBox(
                     height: 300 * SizeConfig.ratioHeight,
                    child: ListView.builder(
                        itemCount: state.receipts.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                              leading: const Icon(Icons.list),
                              trailing:  Icon(Icons.arrow_drop_down_sharp, size:15*SizeConfig.ratioFont),
                              title: Text(state.receipts[index].goodsReceiptId),
                                subtitle: Text(state.receipts[index].timestamp.toString()),
                            onTap: () {
                              BlocProvider.of<ExportingReceiptLotBloc>(context)
                                  .add(LoadUncompletedReceiptLotEvent( DateTime.now(), state.receipts[index]));
                                   Navigator.pushNamed(context, '/importing_receipt_lot_screen');

                            },);
                        }),
                  );
                }
                if (state is LoadReceiptExportingStateFail) {
                  return ExceptionErrorState(
                    title: state.detail,
                    message: "Vui lòng quay lại sau",
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}