// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/inventory_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/other/inventory_states.dart';
import '../../../../constant.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/exception_widget.dart';

// quét qr, chuyển sang trang báo cáo tồn kho cho sản phẩm được quét thành công
class ReportInventoryScreen extends StatefulWidget {
  const ReportInventoryScreen({super.key});

  @override
  State<ReportInventoryScreen> createState() => _ReportInventoryScreenState();
}

class _ReportInventoryScreenState extends State<ReportInventoryScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, "/scan_item_screen");
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Constants.mainColor,
            leading: IconButton(
              icon: const Icon(Icons.west_outlined),
              onPressed: () {
                Navigator.pushNamed(context, '/scan_item_screen');
              },
            ),
            title: Text(
              'Tồn kho',
              style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              BlocConsumer<InventoryBloc, InventoryState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is LoadReportInventoryLotSuccessState) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 540 * SizeConfig.ratioHeight,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      "Báo cáo tồn kho",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20 * SizeConfig.ratioFont,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: DataTable(
                                        columns: const [
                                          DataColumn(label: Text('Tên hàng')),
                                          DataColumn(label: Text('ĐVT')),
                                          DataColumn(label: Text('Tồn kho')),
                                        ],
                                        rows: <DataRow>[
                                          DataRow(
                                            cells: <DataCell>[
                                              DataCell(Text(state
                                                  .itemLots[0].item!.itemName
                                                  .toString())),
                                              DataCell(Text(state
                                                  .itemLots[0].item!.unit
                                                  .toString())),
                                              DataCell(Text(state.totalQuantity
                                                  .toString())),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: DataTable(
                                        columns: const [
                                          DataColumn(label: Text('Lô')),
                                          DataColumn(label: Text('Tồn kho')),
                                          DataColumn(label: Text('Vị trí')),
                                          DataColumn(label: Text('Số lượng')),
                                        ],
                                        rows: state.itemLots.expand((element) {
                                          // Create the first row with lotId and quantity
                                          DataRow firstRow = DataRow(cells: [
                                            DataCell(
                                                Text(element.lotId.toString())),
                                            DataCell(Text(
                                                element.quantity.toString())),
                                            DataCell(Text(
                                                element.itemLotSubLot.isNotEmpty
                                                    ? element.itemLotSubLot[0]
                                                        .locationId
                                                        .toString()
                                                    : 'Chưa cập nhật')),
                                            DataCell(Text(
                                                element.itemLotSubLot.isNotEmpty
                                                    ? element.itemLotSubLot[0]
                                                        .quantityPerLocation
                                                        .toString()
                                                    : 'Chưa cập nhật')),
                                          ]);
                                          // Create a DataRow for each cặp vị trí và số lượng
                                          List<DataRow> subRows = [];
                                          for (int i = 1;
                                              i < element.itemLotSubLot.length;
                                              i++) {
                                            var subLot =
                                                element.itemLotSubLot[i];
                                            subRows.add(DataRow(
                                              cells: [
                                                DataCell(Text('')),
                                                DataCell(Text('')),
                                                DataCell(Text(subLot.locationId
                                                    .toString())),
                                                DataCell(Text(subLot
                                                    .quantityPerLocation
                                                    .toString())),
                                              ],
                                            ));
                                          }

                                          // Combine the first row and subRows into a single list of rows
                                          List<DataRow> rows = [
                                            firstRow,
                                            ...subRows
                                          ];

                                          return rows;
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          CustomizedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/scan_item_screen',
                              );
                            },
                            text: "Trở lại",
                          )
                        ],
                      );
                    }
                    if (state is LoadReportInventoryLotFailState) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Center(
                              child: ExceptionErrorState(
                                title: 'Danh sách đang rỗng',
                                message: "Vui lòng thử lại sau",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 240, 0, 0),
                              child: CustomizedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/scan_item_screen',
                                  );
                                },
                                text: "Trở lại",
                              ),
                            )
                          ],
                        ),
                      );
                    }
                    if (state is LoadReportInventoryLotLoadingState) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Center(
                              child: ExceptionErrorState(
                                icon: Icons.wifi_protected_setup_sharp,
                                title: 'Loading',
                                message: "Vui lòng đợi....",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 240, 0, 0),
                              child: CustomizedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/scan_item_screen',
                                  );
                                },
                                text: "Trở lại",
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Center(
                              child: ExceptionErrorState(
                                title: 'Lỗi hệ thống',
                                message: "Vui lòng thử lại sau",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 240, 0, 0),
                              child: CustomizedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/scan_item_screen',
                                  );
                                },
                                text: "Trở lại",
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  })
            ]),
          )),
    );
  }
}
