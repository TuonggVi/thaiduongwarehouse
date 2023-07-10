// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

import '../../../../../domain/entities/finish_product/finished_product_issue.dart';
import '../../../../../domain/entities/finish_product/finished_product_issue_entry.dart';

abstract class CreateProductIssueEvent extends Equatable {}
//thêm 1 entry mới
class AddProductIssueEntryEvent extends CreateProductIssueEvent {
  DateTime timestamp;
  FinishedProductIssueEntry finishedProductIssueEntry;
  FinishedProductIssue finishedProductIssue;
  AddProductIssueEntryEvent(this.finishedProductIssueEntry, this.finishedProductIssue, this.timestamp);
  @override
  List<Object?> get props => [timestamp];
}

// cập nhật entry cũ
class UpdateIssueEntryEvent extends CreateProductIssueEvent {
  DateTime timestamp;

  FinishedProductIssue finishedProductIssue;
  FinishedProductIssueEntry finishedProductIssueEntry;
  int index;
  UpdateIssueEntryEvent(
      this.finishedProductIssueEntry, this.finishedProductIssue, this.index, this.timestamp);
  @override
  List<Object?> get props => [timestamp];
}

// load lại danh sách entry
class LoadIssueEntryEvent extends CreateProductIssueEvent {
  DateTime timestamp;
  FinishedProductIssue finishedProductIssue;
  LoadIssueEntryEvent(this.finishedProductIssue, this.timestamp);
  @override
  List<Object?> get props => [timestamp];
}

// post 1 đơn mới
class PostNewFinishedProductIssueEvent extends CreateProductIssueEvent {
  DateTime timestamp;
  FinishedProductIssue finishedProductIssue;
  PostNewFinishedProductIssueEvent(this.finishedProductIssue, this.timestamp);
  @override
  List<Object?> get props => [timestamp];
}
class UpdateIssueFailEvent extends CreateProductIssueEvent {
  DateTime timestamp;
  FinishedProductIssue finishedProductIssue;
  
  UpdateIssueFailEvent(
      this.finishedProductIssue,  this.timestamp);
  @override
  List<Object?> get props => [timestamp];
}