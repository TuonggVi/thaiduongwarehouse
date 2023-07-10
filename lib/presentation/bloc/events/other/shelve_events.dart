// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/location.dart';

import '../../../../domain/entities/item.dart';

abstract class ShelveEvent extends Equatable {}

// List mã sản phẩm
class GetAllItemIdEvent extends ShelveEvent {
  DateTime timestamp;
  GetAllItemIdEvent(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

// Tìm kệ theo mã sản phẩm
class GetLotByItemIdEvent extends ShelveEvent {
  DateTime timestamp;
  String itemId;
  List<Item> listItem;
  GetLotByItemIdEvent(this.timestamp, this.itemId, this.listItem);
  @override
  List<Object> get props => [timestamp];
}

// List vị trí
class GetAllLocationEvent extends ShelveEvent {
  DateTime timestamp;
  GetAllLocationEvent(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

// Hiển thị danh sách tìm kiếm theo vị trí
class GetLotByLocationEvent extends ShelveEvent {
  DateTime timestamp;
  List<Location> listLocation;
  String locations;
  GetLotByLocationEvent(this.timestamp, this.listLocation, this.locations,);
  @override
  List<Object> get props => [timestamp];
}