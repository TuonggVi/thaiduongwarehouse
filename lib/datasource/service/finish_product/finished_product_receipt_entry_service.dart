import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';

import 'package:http/http.dart' as http;

import '../../models/finish_product/finished_product_receipt_entry_model.dart';

class FinishedProductReceiptEntryService {
  Future<List<FinishedProductReceiptEntryModel>> getFinishedProductReceiptEntryByPo(
      String purchaseOrderNumber, String finishedProductIssueId) async {
    final res = await http.get(Uri.parse(
        '${Constants.baseUrl}api/InventoryHistories/ByPO/Import?purchaseOrderNumber=$purchaseOrderNumber&finishedProductIssueId=$finishedProductIssueId'));
    // 'api/stockcardentries/?StartTime=$startDate&EndTime=$endDate'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<FinishedProductReceiptEntryModel> entries = body
          .map(
            (dynamic item) => FinishedProductReceiptEntryModel.fromJson(item),
          )
          .toList();

      return entries;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<List<FinishedProductReceiptEntryModel>> getFinishedProductReceiptEntryBySupplier(
      DateTime startDate, DateTime endDate, String supplier) async {
    final start = DateFormat('yyyy-MM-dd').format(startDate);
    final end = DateFormat('yyyy-MM-dd').format(endDate);
    final res = await http.get(Uri.parse(
        '${Constants.baseUrl}api/InventoryHistories/BySupplier/Import?supplier=$supplier&StartTime=$start&EndTime=$end'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<FinishedProductReceiptEntryModel> entries = body
          .map(
            (dynamic item) => FinishedProductReceiptEntryModel.fromJson(item),
          )
          .toList();

      return entries;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<List<FinishedProductReceiptEntryModel>> getFinishedProductReceiptEntryByItem(
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
      List<FinishedProductReceiptEntryModel> entries = body
          .map(
            (dynamic item) => FinishedProductReceiptEntryModel.fromJson(item),
          )
          .toList();

      return entries;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}
