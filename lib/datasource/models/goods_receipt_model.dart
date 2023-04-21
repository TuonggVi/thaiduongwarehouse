// ignore_for_file: must_be_immutable

import 'package:mobile_warehouse_thaiduong/domain/entities/goods_receipt.dart';

class GoodsReceiptLotModel extends GoodsReceiptLot {
  GoodsReceiptLotModel(
      super.goodsReceiptLotId,
      super.item,
      super.quantity,
      super.sublotSize,
      super.purchaseOrderNumber,
      super.employee,
      super.location,
      super.productionDate,
      super.expirationDate);
  factory GoodsReceiptLotModel.fromJson(Map<String, dynamic> json) {
    return GoodsReceiptLotModel(
      json['goodsReceiptLotId'],
      json['itemId'],
      //= ItemModel.fromJson(json["item"]),
      json['quantity'],
      json['sublotSize'],
      json['purchaseOrderNumber'],
      json['employeeId'],
      // json['location'] = Location('', <ItemLot>[]),
      // json['employee'] == null
      //     ? EmployeeModel("", "")
      //     : EmployeeModel.fromJson(json["employee"]),
      json['location'],
      //  == null
      //     ? LocationModel('', <ItemLot>[])
      //     : LocationModel.fromJson(json["location"]),
      json['productionDate'],
      json['expirationDate'],
    );
  }
}

class GoodsReceiptModel extends GoodsReceipt {
  GoodsReceiptModel(super.goodsReceiptId,super.supply, super.lots,
      super.timestamp, super.isConfirmed);
  factory GoodsReceiptModel.fromJson(Map<String, dynamic> json) {
    return GoodsReceiptModel(
      json['goodsReceiptId'],
      json['supply'],
      json['lots'] == null
          ? []
          : (json["lots"] as List)
              .map((e) => GoodsReceiptLotModel.fromJson(e))
              .toList(),
      json['timestamp'],
      json['isCompleted'],
    );
  }
}