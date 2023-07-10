import 'package:equatable/equatable.dart';

abstract class ProductIssueEvent extends Equatable {}
// get đơn đã hoàn thành
class LoadProductIssuesEvent extends ProductIssueEvent {
final DateTime timestamp;
  LoadProductIssuesEvent(this.timestamp);
  @override
  List<Object?> get props => [timestamp];
}