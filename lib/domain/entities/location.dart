

// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Location extends Equatable {
  String locationId;
  //List<ItemLot>? lots;
  Location(this.locationId, );
  @override
  List<Object?> get props => [locationId];
}

class Warehouse extends Equatable {
  String warehouseId;
  String warehouseName;
  List<Location> locations;
  Warehouse(this.warehouseId, this.warehouseName, this.locations);
  @override
  List<Object?> get props => [warehouseId];
}
// chia lô
class GoodsReceiptSublot extends Equatable {
  String? locationId;
  double? quantityPerLocation;
  
  GoodsReceiptSublot(this.locationId, this.quantityPerLocation,);
  @override
  List<Object?> get props => [];
}
class GoodsIssueSublot extends Equatable {
  String? locationId;
  double? quantityPerLocation;
double? newQuantityPerLocation;
  GoodsIssueSublot(this.locationId, this.quantityPerLocation, this.newQuantityPerLocation);
  @override
  List<Object?> get props => [];
}
class ItemLotSublot extends Equatable {
  String? locationId;
  double? quantityPerLocation;
double? newQuantityPerLocation;
  ItemLotSublot(this.locationId, this.quantityPerLocation, this.newQuantityPerLocation);
  @override
  List<Object?> get props => [];
}
class AdjustmentSublot extends Equatable {
  String? locationId;
  double? quantityPerLocation;
    double? newQuantityPerLocation;
  AdjustmentSublot(this.locationId, this.quantityPerLocation, this.newQuantityPerLocation);
  @override
  List<Object?> get props => [];
}