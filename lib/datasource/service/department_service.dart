// ignore_for_file: unused_import

import 'package:mobile_warehouse_thaiduong/datasource/models/department_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../constant.dart';
class DepartmentService {
  Future<List<DepartmentModel>> getAllDepartment() async {
  //  final res = await http.get(
  //     Uri.parse(Constants.baseUrl + 'api/items'),
  //   );
  //   if (res.statusCode == 200) {
  //     List<dynamic> body = jsonDecode(res.body);
  //     List<DepartmentModel> department = body
  //         .map(
  //           (dynamic item) => DepartmentModel.fromJson(item),
  //         )
  //         .toList();
  //     return department;
  //   } else {
  //     throw "Unable to retrieve posts.";
  //   }
   return [DepartmentModel('SX'),DepartmentModel('BH'), DepartmentModel('KHO')];
  }

}
