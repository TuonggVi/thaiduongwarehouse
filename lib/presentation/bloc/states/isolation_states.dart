// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/item.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/item_lot.dart';

abstract class IsolationState extends Equatable {}

// Lấy tất cả lô hàng
class GetAllItemSuccessState extends IsolationState {
  DateTime timestamp;
  List<Item> item;
  //List<Item> listItem;
  GetAllItemSuccessState(this.timestamp, this.item, 
  //this.listItem
  );
  @override
  List<Object> get props => [timestamp];
}

class GetAllItemLoadingState extends IsolationState {
  DateTime timestamp;
  GetAllItemLoadingState(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

class GetAllItemFailState extends IsolationState {
  DateTime timestamp;
  ErrorPackage status;
  GetAllItemFailState(this.timestamp, this.status);
  @override
  List<Object> get props => [timestamp];
}

// Chọn lô
class GetLotByItemIdSuccessState extends IsolationState {
  DateTime timestamp;
  String itemId;
  List <ItemLot> itemLots;
  //List<Item> listItem;
  GetLotByItemIdSuccessState(this.timestamp, this.itemId, this.itemLots,
  //this.listItem
   );
  @override
  List<Object> get props => [timestamp];
}

class GetLotByItemIdLoadingState extends IsolationState {
  DateTime timestamp;
  GetLotByItemIdLoadingState(
    this.timestamp,
  );
  @override
  List<Object> get props => [timestamp];
}

class GetLotByItemIdFailState extends IsolationState {
  DateTime timestamp;
  // ErrorPackage status;
  GetLotByItemIdFailState(this.timestamp, 
  // this.status
  );
  @override
  List<Object> get props => [timestamp];
}

// thêm hàng cách ly
class PostNewIsolationSuccessState extends IsolationState {
  DateTime timestamp;
  ErrorPackage status;
  PostNewIsolationSuccessState(this.timestamp, this.status);
  @override
  List<Object> get props => [timestamp];
}

class PostNewIsolationLoadingState extends IsolationState {
  DateTime timestamp;
  PostNewIsolationLoadingState(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

class PostNewIsolationFailState extends IsolationState {
  DateTime timestamp;
  ErrorPackage status;
  PostNewIsolationFailState(this.timestamp, this.status);
  @override
  List<Object> get props => [timestamp];
}


// Hiển thị danh sách hàng đang xử lý
class GetAllIsolationLotSuccessState extends IsolationState {
  DateTime timestamp;
  List<ItemLot> itemLot;
  GetAllIsolationLotSuccessState(this.timestamp, this.itemLot);
  @override
  List<Object> get props => [timestamp];
}

class GetAllIsolationLotLoadingState extends IsolationState {
  DateTime timestamp;
  GetAllIsolationLotLoadingState(this.timestamp);
  @override
  List<Object> get props => [timestamp];
}

class GetAllIsolationLotFailState extends IsolationState {
  DateTime timestamp;
  ErrorPackage status;
  GetAllIsolationLotFailState(this.timestamp, this.status);
  @override
  List<Object> get props => [timestamp];
}