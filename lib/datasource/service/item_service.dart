// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'package:mobile_warehouse_thaiduong/datasource/models/item_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../constant.dart';

class ItemService {
  Future<List<ItemModel>> getAllItem() async {
    final res = await http.get(
      Uri.parse(Constants.baseUrl + 'api/Items'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      print(body.toString());
      List<ItemModel> items = body
          .map(
            (dynamic item) => ItemModel.fromJson(item),
          )
          .toList();
      print(items.toString());
      return items;
    } else {
      throw "Unable to retrieve posts.";
    }
    // return [
    //   ItemModel('1', 'Một', UnitModel('cái'), ItemClassModel('TP'), 100, 10),
    //   ItemModel('2', 'Hai', UnitModel('cái'), ItemClassModel('TP'), 100, 10),
    //   ItemModel('3', 'Hai', UnitModel('cái'), ItemClassModel('BTP'), 100, 10),
    //   ItemModel('4', 'Hai', UnitModel('cái'), ItemClassModel('NVL'), 100, 10)
    // ];
  }

  //==
  Future<List<ItemModel>> getItemByWarehouseId(String itemClassId) async {
              final res = await http.get(
      Uri.parse('${Constants.baseUrl}api/containers/$itemClassId'),
    );
    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      //   print(body.toString());
     List<ItemModel> item = body
          .map(
            (dynamic item) => ItemModel.fromJson(item),
          )
          .toList();
      return item;
   
    } else {
      print('rổ không xác định');

      return throw "Unable to retrieve posts.";
    }
    // return [
    //   ItemModel('1', 'Một', UnitModel('cái'), ItemClassModel('TP'), 100, 10),
    //   ItemModel('2', 'Hai', UnitModel('cái'), ItemClassModel('TP'), 100, 10),
    //   ItemModel('3', 'Hai', UnitModel('cái'), ItemClassModel('BTP'), 100, 10),
    //   ItemModel('4', 'Hai', UnitModel('cái'), ItemClassModel('NVL'), 100, 10)
    // ];
  }

  Future<List<ItemClassModel>> getAllItemClass() async {
    // final res = await http.get(Uri.parse(Constants.baseUrl + 'api/itemClass/'));
    // if (res.statusCode == 200) {
    //   List<dynamic> body = jsonDecode(res.body);
    //   print(body.toString());
    //   List<ItemClassModel> itemClass = body
    //       .map(
    //         (dynamic itemClass) => ItemClassModel.fromJson(itemClass),
    //       )
    //       .toList();
    //   print(itemClass.toString());
    //   return itemClass;
    // } else {
    //   throw "Unable to retrieve posts.";
    // }

   return [ItemClassModel('TP'), ItemClassModel('BTP'), ItemClassModel('NVL')];
  }
}
