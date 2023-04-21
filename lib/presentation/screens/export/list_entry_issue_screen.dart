import 'package:flutter/material.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/presentation/screens/export/list_lot_issue_screen.dart';
import '../../../function.dart';

class ListGoodIssueEntryScreen extends StatelessWidget {
  const ListGoodIssueEntryScreen({super.key});

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
             Navigator.pushNamed(context, '/export_main_screen');
            },
          ),
        backgroundColor: Constants.mainColor,
        title: Text(
          'Danh sách hàng hóa cần xuất',
          style: TextStyle(fontSize: 22 * SizeConfig.ratioFont),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          height: 470 * SizeConfig.ratioHeight,
          child: ListView.builder(
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const ListLotIssueScreen()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Constants.buttonColor.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 2,
                            // ignore: prefer_const_constructors
                            offset: Offset(4, 8), // changes position of shadow
                          ),
                        ],
                      ),
                      width: 300 * SizeConfig.ratioWidth,
                      height: 80 * SizeConfig.ratioHeight,
                      // color: Constants.buttonColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            overflow: TextOverflow.ellipsis,
                            "Tên SP",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 28 * SizeConfig.ratioFont,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            overflow: TextOverflow.ellipsis,
                            "SL yêu cầu",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18 * SizeConfig.ratioFont,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            overflow: TextOverflow.ellipsis,
                            "SL đã xuất",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18 * SizeConfig.ratioFont,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}