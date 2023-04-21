import 'package:mobile_warehouse_thaiduong/domain/repositories/department_repository.dart';

import '../entities/department.dart';

class DepartmentUsecase {
  DepartmentRepository departmentRepository;
  DepartmentUsecase(this.departmentRepository);
  Future<List<Department>> getAllDepartment() async {
    final departments = departmentRepository.getAllDepartment();
    return departments;
  }
}