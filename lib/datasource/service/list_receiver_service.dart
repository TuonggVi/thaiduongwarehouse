import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_warehouse_thaiduong/constant.dart';

class ReceiverListService{
  Future<List<String>> getAllReceiverId() async {
    final res = await http.get(Uri.parse('${Constants.baseUrl}api/GoodsIssues/Receivers'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<String> listReceiver  = body
          .map(
            (dynamic item) => item.toString(),
          )
          .toList();
      return listReceiver;
    } else {
      throw "Unable to retrieve posts.";
    }
  
  }
}

