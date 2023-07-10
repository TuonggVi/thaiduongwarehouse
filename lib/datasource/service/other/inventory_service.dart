import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/datasource/models/other/inventory_lot_entry_model.dart';
import 'package:http/http.dart' as http;

class InventoryService {
  Future<List<InventoryLogEntryModel>> getInventoryByTime(
      DateTime startDate, DateTime endDate) async {
    final res = await http.get(Uri.parse(
        '${Constants.baseUrl}api/InventoryLogEntries?StartDate=$startDate&EndDate=$endDate'));
    // 'api/stockcardentries/?StartTime=$startDate&EndTime=$endDate'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<InventoryLogEntryModel> stockcard = body
          .map(
            (dynamic item) => InventoryLogEntryModel.fromJson(item),
          )
          .toList();

      return stockcard;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<List<InventoryLogEntryModel>> getInventoryByItemClass(
      DateTime startDate, DateTime endDate, String itemClassId) async {
    final res = await http.get(Uri.parse(
        '${Constants.baseUrl}api/stockcardentries/?StartTime=$startDate&EndTime=$endDate&itemClassId=$itemClassId'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<InventoryLogEntryModel> stockcard = body
          .map(
            (dynamic item) => InventoryLogEntryModel.fromJson(item),
          )
          .toList();

      return stockcard;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<List<InventoryLogEntryModel>> getInventoryByItemId(
      DateTime startDate, DateTime endDate, String itemId) async {
    final start = DateFormat('yyyy-MM-dd').format(startDate);
    final end = DateFormat('yyyy-MM-dd').format(endDate);

    final res = await http.get(Uri.parse(
        '${Constants.baseUrl}api/InventoryLogEntries/$itemId?StartTime=$start&EndTime=$end'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<InventoryLogEntryModel> stockcard = body
          .map(
            (dynamic item) => InventoryLogEntryModel.fromJson(item),
          )
          .toList();

      return stockcard;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}
