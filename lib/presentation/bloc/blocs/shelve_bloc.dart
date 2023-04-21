
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/item_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/item_lot_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/location_usecase.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/shelve_events.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/shelve_states.dart';

class ShelveBloc extends Bloc<ShelveEvent, ShelveState> {
  ItemUsecase itemUsecase;
  ItemLotUsecase itemLotUsecase;
  LocationUsecase locationUsecase;
  ShelveBloc(this.itemUsecase, this.locationUsecase, this.itemLotUsecase)
      : super(GetAllItemIdLoadingState(DateTime.now())) {
    on<GetAllItemIdEvent>((event, emit) async {
      emit(GetAllItemIdLoadingState(DateTime.now()));
      try {
        final items = await itemUsecase.getAllItem();
        emit(GetAllItemIdSuccessState(DateTime.now(), items));
      } catch (e) {
        //emit(Load(DateTime.now()));
      }
    });

// lọc sản phẩm theo id
    on<GetLotByItemIdEvent>((event, emit) async {
      emit(GetLotByItemIdLoadingState(DateTime.now()));
      try {
        final itemLot = await itemLotUsecase.getItemLotsByItemId(event.itemId);
        itemLot.isNotEmpty
            ? emit(GetLotByItemIdSuccessState(DateTime.now(), itemLot, event.item))
            : emit(GetLotByItemIdFailState(
                DateTime.now(), ''));
      } catch (e) {
        emit(GetLotByItemIdFailState(
            DateTime.now(), 'Không truy xuất được dữ liệu'));
      }
    });
    // lấy list vị trí
    on<GetAllLocationEvent>((event, emit) async {
      emit(GetAllLocationLoadingState(DateTime.now()));
      try {
        final locationIds = await locationUsecase.getAllLocationId();
        emit(GetAllLocationSuccessState(DateTime.now(), locationIds));
      } catch (e) {
        emit(GetAllLocationFailState(DateTime.now()));
      }
    });
    // lọc lô theo vị trí
    on<GetLotByLocationEvent>((event, emit) async {
      emit(GetLotByLocationLoadingState(DateTime.now()));
      try {
        final itemLot =
            await itemLotUsecase.getItemLotsByLocation(event.location);
        itemLot.isNotEmpty
            ? emit(GetLotByLocationSuccessState(DateTime.now(), itemLot, event.listLocation))
            : emit(GetLotByLocationFailState(
                DateTime.now(), 'Không có lô ở vị trí này'));
      } catch (e) {
        emit(GetLotByLocationFailState(
            DateTime.now(), 'Không truy xuất được dữ liệu'));
      }
    });
  }
}
