// ignore_for_file: must_be_immutable

import 'package:mobile_warehouse_thaiduong/datasource/models/item_model.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/item_lot.dart';

class ItemLotModel extends ItemLot{
  ItemLotModel(super.lotId, super.item, super.isolated, super.quantity, super.sublotSize, super.purchaseOrderNumber, super.location, super.productionDate, super.expirationDate);
factory ItemLotModel.fromJson(Map<String, dynamic> json) {
    return ItemLotModel(
      json['lotId'],
      json['item'] =  ItemModel.fromJson(json["item"]),
      json['isolated'],
      json['quantity'],
      json['sublotSize'],
      json['purchaseOrderNumber'],
      json['location'] ,
      json['productionDate'],
      json['expirationDate'],
    );
  }
}