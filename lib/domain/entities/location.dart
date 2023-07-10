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
