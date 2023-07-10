import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_warehouse_thaiduong/constant.dart';


class SupplierService {
  Future<List<String>> getAllSupplierId() async {
    final res = await http.get(Uri.parse('${Constants.baseUrl}api/GoodsReceipts/Suppliers'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<String> listPO = body
          .map(
            (dynamic item) => item.toString(),
          )
          .toList();
      return listPO;
    } else {
      throw "Unable to retrieve posts.";
    }
  
  }
}
