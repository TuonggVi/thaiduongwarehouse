import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/blocs/other/history_bloc/import_history_bloc.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/other/history_state/import_history_state.dart';
import '../../../../constant.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/exception_widget.dart';

class ImportHistoryEntryScreen extends StatefulWidget {
  const ImportHistoryEntryScreen({super.key});

  @override
  State<ImportHistoryEntryScreen> createState() =>
      _ImportHistoryEntryScreenState();
}

class _ImportHistoryEntryScreenState extends State<ImportHistoryEntryScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, "/import_history_screen");
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Constants.mainColor,
            leading: IconButton(
              icon: const Icon(Icons.west_outlined),
              onPressed: () {
                Navigator.pushNamed(context, '/import_history_screen');
              },
            ),
            title: Text(
              'Lịch sử nhập kho',
              style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
            ),
          ),
          body: Column(children: [
            BlocConsumer<ImportHistoryBloc, ImportHistoryState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is AccessImportHistorySuccessState) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            "Lịch sử nhập kho",
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
                          
                              child:  DataTable(
                                columns: const [
                                  DataColumn(label: Text('NCC')),
                                  DataColumn(label: Text('Mã lô')),
                                  DataColumn(label: Text('SP')),
                                  DataColumn(label: Text('SL')),
                           
                                ],
                                rows: state
                                    .importHistoryEntries // Loops through dataColumnText, each iteration assigning the value to element
                                    .map(
                                      ((element) => DataRow(
                                            cells: <DataCell>[
                                              DataCell(Text(element.supplier
                                                  .toString())), //Extracting from Map element the value
                                              DataCell(
                                                  Text(element.goodsReceiptLotId.toString())),
                                              DataCell(
                                                  Text(element.itemName.toString())),
                                                   DataCell(
                                                  Text(element.quantity.toString())),
                              
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
                              '/import_history_screen',
                            );
                          },
                          text: "Trở lại",
                        )
                      ],
                    );
                  }
                  if (state is AccessImportHistoryFailState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: ExceptionErrorState(
                            title: state.status.detail,
                            message: "Vui lòng thử lại sau",
                          ),
                        ),
                        CustomizedButton(
                        onPressed: () {
                       
                          Navigator.pushNamed(
                            context,
                            '/import_history_screen',
                          );
                        },
                        text: "Trở lại",
                      )
                      ],
                    );
                  }
                  if (state is AccessImportHistoryLoadingState) {
                  return   Dialog(
                        // The background color
                        backgroundColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children:const [
                              // The loading indicator
                              CircularProgressIndicator(),
                              SizedBox(
                                height: 15,
                              ),
                              // Some text
                              Text('Loading...')
                            ],
                          ),
                        ),
                      );
                  } else {
                    return Center(
    
                      child: 
                        ExceptionErrorState(
                          title: 'Lỗi hệ thống',
                          message: "Vui lòng thử lại sau",
                        ),
                      //   CustomizedButton(
                      //   onPressed: () {
                        
                      //     Navigator.pushNamed(
                      //       context,
                      //       '/import_history_screen',
                      //     );
                      //   },
                      //   text: "Trở lại",
                      // )
                      
                    );
                  }
                })
          ])),
    );
  }
}
