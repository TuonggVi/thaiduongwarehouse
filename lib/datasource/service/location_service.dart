import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_warehouse_thaiduong/constant.dart';
import 'package:mobile_warehouse_thaiduong/datasource/models/location_model.dart';

class LocationService {
  Future<List<String>> getAllLocationId() async {
    // final res = await http.get(Uri.parse('${Constants.baseUrl}/api/Warehouses'));
    // if (res.statusCode == 200) {
    //   List<dynamic> body = jsonDecode(res.body);
    //   print(body.toString());
    //     List<WarehouseModel> warehouse = body
    //       .map(
    //         (dynamic item) => WarehouseModel.fromJson(item),
    //       )
    //       .toList();
    //     //List<String>  locations = warehouse.map((e) => e.locations.)

    //   print(locations.toString());
    //   return locations;
    // } else {
    //   throw "Unable to retrieve posts.";
    // }
    return [];
  }

  Future<List<WarehouseModel>> getAllWarehouseId() async {
    final res =
        await http.get(Uri.parse('${Constants.baseUrl}/api/Warehouses'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<WarehouseModel> warehouse = body
          .map(
            (dynamic item) => WarehouseModel.fromJson(item),
          )
          .toList();

      return warehouse;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}
