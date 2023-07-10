// ignore_for_file: must_be_immutable

import '../../../domain/entities/finish_product/finished_product_receipt.dart';
import '../employee_model.dart';
import 'finished_product_receipt_entry_model.dart';


class FinishedProductReceiptModel extends FinishedProductReceipt {
  FinishedProductReceiptModel(
    super.finishedProductReceiptId,
    super.timestamp,
    super.employee,
    super.entries,
  );
  factory FinishedProductReceiptModel.fromJson(Map<String, dynamic> json) {
    return FinishedProductReceiptModel(
      json['FinishedProductReceiptId'],
      DateTime.tryParse(json['timestamp'].toString())!,
      json['employee'] == null
          ? const EmployeeModel("", "")
          : EmployeeModel.fromJson(json["employee"]),
      json['entries'] == null
          ? []
          : (json["entries"] as List)
              .map((e) => FinishedProductReceiptEntryModel.fromJson(e))
              .toList(),
              
    );
  }
}