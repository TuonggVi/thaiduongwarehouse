// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/item_lot.dart';

import '../../../domain/entities/item.dart';

abstract class ShelveState extends Equatable {}

// Hiển thị danh sách mã sp
class GetAllItemIdSuccessState extends ShelveState {
  DateTime timestamp;
  List<Item> items;
  GetAllItemIdSuccessState(this.timestamp, this.items);
  @override
  List<Object> get props => [timestamp];
}

class GetAllItemIdLoadingState extends ShelveState {
  DateTime timestamp;
  GetAllItemIdLoadingState(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

class GetAllItemIdFailState extends ShelveState {
  DateTime timestamp;
  GetAllItemIdFailState(
    this.timestamp,
  );
  @override
  List<Object> get props => [timestamp];
}

// Tìm kệ theo mã và tên sp
class GetLotByItemIdSuccessState extends ShelveState {
  DateTime timestamp;
  List<ItemLot> itemLot;
  List<Item> item;
  GetLotByItemIdSuccessState(this.timestamp, this.itemLot, this.item);
  @override
  List<Object> get props => [timestamp];
}

class GetLotByItemIdLoadingState extends ShelveState {
  DateTime timestamp;
  GetLotByItemIdLoadingState(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

class GetLotByItemIdFailState extends ShelveState {
  DateTime timestamp;
  String detail;
  GetLotByItemIdFailState(this.timestamp, this.detail);
  @override
  List<Object> get props => [timestamp];
}

// List vị trí
class GetAllLocationSuccessState extends ShelveState {
  DateTime timestamp;
  List<String> location;
  GetAllLocationSuccessState(this.timestamp, this.location);
  @override
  List<Object> get props => [timestamp];
}

class GetAllLocationLoadingState extends ShelveState {
  DateTime timestamp;
  GetAllLocationLoadingState(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

class GetAllLocationFailState extends ShelveState {
  DateTime timestamp;

  GetAllLocationFailState(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

// Hiển thị danh sách sản phẩm tìm kiếm
class GetLotByLocationSuccessState extends ShelveState {
  final DateTime timestamp;
  List<ItemLot> itemLot;
  List<String> listLocation;
  GetLotByLocationSuccessState(this.timestamp, this.itemLot, this.listLocation);
  @override
  List<Object> get props => [timestamp, itemLot];
}

class GetLotByLocationFailState extends ShelveState {
  DateTime timestamp;
  String detail;
  GetLotByLocationFailState(
    this.timestamp,
    this.detail,
  );
  @override
  List<Object> get props => [timestamp];
}

class GetLotByLocationLoadingState extends ShelveState {
  DateTime timestamp;
  GetLotByLocationLoadingState(
    this.timestamp,
  );
  @override
  List<Object> get props => [timestamp];
}
