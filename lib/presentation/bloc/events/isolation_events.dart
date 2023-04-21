// ignore_for_file: must_be_immutable, unused_import
import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/item_lot.dart';

import '../../../domain/entities/item.dart';

abstract class IsolationEvent extends Equatable {}
// Lấy thông tin lô hàng
class GetAllItemEvent extends IsolationEvent {
  DateTime timestamp;
  GetAllItemEvent(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}
// List lô hàng theo mã sp
class GetLotByItemIdEvent extends IsolationEvent {
 DateTime timestamp;
 String itemId;
 //List<Item> listItem;
  GetLotByItemIdEvent(this.timestamp, this.itemId, 
//  this.listItem
  );
  @override
  List<Object> get props => [timestamp];
}
// Chọn lô hàng cách ly
class PostNewIsolationEvent extends IsolationEvent {
  DateTime timestamp;
  String lotId;
  PostNewIsolationEvent(this.timestamp, this.lotId);
  @override
  List<Object> get props => [timestamp];
}

// // Xác nhận cách ly hàng hóa
// class ConfirmIsolationEvent extends IsolationEvent {
//   DateTime timestamp;
//   String lotId;
//   ConfirmIsolationEvent(
//     this.timestamp,
//     this.lotId
//   );
//   @override
//   List<Object> get props => [timestamp];
// }

// Danh sách hàng hóa đang chờ xử lý
class GetAllIsolationLotEvent extends IsolationEvent {
  DateTime timestamp;
  GetAllIsolationLotEvent(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}