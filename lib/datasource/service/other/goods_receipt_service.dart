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
        //"employeeId": 'NV01',
        "employeeId": 'NV1',
        "note": goodsReceipt.lots[i].note.toString(),
        // "locationId": goodsReceipt.lots[i].location.toString(),
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
                //"employeeId": 'NV01',
                "employeeId": "NV1",
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

// lấy danh sách phiếu đã hoàn thành
  Future<List<GoodsReceiptModel>> getCompletedGoodsReceipts(
      DateTime startDate, DateTime endDate) async {
    // final start = DateFormat('yyyy-MM-dd').format(startDate);
    // final end = DateFormat('yyyy-MM-dd').format(endDate);
    final res = await http.get(
      Uri.parse(
          '${Constants.baseUrl}/api/GoodsReceipts/TimeRange/true?StartTime=$startDate&EndTime=$endDate'),
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

// lấy danh sách phiếu chưa hoàn thành
  Future<List<GoodsReceiptModel>> getUnCompletedGoodsReceipts() async {
    final res = await http.get(
      Uri.parse('${Constants.baseUrl}api/GoodsReceipts/TimeRange/false'),
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

// cập nhật thông tin lô hàng
  Future<ErrorPackageModel> updateDetailLotReceipt(
      GoodsReceipt goodsReceipt) async {
    List bodyJson = [];
    for (int i = 0; i < goodsReceipt.lots.length; i++) {
      List bodySublot = [];
      for (int j = 0;
          j < goodsReceipt.lots[i].goodsReceiptSublots.length;
          j++) {
        Map<String, dynamic> dimensionSublot = {
          "locationId":
              goodsReceipt.lots[i].goodsReceiptSublots[j].locationId.toString(),
          "quantityPerLocation": double.tryParse(goodsReceipt
              .lots[i].goodsReceiptSublots[j].quantityPerLocation
              .toString()),
        };
        bodySublot.add(dimensionSublot);
      }

      Map<String, dynamic> dimensionJson = {
        "oldGoodsReceiptLotId":
            goodsReceipt.lots[i].goodsReceiptLotId.toString(),
        "newGoodsReceiptLotId":
            goodsReceipt.lots[i].newGoodsReceiptLotId.toString(),
        "itemLotLocations": bodySublot.isNotEmpty ? bodySublot : null,
        "quantity": double.tryParse(goodsReceipt.lots[i].quantity.toString()),
        // "production": production,
        // "expiration" : expiration,
        "productionDate": goodsReceipt.lots[i].productionDate != null
            ? DateFormat('yyyy-MM-dd')
                .format(goodsReceipt.lots[i].productionDate as DateTime)
            : null,
        "expirationDate": goodsReceipt.lots[i].expirationDate != null
            ? DateFormat('yyyy-MM-dd')
                .format(goodsReceipt.lots[i].expirationDate as DateTime)
            : null,
        "note": goodsReceipt.lots[i].note,
      };
      bodyJson.add(dimensionJson);
    }
    String id = goodsReceipt.goodsReceiptId.toString();
    final res = await http.patch(
        Uri.parse(
            '${Constants.baseUrl}api/GoodsReceipts/$id/updatedGoodsReceiptLots'),
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
      return ErrorPackageModel(res.body);
    }
  }

// thêm lô vào phiếu nhập kho
  Future<ErrorPackageModel> patchNewGoodsReceipt(
      GoodsReceipt goodsReceipt) async {
    List bodyJson = [];
    for (int i = goodsReceipt.lots.length - 1;
        i < goodsReceipt.lots.length;
        i++) {
      Map<String, dynamic> dimensionJson = {
        "goodsReceiptLotId": goodsReceipt.lots[i].goodsReceiptLotId.toString(),
        "quantity": double.tryParse(goodsReceipt.lots[i].quantity.toString()),
        "itemId": goodsReceipt.lots[i].item!.itemId.toString(),
        "unit": goodsReceipt.lots[i].unit.toString(),
        // "employeeId": 'NV01',
        "employeeId": "NV1",
        "note": goodsReceipt.lots[i].note.toString(),
        // "locationId": goodsReceipt.lots[i].location.toString(),
      };
      bodyJson.add(dimensionJson);
    }
    String id = goodsReceipt.goodsReceiptId.toString();
    final res = await http.patch(
        Uri.parse(
            '${Constants.baseUrl}api/GoodsReceipts/$id/addedGoodsReceiptLots'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': '*/*',
        },
        body: jsonEncode(bodyJson));
    if (res.statusCode == 200) {
      return ErrorPackageModel("success");
    } else {
      return ErrorPackageModel("fail");
    }
  }

// xóa lô trong trường hợp sai mã sp, đơn vị
  Future<ErrorPackageModel> removeGoodsReceiptLot(
      GoodsReceipt goodsReceipt, GoodsReceiptLot goodsReceiptLot) async {
    String id = goodsReceipt.goodsReceiptId.toString();
    String lotId = goodsReceiptLot.goodsReceiptLotId.toString();
    List<String> lotIds = [lotId];
    if (lotIds.isEmpty) {
      return ErrorPackageModel("fail");
    }
    final res = await http.patch(
        Uri.parse(
            '${Constants.baseUrl}api/GoodsReceipts/$id/removedGoodsReceiptLots'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': '*/*',
        },
        body: jsonEncode(lotIds));

    if (res.statusCode == 200) {
      return ErrorPackageModel("success");
    } else {
      return ErrorPackageModel("fail");
    }
  }
}
