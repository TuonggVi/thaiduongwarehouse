// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Item extends Equatable {
  String itemId;
  String? itemName;
  String? unit;
  String? itemClassId;
  double? minimumStockLevel;
  double? price;
  Item(this.itemId, this.itemName, this.unit, this.itemClassId,
      this.minimumStockLevel, this.price);
  @override
  List<Object?> get props => [itemId];
}

class Unit extends Equatable {
  String? name;
  Unit(this.name);
  @override
  List<Object?> get props => [name];
}

class ItemClass extends Equatable {
  String itemClassId;
  ItemClass(this.itemClassId);
  @override
  List<Object?> get props => [itemClassId];
}