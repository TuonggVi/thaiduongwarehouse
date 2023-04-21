import 'package:mobile_warehouse_thaiduong/datasource/models/department_model.dart';
import 'package:mobile_warehouse_thaiduong/datasource/service/department_service.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/department_repository.dart';

class DepartmentRepoImpl implements DepartmentRepository {
  final DepartmentService departmentService;
  DepartmentRepoImpl(this.departmentService);
  @override
  Future<List<DepartmentModel>> getAllDepartment() async {
    final departments = departmentService.getAllDepartment();
    return departments;
  }

 
}
