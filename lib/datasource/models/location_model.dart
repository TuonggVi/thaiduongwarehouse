// ignore_for_file: must_be_immutable

import 'package:mobile_warehouse_thaiduong/domain/entities/location.dart';

class LocationModel extends Location {
  LocationModel(
    super.locationId,
  );
  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      json['locationId'],
      // json['itemLots'] == null
      //     ? []
      //     : (json["itemLots"] as List)
      //         .map((e) => ItemLotModel.fromJson(e))
      //         .toList(),
    );
  }
}

class WarehouseModel extends Warehouse {
  WarehouseModel(super.warehouseId, super.warehouseName, super.locations);
  factory WarehouseModel.fromJson(Map<String, dynamic> json) {
    return WarehouseModel(
      json['warehouseId'],
      json['warehouseName'],
      json['locations'] == null
          ? []
          : (json["locations"] as List)
              .map((e) => LocationModel.fromJson(e))
              .toList(),
    );
  }
}

// phân lô
class GoodsReceiptSublotModel extends GoodsReceiptSublot {
  GoodsReceiptSublotModel(super.locationId, super.quantityPerLocation);
  factory GoodsReceiptSublotModel.fromJson(Map<String, dynamic> json) {
    return GoodsReceiptSublotModel(
      json['locationId'],
      double.tryParse(json['quantityPerLocation'].toString()),
    );
  }
    @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GoodsReceiptSublotModel &&
          other.locationId == locationId &&
          other.quantityPerLocation == quantityPerLocation);

  @override
  int get hashCode => locationId.hashCode ^ quantityPerLocation.hashCode;

}

class GoodsIssueSublotModel extends GoodsIssueSublot {
  GoodsIssueSublotModel(super.locationId, super.quantityPerLocation,
      super.newQuantityPerLocation);
  factory GoodsIssueSublotModel.fromJson(Map<String, dynamic> json) {
    return GoodsIssueSublotModel(
      json['locationId'],
      double.tryParse(json['quantityPerLocation'].toString()),
      double.tryParse(json['newQuantityPerLocation'].toString()),
    );
  }
}

class ItemLotSublotModel extends ItemLotSublot {
  ItemLotSublotModel(super.locationId, super.quantityPerLocation,
      super.newQuantityPerLocation);
  factory ItemLotSublotModel.fromJson(Map<String, dynamic> json) {
    return ItemLotSublotModel(
      json['locationId'],
      double.tryParse(json['quantityPerLocation'].toString()),
      double.tryParse(json['newQuantityPerLocation'].toString()),
    );
  }
}
