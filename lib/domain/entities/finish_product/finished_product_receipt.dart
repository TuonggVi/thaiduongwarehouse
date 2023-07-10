// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/employee.dart';
import 'finished_product_receipt_entry.dart';

class FinishedProductReceipt extends Equatable {
  String finishedProductReceiptId;
  DateTime timestamp;
  Employee employee;
  List<FinishedProductReceiptEntry> entries;
  FinishedProductReceipt(
    this.finishedProductReceiptId,
    this.timestamp,
    this.employee,
    this.entries,
    );
  @override
  List<Object?> get props => [timestamp];
}
