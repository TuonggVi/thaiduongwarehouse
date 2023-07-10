import 'package:equatable/equatable.dart';
import '../../../../../domain/entities/finish_product/finished_product_issue.dart';

abstract class ProductIssueLotCompletedEvent extends Equatable {}
// load lô hàng trong phiếu nhập kho đã hoàn thành
class LoadProductIssueLotCompletedEvent extends ProductIssueLotCompletedEvent {
  final DateTime timestamp;
  final FinishedProductIssue finishedProductIssue;
  LoadProductIssueLotCompletedEvent(this.timestamp, this.finishedProductIssue);
  @override
  List<Object?> get props => [timestamp];
}

// cập nhật lô trong phiếu nhập kho đã hoàn thành 
class UpdateProductIssueLotEvent extends ProductIssueLotCompletedEvent {
  final DateTime timestamp;
  UpdateProductIssueLotEvent(this.timestamp);
  @override
  List<Object?> get props => [timestamp];
}
