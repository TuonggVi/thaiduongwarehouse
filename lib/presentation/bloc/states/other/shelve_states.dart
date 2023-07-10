// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/item_lot.dart';

import '../../../../domain/entities/item.dart';
import '../../../../domain/entities/location.dart';

abstract class ShelveState extends Equatable {
  List<Location> location;
  List<Item> items;
  List<ItemLot> itemLot;
  ShelveState(this.items, this.location, this.itemLot);
}

// Hiển thị danh sách mã sp
class GetAllItemIdSuccessState extends ShelveState {
  DateTime timestamp;
  List<Item> items;
  GetAllItemIdSuccessState(this.timestamp, this.items) : super(items, [],[]);
  @override
  List<Object> get props => [timestamp];
}

class GetAllItemIdLoadingState extends ShelveState {
  DateTime timestamp;
  GetAllItemIdLoadingState(this.timestamp) : super([],[],[]);
  @override
  List<Object> get props => [timestamp];
}

class GetAllItemIdFailState extends ShelveState {
  DateTime timestamp;
  GetAllItemIdFailState(
    this.timestamp
  ) : super([], [],[]);
  @override
  List<Object> get props => [timestamp];
}

// Tìm kệ theo mã và tên sp
class GetLotByItemIdSuccessState extends ShelveState {
  DateTime timestamp;
  String itemId;
  List<ItemLot> itemLot;
  List<Item> listItem;
  GetLotByItemIdSuccessState(
      this.timestamp, this.itemLot, this.itemId, this.listItem) : super(listItem, [], itemLot);
  @override
  List<Object> get props => [timestamp];
}

class GetLotByItemIdLoadingState extends ShelveState {
  DateTime timestamp;
  GetLotByItemIdLoadingState(this.timestamp) : super([], [],[]);
  @override
  List<Object> get props => [timestamp];
}

class GetLotByItemIdFailState extends ShelveState {
  DateTime timestamp;
  String detail;
 List<Item> listItem;
  GetLotByItemIdFailState(this.timestamp, this.detail,this.listItem) : super(listItem, [],[]);
  @override
  List<Object> get props => [timestamp];
}

// List vị trí
class GetAllLocationSuccessState extends ShelveState {
  DateTime timestamp;
  List<Location> location;
  GetAllLocationSuccessState(this.timestamp, this.location) : super([], location,[]);
  @override
  List<Object> get props => [timestamp];
}

class GetAllLocationLoadingState extends ShelveState {
  DateTime timestamp;
  GetAllLocationLoadingState(this.timestamp) : super([], [],[]);
  @override
  List<Object> get props => [timestamp];
}

class GetAllLocationFailState extends ShelveState {
  DateTime timestamp;
  GetAllLocationFailState(this.timestamp) : super([], [],[]);
  @override
  List<Object> get props => [timestamp];
}

// Hiển thị danh sách sản phẩm tìm kiếm
class GetLotByLocationSuccessState extends ShelveState {
  final DateTime timestamp;
  List<ItemLot> itemLot;
  List<Location> listLocation;
  GetLotByLocationSuccessState(
      this.timestamp, this.itemLot, this.listLocation) : super([], listLocation,itemLot);
  @override
  List<Object> get props => [timestamp, itemLot];
}

class GetLotByLocationFailState extends ShelveState {
  DateTime timestamp;
  String detail;
  List<Location> location;
  GetLotByLocationFailState(
    this.timestamp,
    this.detail,
    this.location
  ) : super([], location,[]);
  @override
  List<Object> get props => [timestamp];
}

class GetLotByLocationLoadingState extends ShelveState {
  DateTime timestamp;
  GetLotByLocationLoadingState(
    this.timestamp,
  ) : super([], [],[]);
  @override
  List<Object> get props => [timestamp];
}
