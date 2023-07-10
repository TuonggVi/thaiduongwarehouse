// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

abstract class CompletedGoodsIssueEvent extends Equatable {}

class LoadCompletedGoodsIssuesEvent extends CompletedGoodsIssueEvent {
  DateTime timestamp;
  DateTime startDate;
  DateTime endDate;
  LoadCompletedGoodsIssuesEvent(this.timestamp, this.startDate, this.endDate);
  @override
  List<Object?> get props => [timestamp];
}
