// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';


abstract class IsolationEvent extends Equatable {}

// Lấy thông tin lô hàng
// class GetAllItemEvent extends IsolationEvent {
//   DateTime timestamp;
//   GetAllItemEvent(this.timestamp);
//   @override
//   List<Object> get props => [timestamp];
// }
// // List lô hàng theo mã sp
class GetLotByLotIdEvent extends IsolationEvent {
  DateTime timestamp;
  String lotId;
  GetLotByLotIdEvent(
    this.timestamp,
    this.lotId,
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

// Danh sách hàng hóa đang chờ xử lý
class GetAllIsolationLotEvent extends IsolationEvent {
  DateTime timestamp;
  GetAllIsolationLotEvent(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}
