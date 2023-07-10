// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/finish_product/finished_product_issue.dart';


abstract class FillInfoProductIssueEntryEvent extends Equatable {}
// lấy thông tin trong phiếu nhập (PO, mã hàng, tên hàng)
class GetAllItemProductIssueEvent extends FillInfoProductIssueEntryEvent {
  DateTime timestamp;
  FinishedProductIssue finishedProductIssue;
  int index;
  GetAllItemProductIssueEvent( this.timestamp, this.finishedProductIssue, this.index);
  @override
  List<Object> get props => [timestamp];
}
