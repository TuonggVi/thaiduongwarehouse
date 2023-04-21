// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/item.dart';

class ItemLot extends Equatable {
  String lotId;
  Item item;
  bool isolated;
  double quantity;
  double sublotSize;
  String? purchaseOrderNumber;
  String? location;
  DateTime? productionDate;
  DateTime? expirationDate;
  ItemLot(
      this.lotId,
      this.item,
      this.isolated,
      this.quantity,
      this.sublotSize,
      this.purchaseOrderNumber,
      this.location,
      this.productionDate,
      this.expirationDate);
  @override

  List<Object?> get props => [lotId];
}

// lot view => post
class ItemLotView extends Equatable {
  String itemName;
  double quantity;
  ItemLotView(this.itemName, this.quantity);
  @override
 
  List<Object?> get props => [];
}