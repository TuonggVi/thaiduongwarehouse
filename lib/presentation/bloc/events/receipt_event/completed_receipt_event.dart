// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

abstract class CompletedReceiptEvent extends Equatable {
  
}

class LoadCompletedGoodsReceiptEvent extends CompletedReceiptEvent {
  DateTime timestamp;
  DateTime startDate;
  DateTime endDate;
  LoadCompletedGoodsReceiptEvent(this.timestamp, this.startDate, this.endDate);
  @override
  List<Object> get props => [timestamp];
}
