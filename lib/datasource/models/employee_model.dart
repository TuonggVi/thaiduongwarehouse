// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:mobile_warehouse_thaiduong/domain/entities/employee.dart';

class EmployeeModel extends Employee{
  EmployeeModel(super.employeeId, super.employeeName);
factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      json['employeeId'],
      json['employeeName']
    );
  }
}