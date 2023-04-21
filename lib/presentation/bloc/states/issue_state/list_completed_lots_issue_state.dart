// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/goods_issue.dart';

abstract class CompletedGoodsIssueLotState extends Equatable {}

class LoadCompletedGoodsIssueLotLoadingState extends CompletedGoodsIssueLotState {
  DateTime timestamp;
  LoadCompletedGoodsIssueLotLoadingState(this.timestamp);
  @override

  List<Object?> get props => [timestamp];
}

class LoadCompletedGoodsIssueLotSuccessState extends CompletedGoodsIssueLotState {
  DateTime timestamp;
  List<GoodsIssueLot> lots;
  LoadCompletedGoodsIssueLotSuccessState(this.timestamp, this.lots);
  @override

  List<Object?> get props => [timestamp];
}


class LoadCompletedGoodsIssueLotFailState extends CompletedGoodsIssueLotState {
  DateTime timestamp;
  LoadCompletedGoodsIssueLotFailState(this.timestamp);
  @override

  List<Object?> get props => [timestamp];
}


class UpdateGoodsIssueLotLoadingState extends CompletedGoodsIssueLotState {
  DateTime timestamp;
  UpdateGoodsIssueLotLoadingState(this.timestamp);
  @override
  
  List<Object?> get props => [timestamp];
}

class UpdateGoodsIssueLotSuccessState extends CompletedGoodsIssueLotState {
  DateTime timestamp;
  List<GoodsIssueLot> lots;
  UpdateGoodsIssueLotSuccessState(this.timestamp, this.lots);
  @override

  List<Object?> get props => [timestamp];
}


class UpdateGoodsIssueLotFailState extends CompletedGoodsIssueLotState {
  DateTime timestamp;
  UpdateGoodsIssueLotFailState(this.timestamp);
  @override

  List<Object?> get props => [timestamp];
}