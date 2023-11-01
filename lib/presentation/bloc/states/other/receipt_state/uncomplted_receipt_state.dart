// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/goods_receipt.dart';

class ReceiptExportingState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoadingReceiptExportingState extends ReceiptExportingState {
  DateTime timestamp;
  LoadingReceiptExportingState(this.timestamp, );
  @override
  List<Object?> get props => [timestamp];
}
class LoadReceiptExportingStateFail extends ReceiptExportingState {
  DateTime timestamp;
  String detail;
  LoadReceiptExportingStateFail(this.timestamp, this.detail);
  @override
  List<Object?> get props => [timestamp];
}

class LoadReceiptExportingStateSuccess extends ReceiptExportingState {
  DateTime timestamp;
  List<GoodsReceipt> receipts;
  LoadReceiptExportingStateSuccess(this.timestamp, this.receipts);
  @override
  List<Object?> get props => [timestamp];

  get goodsReceipt => null;
}
//---------------

class UpdateLotReceiptStateLoading extends ReceiptExportingState {
  DateTime timestamp;
  UpdateLotReceiptStateLoading(this.timestamp);
  @override
  List<Object?> get props => [timestamp];
}

class UpdateLotReceiptStateSuccess extends ReceiptExportingState {
  DateTime timestamp;
  UpdateLotReceiptStateSuccess(this.timestamp);
  @override
  List<Object?> get props => [timestamp];
}

class UpdateLotReceiptStateFail extends ReceiptExportingState {
  DateTime timestamp;
  String detail;
  UpdateLotReceiptStateFail(this.timestamp, this.detail);
  @override
  List<Object?> get props => [timestamp];
}