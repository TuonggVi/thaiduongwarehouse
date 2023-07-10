// ignore_for_file: must_be_immutable

import 'package:mobile_warehouse_thaiduong/datasource/models/employee_model.dart';
import '../../../domain/entities/finish_product/finished_product_issue.dart';
import 'finished_product_issue_entry_model.dart';

class FinishedProductIssueModel extends FinishedProductIssue {
  FinishedProductIssueModel(
    super.finishedProductIssueId, 
    super.receiver,
    super.timestamp, 
    super.employee, 
    super.entries);
  factory FinishedProductIssueModel.fromJson(Map<String, dynamic> json) {
    return FinishedProductIssueModel(
      json['finishedProductIssueId'],
      json['receiver'],
      DateTime.tryParse(json['timestamp'].toString())!,
      json['employee'] == null
          ? const EmployeeModel('', '')
          : EmployeeModel.fromJson(json["employee"]),
    json['entries'] == null
          ? []
          : (json["entries"] as List)
              .map((e) => FinishedProductIssueEntryModel.fromJson(e))
              .toList(),
    );
  }
}
