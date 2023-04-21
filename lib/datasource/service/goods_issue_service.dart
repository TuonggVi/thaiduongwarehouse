// ignore_for_file: unused_import

import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_warehouse_thaiduong/datasource/models/error_package_model.dart';
import 'package:mobile_warehouse_thaiduong/datasource/models/goods_issue_model.dart';
import 'package:mobile_warehouse_thaiduong/datasource/models/item_model.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/goods_issue.dart';
import 'package:mobile_warehouse_thaiduong/global.dart';

class GoodsIssueService {
  List bodyJson = [];
  Future<ErrorPackageModel> postNewGoodsIssue(
      String goodsIssueId,
      String purchaseOrderNumber,
      DateTime timestamp,
      String receiver,
      List<GoodsIssueEntry> entries) async {
    final res =
        await http.post(Uri.parse(Constants.baseUrl + 'api/goodsreceipts/'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ',
            },
            body: jsonEncode(
              <String, dynamic>{},
            ));
    if (res.statusCode == 200) {
      return ErrorPackageModel(
        "success",
      );
    } else {
      dynamic body = jsonDecode(res.body);
      ErrorPackageModel error = ErrorPackageModel.fromJson(body);
      return error;
    }
  }

  Future<List<GoodsIssueModel>> getUncompletedGoodsIssue() async {
    final res = await http.get(
      Uri.parse(Constants.baseUrl + 'api/goodsissues/pending'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': '*/*',
        'Authorization': 'Bearer ',
      },
    );

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<GoodsIssueModel> allIssues = body
          .map(
            (dynamic item) => GoodsIssueModel.fromJson(item),
          )
          .toList();
      return allIssues;
    } else {
      throw "Unable to retrieve posts.";
    }
    //return [
      // GoodsIssueModel('đơn 22-03-23', '119203', null, false, 'PKK', [
      //   GoodsIssueEntry(
      //       ItemModel('CDP001', '43111-Card HOLEE','cái', ItemClassModel('TP'), 100, 10),
     
      //       10,
      //       100,
      //       []),
      //       GoodsIssueEntry(
      //      ItemModel('CDP002', '43031-Card ISQUEAK', UnitModel('kg'), ItemClassModel('BTP'), 100, 10),
      //       10,
      //       100,
      //       [])
      // ]),
      // GoodsIssueModel('đơn 15-03-23', null, null, false, 'PKK', [
      //   GoodsIssueEntry(
      //           ItemModel('CDP003ALP2MD00', '190401-Card Fetch ball XL', UnitModel('bộ'), ItemClassModel('NVL'), 100, 10),

      //       10,
      //       100,
      //       [])
      // ]),
      
    //];
  }

  Future<List<GoodsIssueModel>> getCompletedGoodsissue() async {
    // final res = await http.get(
    //   Uri.parse(Constants.baseUrl + 'api/goodsissues/pending'),
    //   headers: {
    //     'Content-Type': 'application/json; charset=UTF-8',
    //     'Accept': '*/*',
    //     'Authorization': 'Bearer ',
    //   },
    // );

    // if (res.statusCode == 200) {
    //   List<dynamic> body = jsonDecode(res.body);

    //   List<GoodsIssueModel> allIssues = body
    //       .map(
    //         (dynamic item) => GoodsIssueModel.fromJson(item),
    //       )
    //       .toList();
    //   return allIssues;
    // } else {
    //   throw "Unable to retrieve posts.";
    // }
     return [
      // GoodsIssueModel('đơn 1', null, null, false, 'PKK', [
      //   GoodsIssueEntry(
      //          ItemModel('XON001', '32439G-Card Zipflight MD', UnitModel('cuộn'), ItemClassModel('BTP'), 100, 10),

      //       10,
      //       100,
      //       [GoodsIssueLotModel('lô a', 50, 10, 'pkk', ''),GoodsIssueLotModel('lô b', 50, 10, 'pkk', '')],),
      //       GoodsIssueEntry(
      //             ItemModel('CDP003ALP2MD01', '0520520G-Card Fetch Mdley Asst 3pk-MD', UnitModel('cái'), ItemClassModel('TP'), 100, 10),

      //       10,
      //       100,
      //       [])
      // ]),
      // GoodsIssueModel('đơn 2', null, null, false, 'PKK', [
      //   GoodsIssueEntry(
      //            ItemModel('CDP0072G0', '46305- Card JW Megalast bone toy LG', UnitModel('met'), ItemClassModel('BB'), 100, 10),

      //       10,
      //       100,
      //       [GoodsIssueLotModel('lô a', 50, 10, 'pkk', ''),GoodsIssueLotModel('lô b', 50, 10, 'pkk', '')])
      // ])
    ];
  }

  Future<GoodsIssueModel> getGoodsIssueById(String goodsIssueId) async {
    final res = await http.get(
        Uri.parse(Constants.baseUrl + 'api/goodsissues/$goodsIssueId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': '*/*',
        });
    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      GoodsIssueModel issue = GoodsIssueModel.fromJson(body);

      return issue;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<ErrorPackageModel> updateGoodsIssueEntry(
      String goodsIssueId, String itemEntryId, double newQuantity) async {
    return ErrorPackageModel(
      "success",
    );
  }

  Future<ErrorPackageModel> addGoodsIssueEntry(
      String goodsIssueId, GoodsIssueEntry goodsIssueEntry) async {
    return ErrorPackageModel(
      "success",
    );
  }

  Future<ErrorPackageModel> updateGoodsIssueLot(
      String goodsIssueId, String goodsIssueLotId, double newQuantity) async {
    return ErrorPackageModel(
      "success",
    );
  }

  Future<ErrorPackageModel> addLotToGoodsIssue(
      String goodsIssueId, List<GoodsIssueLot> lots) async {
    return ErrorPackageModel(
      "success",
    );
  }
  // truy xuat lich su xuat kho
    Future<List<GoodsIssueLot>> getGoodIsssueHistoryByPO(purchaseOrderNumber) async {
      
    return [
      GoodsIssueLot('11', 1, 1,'11', '11'
       ),
       GoodsIssueLot('11', 1, 1,'11', '11'
       ),GoodsIssueLot('11', 1, 1,'11', '11'
       ),GoodsIssueLot('11', 1, 1,'11', '11'
       ),GoodsIssueLot('11', 1, 1,'11', '11'
       ),GoodsIssueLot('11', 1, 1,'11', '11'
       ),GoodsIssueLot('11', 1, 1,'11', '11'
       ), 
    ];
  }
     Future<List<GoodsIssueLot>> getGoodsIssueHistoryBySupplier(purchaseOrderNumber) async {
    return [
      GoodsIssueLot('11', 1, 1,'11', '11'
       ),
       GoodsIssueLot('11', 1, 1,'11', '11'
       ),GoodsIssueLot('11', 1, 1,'11', '11'
       ),GoodsIssueLot('11', 1, 1,'11', '11'
       ),GoodsIssueLot('11', 1, 1,'11', '11'
       ),GoodsIssueLot('11', 1, 1,'11', '11'
       ),GoodsIssueLot('11', 1, 1,'11', '11'
       ), 
    ];
  }
  Future<List<GoodsIssueLot>> getGoodsIssueHistoryByItemId(itemId) async {
    return [
      GoodsIssueLot('11', 1, 1,'11', '11'
       ),
       GoodsIssueLot('11', 1, 1,'11', '11'
       ),GoodsIssueLot('11', 1, 1,'11', '11'
       ),GoodsIssueLot('11', 1, 1,'11', '11'
       ),GoodsIssueLot('11', 1, 1,'11', '11'
       ),GoodsIssueLot('11', 1, 1,'11', '11'
       ),GoodsIssueLot('11', 1, 1,'11', '11'
       ), 
    ];
  }
}