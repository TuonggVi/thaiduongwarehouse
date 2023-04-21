// ignore_for_file: unused_import, prefer_interpolation_to_compose_strings

import 'package:mobile_warehouse_thaiduong/datasource/models/error_package_model.dart';
import 'package:mobile_warehouse_thaiduong/datasource/models/lot_adjustment_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../constant.dart';
class LotAdjustmentService {
  Future<ErrorPackageModel> postNewLotAdjustment(
    double afterQuantity, 
    String newPurchaseOrderNumber, 
    String notes)async {
    final res =
        await http.post(Uri.parse(Constants.baseUrl + 'api/lotAdjustment/'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ',
            },
            body: jsonEncode(
              <String, dynamic>{},
            ));
    if (res.statusCode == 200) {
      return ErrorPackageModel(
        "success",
      );
    } else {
      dynamic body = jsonDecode(res.body);
      ErrorPackageModel error = ErrorPackageModel.fromJson(body);
      return error;
    }
  }

  Future<List<LotAdjustmentModel>> getAllLotAdjustment() async {
    //   final res = await http.get(
    //   Uri.parse(Constants.baseUrl + '/api/LotAdjustments'),
    // );
    // if (res.statusCode == 200) {
    //   List<dynamic> body = jsonDecode(res.body);
    //   //   print(body.toString());
    //   List<LotAdjustmentModel> lot =
    //       body.map((e) => LotAdjustmentModel.fromJson(e)).toList();
    //   return lot;
    // } else {
    //   return throw "Unable to retrieve posts.";
    // }
    return [];
  }
}
