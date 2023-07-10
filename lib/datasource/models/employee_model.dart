import 'package:mobile_warehouse_thaiduong/domain/entities/employee.dart';

class EmployeeModel extends Employee{
  const EmployeeModel(super.employeeId, super.employeeName);
factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      json['employeeId'],
      json['employeeName']
    );
  }
}