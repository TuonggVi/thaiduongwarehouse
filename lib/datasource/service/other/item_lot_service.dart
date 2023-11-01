import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/datasource/models/other/item_lot_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';

class ItemLotService {
  Future<ItemLotModel> getItemLotById(String lotId) async {
    final res = await http.get(
      Uri.parse('${Constants.baseUrl}api/ItemLots/ByLotId/$lotId'),
    );
    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      //   print(body.toString());
      ItemLotModel lot = ItemLotModel.fromJson(body);
      return lot;
    } else {

      return throw "Unable to retrieve posts.";
    }
  }
  // truy xuất lô hàng theo itemId
 Future<List<ItemLotModel>> getItemLotsByItemId(String itemId) async {
    final res = await http.get(Uri.parse('${Constants.baseUrl}api/ItemLots/$itemId'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<ItemLotModel> items = body
          .map(
            (dynamic item) => ItemLotModel.fromJson(item),
          )
          .toList();
      return items;
    } else {
      throw "Unable to retrieve posts.";
    }
  
  }
 // kệ kho: truy xuất theo vị trí
  Future<List<ItemLotModel>> getItemLotsByLocation(String locationId) async {
    final res = await http.get(Uri.parse('${Constants.baseUrl}/api/ItemLots/$locationId/lots'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<ItemLotModel> items = body
          .map(
            (dynamic item) => ItemLotModel.fromJson(item),
          )
          .toList();
      return items;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
  
// truy xuất hàng cách ly
  Future<List<ItemLotModel>> getIsolatedItemLots() async {
   final res = await http.get(Uri.parse('${Constants.baseUrl}api/ItemLots/Isolated'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<ItemLotModel> items = body
          .map(
            (dynamic item) => ItemLotModel.fromJson(item),
          )
          .toList();
      return items;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
// cảnh báo hạn sử dụng
  Future<List<ItemLotModel>> getExpiredItemLots(int month) async {
 final res = await http.get(Uri.parse('${Constants.baseUrl}api/Warnings/ExpirationDate/$month'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<ItemLotModel> items = body
          .map(
            (dynamic item) => ItemLotModel.fromJson(item),
          )
          .toList();
      return items;
    } else {
      throw "Unable to retrieve posts.";
    }
  
  }
// cảnh báo tồn kho tối thiểu
  Future<List<ItemLotModel>> getUnderStockminItemLots(String itemClassId) async {
       final res = await http.get(Uri.parse('${Constants.baseUrl}api/Warnings/MinimumStockLevel/$itemClassId'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<ItemLotModel> items = body
          .map(
            (dynamic item) => ItemLotModel.fromJson(item),
          )
          .toList();
      return items;
    } else {
      throw "Unable to retrieve posts.";
    }
  
  }
// cách ly lô hàng
  Future<ErrorPackage> patchIsolationItemLot(bool isolated, String itemLotId ) async {
       final res = await http.patch(Uri.parse('${Constants.baseUrl}api/ItemLots/$itemLotId?isIsolated=true'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': '*/*',
        },
     );
    if (res.statusCode == 200) {
    
      return ErrorPackage('Success');
    } else {
        return ErrorPackage('Fail');
    }
  
  }
  
}
