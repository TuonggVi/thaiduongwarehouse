import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/datasource/models/other/import_history_entry_model.dart';
import 'package:http/http.dart' as http;

import '../../../domain/entities/other/goods_receipt.dart';
import '../../models/error_package_model.dart';

class ImportHistoryService {
  Future<List<ImportHistoryEntryModel>> getImportHistoryByPo(
      String poNumber) async {
    final res = await http.get(Uri.parse(
        '${Constants.baseUrl}api/InventoryHistories/ByPO/Import?purchaseOrderNumber=$poNumber'));
    // 'api/stockcardentries/?StartTime=$startDate&EndTime=$endDate'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<ImportHistoryEntryModel> entries = body
          .map(
            (dynamic item) => ImportHistoryEntryModel.fromJson(item),
          )
          .toList();

      return entries;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<List<ImportHistoryEntryModel>> getImportHistoryBySupplier(
      DateTime startDate, DateTime endDate, String supplier) async {
    final start = DateFormat('yyyy-MM-dd').format(startDate);
    final end = DateFormat('yyyy-MM-dd').format(endDate);
    final res = await http.get(Uri.parse(
        '${Constants.baseUrl}api/InventoryHistories/BySupplier/Import?supplier=$supplier&StartTime=$start&EndTime=$end'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<ImportHistoryEntryModel> entries = body
          .map(
            (dynamic item) => ImportHistoryEntryModel.fromJson(item),
          )
          .toList();

      return entries;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
  Future<ErrorPackageModel> postAddNewGoodsReceipt(
      GoodsReceipt goodsReceipt) async {
       
    List bodyJson = [];
    for (int i = 0; i < goodsReceipt.lots.length; i++) {
      Map<String, dynamic> dimensionJson = {
        "goodsReceiptLotId": goodsReceipt.lots[i].goodsReceiptLotId.toString(),
        "quantity": double.tryParse(goodsReceipt.lots[i].quantity.toString()),
        "unit": goodsReceipt.lots[i].unit.toString(),
        "itemId": goodsReceipt.lots[i].item!.itemId.toString(),
        //"employeeId": "NV01",
        "employeeId": 'NV1',
        "note": goodsReceipt.lots[i].note.toString(),
        // "locationId": goodsReceipt.lots[i].location.toString(),
   
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
               // "employeeId": "NV01",
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
  Future<List<ImportHistoryEntryModel>> getImportHistoryByItem(
      DateTime startDate,
      DateTime endDate,
      String itemId,
      String warehouseId) async {
    final start = DateFormat('yyyy-MM-dd').format(startDate);
    final end = DateFormat('yyyy-MM-dd').format(endDate);

    if (itemId != '') {
      warehouseId = '';
    }
    final res = await http.get(Uri.parse(
        '${Constants.baseUrl}api/InventoryHistories/Import?itemClassId=$warehouseId&StartTime=$start&EndTime=$end&itemId=$itemId'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<ImportHistoryEntryModel> entries = body
          .map(
            (dynamic item) => ImportHistoryEntryModel.fromJson(item),
          )
          .toList();

      return entries;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}
