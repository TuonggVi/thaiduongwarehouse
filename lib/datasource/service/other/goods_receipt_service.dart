import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:mobile_warehouse_thaiduong/datasource/models/error_package_model.dart';
import 'package:mobile_warehouse_thaiduong/datasource/models/other/goods_receipt_model.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/goods_receipt.dart';
import 'package:http/http.dart' as http;

import '../../../constant.dart';

class GoodsReceiptService {
  // Future<ErrorPackageModel> postNewGoodsReceipt(
  //     String goodsReceiptId, List<GoodsReceiptLot> lots) async {
  //   return ErrorPackageModel('success');
  // }

  Future<ErrorPackageModel> postNewGoodsReceipt(
      GoodsReceipt goodsReceipt) async {
    List bodyJson = [];
    for (int i = 0; i < goodsReceipt.lots.length; i++) {
      Map<String, dynamic> dimensionJson = {
        "goodsReceiptLotId": goodsReceipt.lots[i].goodsReceiptLotId.toString(),
        "quantity": double.tryParse(goodsReceipt.lots[i].quantity.toString()),
        "unit": goodsReceipt.lots[i].unit.toString(),
        "itemId": goodsReceipt.lots[i].item!.itemId.toString(),
        "purchaseOrderNumber":
            goodsReceipt.lots[i].purchaseOrderNumber.toString(),
        "employeeId": 'NV01',
        "note": goodsReceipt.lots[i].note.toString(),
        // "locationId": goodsReceipt.lots[i].location.toString(),
        "sublotSize":
            double.tryParse(goodsReceipt.lots[i].sublotSize.toString()),
        "sublotUnit": "",

    
      };
      bodyJson.add(dimensionJson);
    }
    final res =
        await http.post(Uri.parse('${Constants.baseUrl}api/GoodsReceipts'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Accept': '*/*',
            },
            body: jsonEncode(
              <String, dynamic>{
                "goodsReceiptId": goodsReceipt.goodsReceiptId,
                "timestamp": DateFormat('yyyy-MM-dd').format(DateTime.now()),
                "supplier": goodsReceipt.supply,
                "employeeId": "NV01",
                "goodsReceiptLots": bodyJson
                //  [
                //   {
                //     "goodsReceiptLotId": "lo1_0003",
                //     "quantity": 5,
                //     "unit": "KG",
                //     "itemId": "610-6C",
                //     "purchaseOrderNumber": "121212",
                //     "employeeId": "NV01",
                //     "note": "meomeo",
                //     "locationId": null,
                //     "sublotSize": 5,
                //     "productionDate": null,
                //     "expirationDate": "2023-12-22",
                //   }
                // ]
              },
            ));
    if (res.statusCode == 200) {
      return ErrorPackageModel("success");
    } else {
      return ErrorPackageModel("fail");
    }
  }


  Future<List<GoodsReceiptModel>> getCompletedGoodsReceipts(
      DateTime startDate, DateTime endDate) async {
    final start = DateFormat('yyyy-MM-dd').format(startDate);
    final end = DateFormat('yyyy-MM-dd').format(endDate);
    final res = await http.get(
      Uri.parse(
          '${Constants.baseUrl}api/GoodsReceipts/TimeRange?startTime=$start&endTime=$end'),
      // headers: {
      //   'Content-Type': 'application/json; charset=UTF-8',
      //   'Accept': '*/*',
      //   'Authorization': 'Bearer ',
      // },
    );

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<GoodsReceiptModel> allIssues = body
          .map(
            (dynamic item) => GoodsReceiptModel.fromJson(item),
          )
          .toList();
      return allIssues;
    }
    if (res.statusCode == 204) {
      return [];
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<List<GoodsReceiptModel>> getUnCompletedGoodsReceipts() async {
    final res = await http.get(
      Uri.parse('${Constants.baseUrl}api/GoodsReceipts/goodsReceipts/false'),
      // headers: {
      //   'Content-Type': 'application/json; charset=UTF-8',
      //   'Accept': '*/*',
      //   'Authorization': 'Bearer ',
      // },
    );

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<GoodsReceiptModel> allIssues = body
          .map(
            (dynamic item) => GoodsReceiptModel.fromJson(item),
          )
          .toList();
      return allIssues;
    }
    if (res.statusCode == 204) {
      return [];
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<ErrorPackageModel> updateDetailLotReceipt(GoodsReceipt goodsReceipt) async {
    List bodyJson = [];
    for (int i = 0; i < goodsReceipt.lots.length; i++) {
     final production = DateFormat('yyyy-MM-dd').format(goodsReceipt.lots[i].productionDate as DateTime);
    final expiration = DateFormat('yyyy-MM-dd').format(goodsReceipt.lots[i].expirationDate as DateTime);
      Map<String, dynamic> dimensionJson = {
          "oldGoodsReceiptLotId": goodsReceipt.lots[i].goodsReceiptLotId.toString(), 
   // "newGoodsReceiptLotId": goodsReceipt.lots[i].goodsReceiptLotId.toString(),
    "itemLotLocations": [ 
      { 
        "locationId": goodsReceipt.lots[i].location.toString(),
        "quantityPerLocation":  double.tryParse(goodsReceipt.lots[i].sublotSize.toString()), 
      } 
    ], 
    "quantity": double.tryParse(goodsReceipt.lots[i].quantity.toString()),
    "productionDate": production,
    "expirationDate": expiration,
    "note":goodsReceipt.lots[i].note.toString(),
      //   "goodsReceiptLotId": goodsReceipt.lots[i].goodsReceiptLotId.toString(),
      //   "locationId": goodsReceipt.lots[i].location.toString(),
      //   "quantity": double.tryParse(goodsReceipt.lots[i].quantity.toString()),
      //   "sublotSize":
      //       double.tryParse(goodsReceipt.lots[i].sublotSize.toString()),
      //  "sublotUnit": "string",
      //   "purchaseOrderNumber": goodsReceipt.lots[i].purchaseOrderNumber.toString(),
      //   "productionDate": production,
      //   "expirationDate": expiration,
      //   "note": goodsReceipt.lots[i].note.toString(),
        // "locationId": "NVL_Location_1",
        // "quantity": 10.0,
        // "sublotSize": 2.0,
        // "sublotUnit": "string",
        // "purchaseOrderNumber": "123456",
        // "productionDate": "2023-05-09T06:07:30.38",
        // "expirationDate": "2024-05-09T06:07:30.38",
        // "note": " "
      };
      bodyJson.add(dimensionJson);
    }
    final res = await http.patch(
        Uri.parse(
            '${Constants.baseUrl}api/GoodsReceipts/api/GoodsReceipts/goodsReceiptId/addedGoodsReceiptLots'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': '*/*',
        },
        body: jsonEncode(bodyJson));
    if (res.statusCode == 200) {
      return ErrorPackageModel(
        "success",
      );
    } else {
      return ErrorPackageModel("fail");
    }
  }
   Future<ErrorPackageModel> patchNewReceiptLot(GoodsReceipt goodsReceipt) async {
    List bodyJson = [];
    for (int i = 0; i < goodsReceipt.lots.length; i++) {
      final production = DateFormat('yyyy-MM-dd').format(goodsReceipt.lots[i].productionDate as DateTime);
    final expiration = DateFormat('yyyy-MM-dd').format(goodsReceipt.lots[i].expirationDate as DateTime);
      Map<String, dynamic> dimensionJson = {
    "oldGoodsReceiptLotId": goodsReceipt.lots[i].goodsReceiptLotId.toString(), 
   // "newGoodsReceiptLotId": goodsReceipt.lots[i].goodsReceiptLotId.toString(),
    "itemLotLocations": [ 
      { 
        "locationId": goodsReceipt.lots[i].location.toString(),
        "quantityPerLocation":  double.tryParse(goodsReceipt.lots[i].sublotSize.toString()), 
      } 
    ], 
    "quantity": double.tryParse(goodsReceipt.lots[i].quantity.toString()),
    "productionDate": production,
    "expirationDate": expiration,
    "note":goodsReceipt.lots[i].note.toString(),
        // "goodsReceiptLotId": goodsReceipt.lots[i].goodsReceiptLotId.toString(),
        // "locationId": goodsReceipt.lots[i].location.toString(),
        // "quantity": double.tryParse(goodsReceipt.lots[i].quantity.toString()),
        // "sublotSize":
        //     double.tryParse(goodsReceipt.lots[i].sublotSize.toString()),
        // "sublotUnit": "string",
        // "purchaseOrderNumber": goodsReceipt.lots[i].purchaseOrderNumber.toString(),
        // "productionDate": production,
        // "expirationDate": expiration,
        // "note": goodsReceipt.lots[i].note.toString(),
        // "locationId": "NVL_Location_1",
        // "quantity": 10.0,
        // "sublotSize": 2.0,
        // "sublotUnit": "string",
        // "purchaseOrderNumber": "123456",
        // "productionDate": "2023-05-09T06:07:30.38",
        // "expirationDate": "2024-05-09T06:07:30.38",
        // "note": " "
      };
      bodyJson.add(dimensionJson);
    }
    final res = await http.patch(
        Uri.parse(
            '${Constants.baseUrl}api/GoodsReceipts/goodsReceiptId/addedGoodsReceiptLots'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': '*/*',
        },
        body: jsonEncode(bodyJson));
    if (res.statusCode == 200) {
      return ErrorPackageModel(
        "success",
      );
    } else {
      return ErrorPackageModel("fail");
    }
  }
}
