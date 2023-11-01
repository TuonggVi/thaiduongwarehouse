import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import '../../../../constant.dart';
import '../../../bloc/blocs/other/inventory_bloc.dart';
import '../../../bloc/states/other/inventory_states.dart';
import '../../../widgets/button_widget.dart';
// hiển thị lịch sử xuất nhập tồn từ kho hàng, mã sp, thời gian.
class ListInventoryScreen extends StatefulWidget {
  const ListInventoryScreen({super.key});

  @override
  State<ListInventoryScreen> createState() => _ListInventoryScreenState();
}

class _ListInventoryScreenState extends State<ListInventoryScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, "/inventory_screen");
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Constants.mainColor,
            leading: IconButton(
              icon: const Icon(Icons.west_outlined),
              onPressed: () {
                Navigator.pushNamed(context, '/inventory_screen');
              },
            ),
            title: Text(
              'Danh sách lô hàng',
              style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
            ),
          ),
          body: Column(children: [
            BlocConsumer<InventoryBloc, InventoryState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is LoadInventorySuccessState
                      //   ||state is LoadInventorySuccessState
                      // state is AccessExportHistoryByReceiverSuccessState||
                      // state is AccessExportHistoryByItemIdSuccessState
                      ) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            "Lịch sử xuất nhập tồn",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20 * SizeConfig.ratioFont,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 500 * SizeConfig.ratioHeight,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: DataTable(
                                columns: const [
                                  DataColumn(label: Text('Thời gian')),
                                  DataColumn(label: Text('Mã lô')),
                                  DataColumn(label: Text('SL Nhập')),
                                  DataColumn(label: Text('SL Xuất')),
                                  DataColumn(label: Text('Vị trí')),
                                ],
                                rows: state
                                    .itemLots // Loops through dataColumnText, each iteration assigning the value to element
                                    .map(
                                      ((element) => DataRow(
                                            cells: <DataCell>[
                                              DataCell(Text(DateFormat(
                                                      'yyyy-MM-dd')
                                                  .format(element
                                                      .timestamp))), //Extracting from Map element the value
                                              DataCell(Text(
                                                  element.itemLot.toString())),
                                              DataCell(Text(
                                                  element.changedQuantity < 0
                                                      ? "0"
                                                      : element.changedQuantity
                                                          .toString())),
                                              DataCell(Text(
                                                  element.changedQuantity > 0
                                                      ? "0"
                                                      : (
                                                          0 -
                                                              element
                                                                  .changedQuantity
                                                                  
                                              ).toString())),
                                                     DataCell(Text(
                                                  element.toString())),
                                            ],
                                          )),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        ),
                        
                        CustomizedButton(
                          onPressed: () {
                            // BlocProvider.of<HistoryBloc>(context)
                            //     .add(GetAllInfoImportEvent(
                            //   DateTime.now(),
                            // ));
                            Navigator.pushNamed(
                              context,
                              '/stockcard_function_screen',
                            );
                          },
                          text: "Trở lại",
                        )
                      ],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                })
          ])),
    );
  }
}
