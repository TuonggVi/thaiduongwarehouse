import 'package:equatable/equatable.dart';

class Employee extends Equatable {
 final String employeeId;
 final String employeeName;
 const Employee(this.employeeId, this.employeeName);
  @override
  List<Object?> get props =>[employeeId];
}
