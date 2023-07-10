import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:http/http.dart' as http;

import '../../models/finish_product/finished_product_inventory_model.dart';

class FinishedProductInventoryService{
  Future<List<FinishedProductInventoryModel>> getFinishedProductInventoryByTime(
      DateTime startDate, DateTime endDate) async {
    final res = await http.get(Uri.parse(
        '${Constants.baseUrl}api/FinishedProductInventoryLogEntries?StartDate=$startDate&EndDate=$endDate'));
    // 'api/stockcardentries/?StartTime=$startDate&EndTime=$endDate'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<FinishedProductInventoryModel> stockcard = body
          .map(
            (dynamic item) => FinishedProductInventoryModel.fromJson(item),
          )
          .toList();

      return stockcard;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<List<FinishedProductInventoryModel>> getFinishedProductInventoryByItemClass(
      DateTime startDate, DateTime endDate, String itemClassId) async {
    final res = await http.get(Uri.parse(
        '${Constants.baseUrl}api/stockcardentries/?StartTime=$startDate&EndTime=$endDate&itemClassId=$itemClassId'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<FinishedProductInventoryModel> stockcard = body
          .map(
            (dynamic item) => FinishedProductInventoryModel.fromJson(item),
          )
          .toList();

      return stockcard;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<List<FinishedProductInventoryModel>> getFinishedProductInventoryByItemId(
      DateTime startDate, DateTime endDate, String itemId) async {
    final start = DateFormat('yyyy-MM-dd').format(startDate);
    final end = DateFormat('yyyy-MM-dd').format(endDate);

    final res = await http.get(Uri.parse(
        '${Constants.baseUrl}api/FinishedProductInventoryLogEntries/$itemId?StartTime=$start&EndTime=$end'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<FinishedProductInventoryModel> stockcard = body
          .map(
            (dynamic item) => FinishedProductInventoryModel.fromJson(item),
          )
          .toList();

      return stockcard;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}
