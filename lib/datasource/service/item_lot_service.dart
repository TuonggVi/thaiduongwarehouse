// ignore_for_file: avoid_print, unused_import, prefer_interpolation_to_compose_strings

import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/datasource/models/item_lot_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_warehouse_thaiduong/domain/entities/item.dart';

class ItemLotService {
  Future<ItemLotModel> getItemLotById(String lotId) async {
    final res = await http.get(
      Uri.parse('${Constants.baseUrl}api/containers/$lotId'),
    );
    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      //   print(body.toString());
      ItemLotModel lot = ItemLotModel.fromJson(body);
      return lot;
    } else {
      print('rổ không xác định');

      return throw "Unable to retrieve posts.";
    }
  }

  Future<List<ItemLotModel>> getItemLotsByItemId(String itemId) async {
      final res = await http.get(
      Uri.parse('${Constants.baseUrl}api/containers/$itemId'),
    );
    // if (res.statusCode == 200) {
    //   dynamic body = jsonDecode(res.body);
    //   //   print(body.toString());
    //  List<ItemLotModel> itemLot = body
    //       .map(
    //         (dynamic item) => ItemLotModel.fromJson(item),
    //       )
    //       .toList();
    //   return itemLot;
   
    // } else {
    //   print('rổ không xác định');

    //   return throw "Unable to retrieve posts.";
    // }
 
    return  [ItemLotModel('2023-02-23', Item('3', '001', 'cái', 'TP', 100, 10), false, 100, 10, "121214", 'Vị trí 1', null,null ),
    ItemLotModel('2023-02-23', Item('3', '002', 'cái', 'TP', 80, 10), false, 100, 10, "121215", 'Vị trí 1', null,null ),
     ItemLotModel('2023-02-24', Item('3', '002', 'cái', 'TP', 120, 10), false, 100, 10, "121215", 'Vị trí 3', null,null ),
     ItemLotModel('2023-02-24', Item('3', '002', 'cái', 'TP', 60, 10), false, 100, 10, "121215", 'Vị trí 1', null,null )];
  }

  Future<List<ItemLotModel>> getItemLotsByLocation(String locationId) async {
          final res = await http.get(
      Uri.parse('${Constants.baseUrl}api/containers/$locationId'),
    );
    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      //   print(body.toString());
     List<ItemLotModel> itemLot = body
          .map(
            (dynamic item) => ItemLotModel.fromJson(item),
          )
          .toList();
      return itemLot;
   
    } else {
      print('rổ không xác định');

      return throw "Unable to retrieve posts.";
    }
    // return  [ItemLotModel('2023-02-23', Item('1', '001', Unit('cái'), ItemClass('TP'), 100, 10), false, 100, 10, "121214", 'Vị trí 1', null,null ),
    // ItemLotModel('2023-02-23', Item('2', '002', Unit('cái'), ItemClass('TP'), 120, 10), false, 100, 10, "121215", 'Vị trí 1', null,null ),
    //  ItemLotModel('2023-02-24', Item('3', '002', Unit('cái'), ItemClass('TP'), 150, 10), false, 100, 10, "121215", 'Vị trí 1', null,null ),
    //  ItemLotModel('2023-02-24', Item('4', '002', Unit('cái'), ItemClass('TP'), 100, 10), false, 100, 10, "121215", 'Vị trí 1', null,null )];
  }

  Future<List<ItemLotModel>> getIsolatedItemLots() async {
    final res = await http.get(
      Uri.parse(Constants.baseUrl + '/api/items'),
     );
    // if (res.statusCode == 200) {
    //   List<dynamic> body = jsonDecode(res.body);
    //   //   print(body.toString());
    //   List<ItemLotModel> lot =
    //       body.map((e) => ItemLotModel.fromJson(e)).toList();
    //   return lot;
    // } else {
    //   return throw "Unable to retrieve posts.";
    // }
    return  [ItemLotModel('2023-02-23', Item('3', '001', 'cái', 'TP', 100, 10), false, 100, 10, "121214", 'Vị trí 1', null,null ),
    ItemLotModel('2023-02-23', Item('3', '002', 'cái', 'TP', 80, 10), false, 100, 10, "121215", 'Vị trí 1', null,null ),
     ItemLotModel('2023-02-24', Item('3', '002', 'cái', 'TP', 120, 10), false, 100, 10, "121215", 'Vị trí 3', null,null ),
     ItemLotModel('2023-02-24', Item('3', '002', 'cái', 'TP', 60, 10), false, 100, 10, "121215", 'Vị trí 1', null,null )];
  }

  Future<List<ItemLotModel>> getExpiredItemLots(DateTime dateTime) async {
             final res = await http.get(Uri.parse(Constants.baseUrl +
          'api/Warnings/ExpirationDate/{months}'));
    // if (res.statusCode == 200) {
    //   dynamic body = jsonDecode(res.body);
    //   //   print(body.toString());
    //  List<ItemLotModel> itemLot = body
    //       .map(
    //         (dynamic item) => ItemLotModel.fromJson(item),
    //       )
    //       .toList();
    //   return itemLot;
    // } else {
    //   print('rổ không xác định');
    //   return throw "Unable to retrieve posts.";
    // }
    return  [ItemLotModel('2023-02-23', Item('1', '001', 'cái', 'TP', 100, 10), false, 100, 10, "121214", 'Vị trí 1', null,null ),
    ItemLotModel('2023-02-23', Item('2', '002', 'cái', 'TP', 60, 10), false, 100, 10, "121215", 'Vị trí 1', null,null ),
     ItemLotModel('2023-02-24', Item('3', '002', 'cái', 'TP', 100, 10), false, 100, 10, "121215", 'Vị trí 1', null,null ),
     ItemLotModel('2023-02-24', Item('4', '002', 'cái', 'TP', 100, 10), false, 100, 10, "121215", 'Vị trí 1', null,null )];
  }
  Future<List<ItemLotModel>> getUnderStockminItemLots(String itemClassId) async {
           final res = await http.get(Uri.parse(Constants.baseUrl +
          'api/Warnings/MinimumStockLevel/{itemClassId}'));
    // if (res.statusCode == 200) {
    //   dynamic body = jsonDecode(res.body);
    //   //   print(body.toString());
    //  List<ItemLotModel> itemLot = body
    //       .map(
    //         (dynamic item) => ItemLotModel.fromJson(item),
    //       )
    //       .toList();
    //   return itemLot;
   
    // } else {
    //   print('rổ không xác định');
    //   return throw "Unable to retrieve posts.";
    // }
    return  [ItemLotModel('2023-02-23', Item('1', '001', 'cái', 'TP', 100, 10), false, 100, 10, "121214", 'Vị trí 1', null,null ),
    ItemLotModel('2023-02-23', Item('2', '002', 'cái', 'TP', 60, 10), false, 100, 10, "121215", 'Vị trí 1', null,null ),
     ItemLotModel('2023-02-24', Item('3', '002', 'cái', 'TP', 100, 10), false, 100, 10, "121215", 'Vị trí 1', null,null ),
     ItemLotModel('2023-02-24', Item('4', '002', 'cái', 'TP', 100, 10), false, 100, 10, "121215", 'Vị trí 1', null,null )];
  }
}