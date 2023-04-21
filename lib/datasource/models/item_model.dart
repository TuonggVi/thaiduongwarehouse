import 'package:mobile_warehouse_thaiduong/domain/entities/item.dart';

class ItemModel extends Item{
  ItemModel(super.itemId, super.itemName, super.unit, super.itemClass, super.minimumStockLevel, super.price);
factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      json['itemId'],
      json['itemName'],
      json['unit'],
      json["itemClassId"] ,
      //== null ?  ItemClassModel('') : ItemClassModel.fromJson(json["itemClass"]),
     double.parse( json['minimumStockLevel'].toString()),
     double.parse( json['price'].toString()),
    );
  }
}


class UnitModel extends Unit {
  UnitModel(String name) : super(name);
  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      json['name'],
    );
  }
}

class ItemClassModel extends ItemClass {
  ItemClassModel(String itemClassId) : super(itemClassId);
  factory ItemClassModel.fromJson(Map<String, dynamic> json) {
    return ItemClassModel(
      json['itemClassId'],
    );
  }
}