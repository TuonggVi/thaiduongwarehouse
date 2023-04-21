// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/goods_issue.dart';

abstract class CreateNewIssueEvent extends Equatable {}
// class LoadItemsDataEvent extends CreateNewIssueEvent {
//   DateTime timestamp;
//   LoadItemsDataEvent(this.timestamp);
//   @override

//   List<Object?> get props => [timestamp];
// }

class LoadListDataEvent extends CreateNewIssueEvent {
  DateTime timestamp;
  List<IssueEntryView> entriesIssue;
  LoadListDataEvent(this.timestamp, this.entriesIssue);
  @override

  List<Object?> get props => [timestamp];
}

class AddIssueEntryEvent extends CreateNewIssueEvent {
  DateTime timestamp;
  // String issueId;
  // String receiver;
  // String poNumber;
  IssueEntryView issueEntry;
  List<IssueEntryView> issueEntries;
  AddIssueEntryEvent(
      this.issueEntry, this.issueEntries, this.timestamp);
  @override

  List<Object?> get props => [timestamp];
}

class UpdateIssueEntryEvent extends CreateNewIssueEvent {
  DateTime timestamp;
  // String issueId;
  // String receiver;
  // String poNumber;
  List<IssueEntryView> issueEntries;
  IssueEntryView issueEntry;
  int index;
  UpdateIssueEntryEvent(
      this.issueEntry, this.issueEntries, this.index, this.timestamp);
  @override

  List<Object?> get props => [timestamp];
}

class PostNewGoodsIssueEvent extends CreateNewIssueEvent {
  DateTime timestamp;
  List<IssueEntryView> issueEntries;
  PostNewGoodsIssueEvent(this.issueEntries, this.timestamp);
  @override
  
  List<Object?> get props => [timestamp];
}