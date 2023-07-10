// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

abstract class CompletedReceiptEvent extends Equatable {
  
}

class LoadCompletedGoodsReceiptEvent extends CompletedReceiptEvent {
  DateTime timestamp;
  DateTime startdate;
  DateTime enddate;
  LoadCompletedGoodsReceiptEvent(this.timestamp, this.startdate, this.enddate);
  @override
  List<Object> get props => [timestamp];
}
