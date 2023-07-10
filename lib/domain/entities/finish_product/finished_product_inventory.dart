
// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/item.dart';

class  FinishedProductInventory extends Equatable {
 String purchaseOrderNumber;
 double quantity;
 DateTime timestamp;
 Item item;
   FinishedProductInventory(
      this.purchaseOrderNumber,
      this.quantity,
      this.timestamp,
      this.item);
  @override
  List<Object?> get props => [];
}


