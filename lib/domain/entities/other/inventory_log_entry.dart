import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/item.dart';

class InventoryLogEntry extends Equatable {
 final Item item;
 final double beforeQuantity;
 final double changedQuantity;
 final DateTime timestamp;
 final String itemLot;
 const InventoryLogEntry(
      this.item, this.beforeQuantity, this.changedQuantity, this.timestamp, this.itemLot);
  @override
  List<Object?> get props  => [timestamp];
}
