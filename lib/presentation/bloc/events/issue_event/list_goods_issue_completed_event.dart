// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

abstract class CompletedGoodsIssueEvent extends Equatable {}

class LoadCompletedGoodsIssuesEvent extends CompletedGoodsIssueEvent {
  DateTime timestamp;
  LoadCompletedGoodsIssuesEvent(this.timestamp);
  @override
 
  List<Object?> get props => [timestamp];
}
