import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/location.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/item_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/other/item_lot_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/location_usecase.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/other/shelve_events.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/other/shelve_states.dart';

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


    on<GetLotByItemIdEvent>((event, emit) async {
      emit(GetLotByItemIdLoadingState(DateTime.now()));
      try {
        final itemLot = await itemLotUsecase.getItemLotsByItemId(event.itemId);
        itemLot.isNotEmpty
            ? emit(GetLotByItemIdSuccessState(DateTime.now(), itemLot,
                event.itemId, event.listItem))
            : emit(GetLotByItemIdFailState(DateTime.now(), '', event.listItem));
      } catch (e) {
        emit(GetLotByItemIdFailState(
            DateTime.now(), 'Không truy xuất được dữ liệu', event.listItem));
      }
    });

    on<GetAllLocationEvent>((event, emit) async {
      List<Location> locations = [];

      emit(GetAllLocationLoadingState(DateTime.now()));
      try {
        final warehouse = await locationUsecase.getAllWarehouseId();

        for (var element in warehouse) {
          locations = locations + element.locations;
        }
        emit(GetAllLocationSuccessState(DateTime.now(), locations));
      } catch (e) {
        emit(GetAllLocationFailState(DateTime.now(),));
      }
    });

    on<GetLotByLocationEvent>((event, emit) async {
      emit(GetLotByLocationLoadingState(DateTime.now()));
      try {
        final itemLot =
            await itemLotUsecase.getItemLotsByLocation(event.locations);
        itemLot.isNotEmpty
            ? emit(GetLotByLocationSuccessState(DateTime.now(), itemLot,
                event.listLocation))
            : emit(GetLotByLocationFailState(
                DateTime.now(), 'Không có lô ở vị trí này', event.listLocation));
      } catch (e) {
        emit(GetLotByLocationFailState(
            DateTime.now(), 'Không truy xuất được dữ liệu', event.listLocation));
      }
    });
  }
}
