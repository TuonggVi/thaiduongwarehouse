// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

abstract class GoodsIssueEvent extends Equatable {}

class LoadGoodsIssuesEvent extends GoodsIssueEvent {
  DateTime timestamp;
  LoadGoodsIssuesEvent(this.timestamp);
  @override

  List<Object?> get props => [timestamp];
}
