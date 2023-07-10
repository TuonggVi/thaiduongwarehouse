// ignore_for_file: must_be_immutable

import 'package:mobile_warehouse_thaiduong/datasource/models/employee_model.dart';
import 'package:mobile_warehouse_thaiduong/datasource/models/item_model.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/lot_adjustment.dart';

class LotAdjustmentModel extends LotAdjustment {
  LotAdjustmentModel(
      super.lotId,
      super.note,
      super.employee,
      super.timestamp,
      super.afterQuantity,
      super.beforeQuantity,
      super.oldPoNumber,
      super.newPoNumber,
      super.item,
      super.isConfirmed);
  factory LotAdjustmentModel.fromJson(Map<String, dynamic> json) {
    return LotAdjustmentModel(
      json['lotId'],
      json['note'],
      json['employee'] == null ? const EmployeeModel('', '') : EmployeeModel.fromJson(json["itemClass"]),
      json['timestamp'],
      json['afterQuantity'],
      json['beforeQuantity'],
      json['newPurchaseOrderNumber'],
      json['oldPurchaseOrderNumber'],
      json['item'] = ItemModel.fromJson(json["itemClass"]),
      json['isConfirmed'],
    );
  }
}
