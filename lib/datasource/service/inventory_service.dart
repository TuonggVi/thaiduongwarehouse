// ignore_for_file: unused_import, prefer_interpolation_to_compose_strings, avoid_print

import 'package:mobile_warehouse_thaiduong/datasource/models/inventory_lot_entry_model.dart';
import 'package:mobile_warehouse_thaiduong/datasource/models/item_lot_model.dart';
import 'package:mobile_warehouse_thaiduong/datasource/models/item_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../constant.dart';

class InventoryService {
  Future<List<InventoryLogEntryModel>> getInventoryByTime(
      String startDate, String endDate) async {
    final res = await http.get(Uri.parse(Constants.baseUrl +
          'api/InventoryLogEntries'));
       // 'api/stockcardentries/?StartTime=$startDate&EndTime=$endDate'));
    if (res.statusCode == 200) {
      print(res.body);
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
    // return [
    //   InventoryLogEntryModel(
    //       ItemModel('2', 'kk', UnitModel('cái'), ItemClassModel('TP'), 100, 10),
    //       100,
    //       10,
    //       DateTime.now(),
    //       ItemLotModel(
    //           '123',
    //           ItemModel(
    //               '2', 'kk', UnitModel('cái'), ItemClassModel('TP'), 100, 10),
    //           false,
    //           100,
    //           10,
    //           "121212",
    //           'Vị trí 1',
    //           null,
    //           null)),
    //   InventoryLogEntryModel(
    //       ItemModel('2', 'kk', UnitModel('cái'), ItemClassModel('TP'), 100, 10),
    //       100,
    //       10,
    //       DateTime.now(),
    //       ItemLotModel(
    //           '123',
    //           ItemModel(
    //               '2', 'kk', UnitModel('cái'), ItemClassModel('TP'), 100, 10),
    //           false,
    //           100,
    //           10,
    //           "121212",
    //           'Vị trí 1',
    //           null,
    //           null))
    // ];
  }

  Future<List<InventoryLogEntryModel>> getInventoryByItemClass(
      DateTime startDate, DateTime endDate, String itemClassId) async {
    final res = await http.get(Uri.parse(Constants.baseUrl +
        'api/stockcardentries/?StartTime=$startDate&EndTime=$endDate&itemClassId=$itemClassId'));
    if (res.statusCode == 200) {
      print(res.body);
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
    //return [];
  }

  Future<List<InventoryLogEntryModel>> getInventoryByItemId(
    DateTime startDate, DateTime endDate, String itemId) async {
    final res = await http.get(Uri.parse(Constants.baseUrl +
        ' /api/InventoryLogEntries/{itemId}?StartTime=$startDate&EndTime=$endDate'));
    if (res.statusCode == 200) {
      print(res.body);
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
    // return [
    //   InventoryLogEntryModel(
    //       ItemModel('2', 'kk', UnitModel('cái'), ItemClassModel('TP'), 100, 10),
    //       100,
    //       10,
    //       DateTime.now(),
    //       ItemLotModel(
    //           '123',
    //           ItemModel(
    //               '2', 'kk', UnitModel('cái'), ItemClassModel('TP'), 100, 10),
    //           false,
    //           100,
    //           10,
    //           "121212",
    //           'Vị trí 1',
    //           null,
    //           null)),
    //   InventoryLogEntryModel(
    //       ItemModel('2', 'kk', UnitModel('cái'), ItemClassModel('TP'), 100, 10),
    //       100,
    //       10,
    //       DateTime.now(),
    //       ItemLotModel(
    //           '123',
    //           ItemModel(
    //               '2', 'kk', UnitModel('cái'), ItemClassModel('TP'), 100, 10),
    //           false,
    //           100,
    //           10,
    //           "121212",
    //           'Vị trí 1',
    //           null,
    //           null))
    // ];
  }

  // thử giao diện
  Future<List<InventoryLogEntryModel>> getInventoryLotByItemClassId(
    DateTime dateTime, String itemId) async {
    // final res = await http.get(Uri.parse(Constants.baseUrl +
    //     'api/stockcardentries/?DateTime=$dateTime&itemId=$itemId'));
    // if (res.statusCode == 200) {
    //   print(res.body);
    //   List<dynamic> body = jsonDecode(res.body);
    //   List<InventoryLogEntryModel> stockcard = body
    //       .map(
    //         (dynamic item) => InventoryLogEntryModel.fromJson(item),
    //       )
    //       .toList();

    //   return stockcard;
    // } else {
    //   throw "Unable to retrieve posts.";
    // }
    return [
      InventoryLogEntryModel(
          ItemModel('2023-03-02', '01', 'cái', 'TP',
              100, 10),
          100,
          10,
          DateTime.now(),
          ItemLotModel(
              '123',
              ItemModel(
                  '2', 'kk', 'cái', 'TP', 100, 10),
              false,
              100,
              10,
              "121212",
              'Vị trí 1',
              null,
              null)),
      InventoryLogEntryModel(
          ItemModel('2023-03-02', '02', 'cái', 'TP',
              100, 10),
          100,
          10,
          DateTime.now(),
          ItemLotModel(
              '123',
              ItemModel(
                  '2', 'kk','cái', 'TP', 100, 10),
              false,
              100,
              10,
              "121213",
              'Vị trí 2',
              null,
              null)),
              InventoryLogEntryModel(
          ItemModel('2023-03-02', '01', 'cái', 'TP',
              100, 10),
          100,
          10,
          DateTime.now(),
          ItemLotModel(
              '123',
              ItemModel(
                  '2', 'kk', 'cái', 'TP', 100, 10),
              false,
              100,
              10,
              "121212",
              'Vị trí 1',
              null,
              null)),
 
    ];
  }
}
