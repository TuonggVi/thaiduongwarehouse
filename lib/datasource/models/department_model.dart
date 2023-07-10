import 'package:mobile_warehouse_thaiduong/domain/entities/department.dart';

class DepartmentModel extends Department {
  const DepartmentModel(super.name);
  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      json['name'],
    );
  }
}
