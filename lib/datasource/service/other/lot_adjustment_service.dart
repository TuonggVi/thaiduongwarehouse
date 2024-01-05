import 'package:mobile_warehouse_thaiduong/datasource/models/error_package_model.dart';
import 'package:mobile_warehouse_thaiduong/datasource/models/other/lot_adjustment_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_warehouse_thaiduong/domain/entities/other/lot_adjustment.dart';
import '../../../constant.dart';

class LotAdjustmentService {
  Future<ErrorPackageModel> postNewLotAdjustment(
      String employeename, LotAdjustment lotAdjustment) async {
    List bodyJson = [];
    for (int i = 0; i < lotAdjustment.itemLotSublot.length; i++) {
      Map<String, dynamic> dimensionJson = {
        "locationId": lotAdjustment.itemLotSublot[i].locationId.toString(),
        "newQuantityPerLocation": double.tryParse(
            lotAdjustment.itemLotSublot[i].newQuantityPerLocation.toString()),
      };
      bodyJson.add(dimensionJson);
    }
    final res =
        await http.post(Uri.parse('${Constants.baseUrl}api/LotAdjustments'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Accept': '*/*',
            },
            body: jsonEncode(
              <String, dynamic>{
                "lotId": lotAdjustment.lotId.toString(),
                "itemId": lotAdjustment.item!.itemId.toString(),
                "afterQuantity":
                    double.tryParse(lotAdjustment.afterQuantity.toString()),
                "unit": lotAdjustment.item!.unit.toString(),
                "employeeName": "Tran Nhu Toan",
                "note": lotAdjustment.note.toString(),
                "sublotAdjustments": bodyJson,
              },
            ));
    if (res.statusCode == 200) {
      return ErrorPackageModel(
        "success",
      );
    } else {
      return ErrorPackageModel(
        "fail",
      );
    }
  }

  Future<List<LotAdjustmentModel>> getAllLotAdjustment() async {
    final res = await http.get(
      Uri.parse('${Constants.baseUrl}/api/LotAdjustments'),
    );
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      //   print(body.toString());
      List<LotAdjustmentModel> lot =
          body.map((e) => LotAdjustmentModel.fromJson(e)).toList();
      return lot;
    } else {
      return throw "Unable to retrieve posts.";
    }
  }
}
