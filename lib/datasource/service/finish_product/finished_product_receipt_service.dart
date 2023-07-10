import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:mobile_warehouse_thaiduong/datasource/models/error_package_model.dart';
import 'package:http/http.dart' as http;

import '../../../constant.dart';
import '../../../domain/entities/finish_product/finished_product_receipt.dart';
import '../../models/finish_product/finished_product_receipt_model.dart';

class FinishedProductReceiptService {
  Future<ErrorPackageModel> postFinishedProductReceipt(
      FinishedProductReceipt finishedProductReceipt) async {
    List bodyJson = [];
    for (int i = 0; i < finishedProductReceipt.entries.length; i++) {
      Map<String, dynamic> dimensionJson = {
        "FinishedProductReceiptLotId": finishedProductReceipt.entries[i].toString(),
        "quantity": double.tryParse(finishedProductReceipt.entries[i].quantity.toString()),
        "unit": finishedProductReceipt.entries[i].toString(),
        "itemId": finishedProductReceipt.entries[i].item.itemId.toString(),
        "purchaseOrderNumber":
            finishedProductReceipt.entries[i].purchaseOrderNumber.toString(),
        "employeeId": 'NV01',
        "note": finishedProductReceipt.entries[i].note.toString(),
        // "locationId": FinishedProductReceipt.lots[i].location.toString(),
        "sublotSize":
            double.tryParse(finishedProductReceipt.entries[i].toString()),
        "sublotUnit": "",
      };
      bodyJson.add(dimensionJson);
    }
    final res =
        await http.post(Uri.parse('${Constants.baseUrl}api/FinishedProductReceipts'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Accept': '*/*',
            },
            body: jsonEncode(
              <String, dynamic>{
                "FinishedProductReceiptId": finishedProductReceipt.finishedProductReceiptId,
                "timestamp": DateFormat('yyyy-MM-dd').format(DateTime.now()),        
                "employeeId": "NV01",
                "FinishedProductReceiptLots": bodyJson
                //  [
                //   {
                //     "FinishedProductReceiptLotId": "lo1_0003",
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

  Future<List<FinishedProductReceiptModel>> getCompletedFinishedProductReceipts(
      DateTime startDate, DateTime endDate) async {
    final start = DateFormat('yyyy-MM-dd').format(startDate);
    final end = DateFormat('yyyy-MM-dd').format(endDate);
    final res = await http.get(
      Uri.parse(
          '${Constants.baseUrl}api/FinishedProductReceipts/TimeRange?startTime=$start&endTime=$end'),
      // headers: {
      //   'Content-Type': 'application/json; charset=UTF-8',
      //   'Accept': '*/*',
      //   'Authorization': 'Bearer ',
      // },
    );

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<FinishedProductReceiptModel> allIssues = body
          .map(
            (dynamic item) => FinishedProductReceiptModel.fromJson(item),
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

  Future<List<FinishedProductReceiptModel>> getUnCompletedFinishedProductReceipts() async {
    final res = await http.get(
      Uri.parse('${Constants.baseUrl}api/FinishedProductReceipts/FinishedProductReceipts/false'),
      // headers: {
      //   'Content-Type': 'application/json; charset=UTF-8',
      //   'Accept': '*/*',
      //   'Authorization': 'Bearer ',
      // },
    );

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<FinishedProductReceiptModel> allIssues = body
          .map(
            (dynamic item) => FinishedProductReceiptModel.fromJson(item),
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

  Future<ErrorPackageModel> update(FinishedProductReceipt FinishedProductReceipt) async {
    List bodyJson = [];
    for (int i = 0; i < FinishedProductReceipt.entries.length; i++) {
      Map<String, dynamic> dimensionJson = {
        "FinishedProductReceiptLotId": FinishedProductReceipt.entries[i]..toString(),
        "locationId": FinishedProductReceipt.entries[i].toString(),
        "quantity": double.tryParse(FinishedProductReceipt.entries[i].quantity.toString()),
        "sublotSize":
            double.tryParse(FinishedProductReceipt.entries[i].toString()),
        "sublotUnit": "string",
        "purchaseOrderNumber": FinishedProductReceipt.entries[i].purchaseOrderNumber.toString(),
        "note": FinishedProductReceipt.entries[i].note.toString(),
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
            '${Constants.baseUrl}api/FinishedProductReceipts/${FinishedProductReceipt.finishedProductReceiptId.toString()}'),
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
