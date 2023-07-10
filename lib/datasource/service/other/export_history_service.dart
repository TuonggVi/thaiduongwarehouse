import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/datasource/models/other/export_history_entry_model.dart';
import 'package:http/http.dart' as http;


class ExportHistoryService {
  Future<List<ExportHistoryEntryModel>> getExportHistoryByPo(
      String poNumber) async {
    final res = await http.get(Uri.parse(
        '${Constants.baseUrl}api/InventoryHistories/ByPO/Export?purchaseOrderNumber=$poNumber'));
    // 'api/stockcardentries/?StartTime=$startDate&EndTime=$endDate'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<ExportHistoryEntryModel> entries = body
          .map(
            (dynamic item) => ExportHistoryEntryModel.fromJson(item),
          )
          .toList();

      return entries;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<List<ExportHistoryEntryModel>> getExportHistoryByReceiver(
      DateTime startDate, DateTime endDate, String receiver) async {
    final start = DateFormat('yyyy-MM-dd').format(startDate);
    final end = DateFormat('yyyy-MM-dd').format(endDate);
    final res = await http.get(Uri.parse(
        '${Constants.baseUrl}api/InventoryHistories/ByReceiver/Export?receiver=$receiver&StartTime=$start&EndTime=$end'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<ExportHistoryEntryModel> entries = body
          .map(
            (dynamic item) => ExportHistoryEntryModel.fromJson(item),
          )
          .toList();

      return entries;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<List<ExportHistoryEntryModel>> getExportHistoryByItem(
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
        '${Constants.baseUrl}api/InventoryHistories/Export?itemClassId=$warehouseId&StartTime=$start&EndTime=$end&itemId=$itemId'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<ExportHistoryEntryModel> entries = body
          .map(
            (dynamic item) => ExportHistoryEntryModel.fromJson(item),
          )
          .toList();
      return entries;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}
