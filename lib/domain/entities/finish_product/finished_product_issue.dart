// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/employee.dart';
import 'finished_product_issue_entry.dart';

class  FinishedProductIssue extends Equatable {

String finishedProductIssueId;
String? receiver;
DateTime timestamp;
Employee employee;
List<FinishedProductIssueEntry> entries;
   FinishedProductIssue(
      this.finishedProductIssueId,
      this.receiver,
      this.timestamp,
      this.employee,
      this.entries);
  List<Object?> get props => [];
}


