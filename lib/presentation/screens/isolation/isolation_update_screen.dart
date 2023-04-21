import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/function.dart';
import '../../bloc/blocs/isolation_bloc.dart';
import '../../bloc/states/isolation_states.dart';
import '../../../constant.dart';
import '../../widgets/button_widget.dart';

class UpdateIsolationItemScreen extends StatelessWidget {
  const UpdateIsolationItemScreen({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.mainColor,
        leading: IconButton(
          icon: const Icon(Icons.west_outlined),
          onPressed: () {
            Navigator.pushNamed(context, '/isolation_function_screen');
          },
        ),
        title: Text(
          'Danh sách hàng hóa',
          style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
        ),
      ),
      body: Column(children: [
        Text(
          overflow: TextOverflow.ellipsis,
          "Danh sách hàng đang cách ly",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20 * SizeConfig.ratioFont,
            color: Colors.black,
          ),
        ),
        BlocConsumer<IsolationBloc, IsolationState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetAllIsolationLotSuccessState) {
                return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(children: [
                      const Divider(
                        indent: 30,
                        endIndent: 30,
                        color: Constants.mainColor,
                        thickness: 1,
                      ),
                      Text(
                        overflow: TextOverflow.ellipsis,
                        "Danh sách các lô hàng",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20 * SizeConfig.ratioFont,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                          height: 360 * SizeConfig.ratioHeight,
                          child: ListView.builder(
                              itemCount: state.itemLot.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                       child: Container(
                                    height: 110.0 * SizeConfig.ratioHeight,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ListTile(
                                        leading: const Icon(Icons.list),
                                        // shape: RoundedRectangleBorder(
                                        //   side: BorderSide(width: 1),
                                        //   borderRadius: BorderRadius.circular(10),
                                        // ),
                                        trailing: Icon(
                                            Icons.arrow_drop_down_sharp,
                                            size: 15 * SizeConfig.ratioFont),
                                        title: Text(
                                            "Mã lô : ${state.itemLot[index].lotId}"),
                                        subtitle: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                "Sản phẩm : ${state.itemLot[index].item.itemId.toString()}  \nSố lượng : ${state.itemLot[index].quantity.toString()} \nVị trí : ${state.itemLot[index].location.toString()}"),
                                            Text(
                                                "Số PO : ${state.itemLot[index].purchaseOrderNumber.toString()} \nĐịnh mức : ${state.itemLot[index].sublotSize.toString()}"),
                                          ],
                                        ),
                                        isThreeLine: true,
                                        onTap: () {}),
                                  ),
                                ));
                              }))
                    ]));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 500, 10, 10),
          child: CustomizedButton(
              text: "Trở lại",
              onPressed: () {
                Navigator.pushNamed(context, '/isolation_function_screen');
              }),
        )
      ]),
    );
  }
}
