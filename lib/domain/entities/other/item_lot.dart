// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/item.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/location.dart';

class ItemLot extends Equatable {
  String lotId;
  Item? item;
  bool? isolated;
  double? quantity;
  DateTime? productionDate;
  DateTime? expirationDate;
  List<ItemLotSublot> itemLotSubLot;
  ItemLot(
      this.lotId,
      this.item,
      this.isolated,
      this.quantity,
      this.productionDate,
      this.expirationDate,
      this.itemLotSubLot);
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
