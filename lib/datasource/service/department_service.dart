import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_warehouse_thaiduong/datasource/models/department_model.dart';

import '../../constant.dart';

class DepartmentService {
  Future<List<DepartmentModel>> getDepartments() async {
    final res = await http.get(Uri.parse('${Constants.baseUrl}api/Departments'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<DepartmentModel> items = body
          .map(
            (dynamic item) => DepartmentModel.fromJson(item),
          )
          .toList();
      //print(items.toString());
      return items;
    } else {
      throw "Unable to retrieve posts.";
    }
   // return [DepartmentModel('Sản xuất'),DepartmentModel('Đóng gói'), DepartmentModel('QC')];
  }
}
