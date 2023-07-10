// ignore_for_file: must_be_immutable

import 'package:mobile_warehouse_thaiduong/domain/entities/location.dart';

class LocationModel extends Location {
  LocationModel(super.locationId, );
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
