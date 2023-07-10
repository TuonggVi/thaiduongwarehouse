// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/goods_receipt.dart';

abstract class CompletedReceiptLotEvent extends Equatable {}

class LoadReceiptLotCompletedEvent extends CompletedReceiptLotEvent {
  DateTime timestamp;
  GoodsReceipt goodsReceipt;
  LoadReceiptLotCompletedEvent(this.timestamp, this.goodsReceipt);
  @override
  List<Object?> get props => [timestamp];
}

// class LoadShelfIdEvent extends CompletedReceiptLotEvent {
//   DateTime timestamp;
//   LoadShelfIdEvent(this.timestamp);
//   @override
//   List<Object> get props => [timestamp];
// }

// class UpdateReceiptLotEvent extends CompletedReceiptLotEvent {
//   // String goodsReceiptLotId;
//   // String itemId;
//   // double quantity;
//   // double? sublotSize;
//   // String purchaseOrderNumber;
//   // String? locationId;
//   // DateTime? productionDate;
//   // DateTime? expirationDate;
//   ItemLot itemLot;
//   UpdateReceiptLotEvent(
//       // this.goodsReceiptLotId,
//       // this.itemId,
//       // this.quantity,
//       // this.sublotSize,
//       // this.purchaseOrderNumber,
//       // this.locationId,
//       // this.productionDate,
//       // this.expirationDate
//       this.itemLot);
//   @override
//   List<Object> get props => [];
// }

// class ConfirmReceiptChangedEvent extends CompletedReceiptLotEvent {
//   DateTime timestamp;
//   List<ItemLot> itemLots;
//   ConfirmReceiptChangedEvent(this.timestamp, this.itemLots);
//   @override
//   List<Object> get props => [timestamp];
// }
