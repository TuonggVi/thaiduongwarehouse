// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

abstract class UncompletedReceiptEvent extends Equatable {}

class LoadUncompletedGoodsReceiptEvent extends UncompletedReceiptEvent {
  DateTime timestamp;
  LoadUncompletedGoodsReceiptEvent(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}
