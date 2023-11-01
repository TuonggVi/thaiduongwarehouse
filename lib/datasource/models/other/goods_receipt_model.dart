// ignore_for_file: must_be_immutable

import 'package:mobile_warehouse_thaiduong/datasource/models/item_model.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/goods_receipt.dart';

import '../employee_model.dart';
import '../location_model.dart';

class GoodsReceiptLotModel extends GoodsReceiptLot {
  GoodsReceiptLotModel(
      super.goodsReceiptLotId,
      super.oldGoodsReceiptLotId,
      super.newGoodsReceiptLotId,
      super.goodsReceiptSublot,
      super.item,
      super.unit,
      super.quantity,
      super.employee,
      super.productionDate,
      super.expirationDate,
      super.note);
  factory GoodsReceiptLotModel.fromJson(Map<String, dynamic> json) {
    return GoodsReceiptLotModel(
      json['goodsReceiptLotId'],
      json['oldGoodsReceiptLotId'],
      json['newGoodsReceiptLotId'],
      json['goodsReceiptSublots'] == null
          ? []
          : (json["goodsReceiptSublots"] as List)
              .map((e) => GoodsReceiptSublotModel.fromJson(e))
              .toList(),
      json['item'] = ItemModel.fromJson(json["item"]),
      json['unit'],
      double.parse(json['quantity'].toString()),
      json['employee'] == null
          ? const EmployeeModel("", "")
          : EmployeeModel.fromJson(json["employee"]),
      DateTime.tryParse(json['productionDate'].toString()),
      DateTime.tryParse(json['expirationDate'].toString()),
      json['note'],
    );
  }
}

class GoodsReceiptModel extends GoodsReceipt {
  GoodsReceiptModel(super.goodsReceiptId, super.supply, super.lots,
      super.timestamp, super.empployee, super.isCompleted);
  factory GoodsReceiptModel.fromJson(Map<String, dynamic> json) {
    return GoodsReceiptModel(
      json['goodsReceiptId'],
      json['supplier'],
      json['lots'] == null
          ? []
          : (json["lots"] as List)
              .map((e) => GoodsReceiptLotModel.fromJson(e))
              .toList(),
      //  DateFormat('dd-MM-yy').parse(json['timestamp'],),
      DateTime.tryParse(json['timestamp'].toString()),
      json['employee'] == null
          ? const EmployeeModel("", "")
          : EmployeeModel.fromJson(json["employee"]),
      json['isCompleted'],
    );
  }
}

// điều chỉnh thông tin mã lô và số lượng
class GoodsReceiptLotAdjustmentModel extends GoodsReceiptLotAdjustment {
  GoodsReceiptLotAdjustmentModel(
      super.oldGoodsReceiptLotId,
      super.newGoodsReceiptLotId,
      super.goodsReceiptSublot,
      super.quantity,
      super.productionDate,
      super.expirationDate);
  factory GoodsReceiptLotAdjustmentModel.fromJson(Map<String, dynamic> json) {
    return GoodsReceiptLotAdjustmentModel(
      json['oldGoodsReceiptLotId'],
      json['newGoodsReceiptLotId'],
      json['itemLotLocations'] == null
          ? []
          : (json["itemLotLocations"] as List)
              .map((e) => GoodsReceiptSublotModel.fromJson(e))
              .toList(),
      double.parse(json['quantity'].toString()),
      //  DateFormat('dd-MM-yy').parse(json['timestamp'],),
      DateTime.tryParse(json['productionDate'].toString()),
      DateTime.tryParse(json['expirationDate'].toString()),
    );
  }
}
