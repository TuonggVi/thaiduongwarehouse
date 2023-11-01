import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/datasource/models/item_model.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/item.dart';

import '../models/error_package_model.dart';

class ItemService {
  Future<List<ItemModel>> getAllItems() async {
    final res = await http.get(Uri.parse('${Constants.baseUrl}api/Items'));
    
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<ItemModel> items = body
          .map(
            (dynamic item) => ItemModel.fromJson(item),
          )
          .toList();
      return items;
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<ErrorPackageModel> postNewItems(Item item) async {
    final res =
        await http.post(Uri.parse('${Constants.baseUrl}/api/Items'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Accept': '*/*',
            },
            body: jsonEncode(<String, dynamic>{
              "itemId": item.itemId,
              "itemName": item.itemName,
              "minimumStockLevel": item.minimumStockLevel,
              "price": item.price,
              "itemClassId": item.itemClass,
              "unit": item.unit,
            }));
    if (res.statusCode == 200) {
      return ErrorPackageModel(
        "success",
      );
    } else {
      return ErrorPackageModel("fail");
    }
  }
}
