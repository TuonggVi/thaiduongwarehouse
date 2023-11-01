// ignore_for_file: must_be_immutable

import 'package:mobile_warehouse_thaiduong/datasource/models/employee_model.dart';
import 'package:mobile_warehouse_thaiduong/datasource/models/item_model.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/lot_adjustment.dart';

import '../location_model.dart';

class LotAdjustmentModel extends LotAdjustment {
  LotAdjustmentModel(
      super.lotId,
      super.note,
      super.employee,
      super.timestamp,
      super.afterQuantity,
      super.beforeQuantity,
      super.sublotAdjusment,
      super.item,
      super.isConfirmed);
  factory LotAdjustmentModel.fromJson(Map<String, dynamic> json) {
    return LotAdjustmentModel(
      json['lotId'],
      json['note'],
      json['employee'] == null
          ? const EmployeeModel('', '')
          : EmployeeModel.fromJson(json["itemClass"]),
      json['timestamp'],
      double.parse(json['afterQuantity'].toString()),
      double.parse(json['beforeQuantity'].toString()),
      json['itemLotLocations'] == null
          ? []
          : (json["itemLotLocations"] as List)
              .map((e) => ItemLotSublotModel.fromJson(e))
              .toList(),
      json['item'] = ItemModel.fromJson(json["itemClass"]),
      json['isConfirmed'],
    );
  }
}
