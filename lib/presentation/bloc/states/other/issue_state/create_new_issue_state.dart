// ignore_for_file: must_be_immutable, overridden_fields, annotate_overrides

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/goods_issue.dart';


abstract class CreaNewIssueState extends Equatable {
  GoodsIssue? goodsIssue;
  CreaNewIssueState(this.goodsIssue);
}

class CreateNewIssueInitialState extends CreaNewIssueState {
  CreateNewIssueInitialState(super.goodsIssue);

  @override
  List<Object?> get props => throw UnimplementedError();
}

// class LoadItemDataLoadingState extends CreaNewIssueState {
//   DateTime timestamp;
//   LoadItemDataLoadingState(this.timestamp);

//   @override
//   List<Object?> get props => [timestamp];
// }

// class LoadItemDataSuccessState extends CreaNewIssueState {
//   DateTime timestamp;
//   List<Item> items;
//   LoadItemDataSuccessState(this.items, this.timestamp);
//   @override
//   List<Object?> get props => [timestamp];
// }

// class LoadItemDataFailState extends CreaNewIssueState {
//   DateTime timestamp;
//   LoadItemDataFailState(this.timestamp);

//   @override
//   List<Object?> get props => [timestamp];
// }

// class LoadDepartmentLoadingState extends CreaNewIssueState {
//   DateTime timestamp;
//   LoadDepartmentLoadingState(this.timestamp) : super(null);

//   @override
//   List<Object?> get props => [timestamp];
// }

// class LoadListDataSuccessState extends CreaNewIssueState {
//   List<Department> departments;
//   List<String> listPo;
//   DateTime timestamp;
//   List<GoodsIssueEntry> issueEntries;
//   LoadListDataSuccessState(
//       this.departments, this.issueEntries, this.listPo, this.timestamp)
//       : super(null);
//   @override
//   List<Object?> get props => [timestamp];
// }

// thêm entry vào phiếu nhập
class UpdateEntryToGoodsIssueLoading extends CreaNewIssueState {
  DateTime timestamp;
  UpdateEntryToGoodsIssueLoading(this.timestamp) : super(null);

  @override
  List<Object?> get props => [timestamp];
}

class UpdateEntryToGoodsIssueSuccess extends CreaNewIssueState {
  DateTime timestamp;
  GoodsIssue? goodsIssue;

  UpdateEntryToGoodsIssueSuccess(this.timestamp, this.goodsIssue)
      : super(goodsIssue);
  @override
  List<Object?> get props => [timestamp];
}

class UpdateEntryToGoodsIssueFailState extends CreaNewIssueState {
  DateTime timestamp;
  GoodsIssue? goodsIssue;
  UpdateEntryToGoodsIssueFailState(this.timestamp, this.goodsIssue) : super(goodsIssue);
  @override
  List<Object?> get props => [timestamp];
}

//--------------------
class PostNewGoodsIssueLoadingState extends CreaNewIssueState {
  DateTime timestamp;
  PostNewGoodsIssueLoadingState(this.timestamp) : super(null);
  @override
  List<Object?> get props => [timestamp];
}

class PostNewGoodsIssueSuccessState extends CreaNewIssueState {
  DateTime timestamp;
  String detail;
  GoodsIssue? goodsIssue;
  PostNewGoodsIssueSuccessState(this.timestamp, this.detail, this.goodsIssue)
      : super(goodsIssue);
  @override
  List<Object?> get props => [timestamp];
}

class PostNewGoodsIssueFailState extends CreaNewIssueState {
  DateTime timestamp;
  String detail;
  GoodsIssue? goodsIssue;
  PostNewGoodsIssueFailState(this.timestamp, this.detail, this.goodsIssue)
      : super(goodsIssue);
  @override
  List<Object?> get props => [timestamp];
}
