// ignore_for_file: must_be_immutable

import 'package:mobile_warehouse_thaiduong/datasource/models/item_model.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/goods_receipt.dart';

import '../employee_model.dart';

class GoodsReceiptLotModel extends GoodsReceiptLot {
  GoodsReceiptLotModel(
      super.goodsReceiptLotId,
      super.item,
      super.unit,
      super.quantity,
      super.sublotSize,
      super.purchaseOrderNumber,
      super.employee,
      super.location,
      super.productionDate,
      super.expirationDate, super.note);
  factory GoodsReceiptLotModel.fromJson(Map<String, dynamic> json) {
    return GoodsReceiptLotModel(
      json['goodsReceiptLotId'],
      json['item']
      = ItemModel.fromJson(json["item"]),
      json['unit'],
     double.parse( json['quantity'].toString()),
  double.tryParse( json['sublotSize'].toString()),
      json['purchaseOrderNumber'],
      //json['employee'],
      // json['location'] = Location('', <ItemLot>[]),
      json['employee'] == null
          ? const EmployeeModel("", "")
          : EmployeeModel.fromJson(json["employee"]),
      json['locationId'],
      //  == null
      //     ? LocationModel('', <ItemLot>[])
      //     : LocationModel.fromJson(json["location"]),
     DateTime.tryParse( json['productionDate'].toString()),
     DateTime.tryParse( json['expirationDate'].toString()),
        json['note'],
    );
  }
}

class GoodsReceiptModel extends GoodsReceipt {
  GoodsReceiptModel(super.goodsReceiptId,super.supply, super.lots,
      super.timestamp,super.empployee, super.isCompleted);
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
