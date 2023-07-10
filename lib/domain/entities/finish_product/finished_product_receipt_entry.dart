// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/item.dart';

class  FinishedProductReceiptEntry extends Equatable {
String purchaseOrderNumber;
double quantity;
String? note;
Item item;
   FinishedProductReceiptEntry(
      this.purchaseOrderNumber,
      this.quantity,
      this.note,
      this.item);
  @override
  List<Object?> get props => [];
}


