import 'package:mobile_warehouse_thaiduong/domain/entities/department.dart';

abstract class DepartmentRepository {
  Future<List<Department>> getAllDepartment();
}
