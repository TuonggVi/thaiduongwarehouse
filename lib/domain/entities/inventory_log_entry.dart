import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/item.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/item_lot.dart';

class InventoryLogEntry extends Equatable {
 final Item item;
 final double beforeQuantity;
 final double afterQuantity;
 final DateTime timestamp;
 final ItemLot itemLot;
 const InventoryLogEntry(
      this.item, this.beforeQuantity, this.afterQuantity, this.timestamp, this.itemLot);
  @override

  List<Object?> get props => throw UnimplementedError();
}
