// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/employee.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/item.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/location.dart';

class LotAdjustment extends Equatable {
  String? lotId;
  String? note;
  Employee? employee;
  DateTime? timestamp;
  double? afterQuantity;
  double? beforeQuantity;
  List<ItemLotSublot> itemLotSublot;
  Item? item;
  bool? isConfirmed;
  LotAdjustment(this.lotId, this.note, this.employee, this.timestamp, this.afterQuantity, this.beforeQuantity,this.itemLotSublot, this.item, this.isConfirmed);
  @override
  List<Object?> get props => throw UnimplementedError();
}
