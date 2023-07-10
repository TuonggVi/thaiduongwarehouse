// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/employee.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/item.dart';

class LotAdjustment extends Equatable {
  String? lotId;
  String? note;
  Employee? employee;
  DateTime? timestamp;
  double? afterQuantity;
  double? beforeQuantity;
  String? newPoNumber;
  String? oldPoNumber;
  Item? item;
  bool? isConfirmed;
  LotAdjustment(this.lotId, this.note, this.employee, this.timestamp, this.afterQuantity, this.beforeQuantity, this.oldPoNumber, this.newPoNumber, this.item, this.isConfirmed);
  @override
  List<Object?> get props => throw UnimplementedError();
}
