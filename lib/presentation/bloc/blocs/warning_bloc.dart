
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/item_lot_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/location_usecase.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/warning_events.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/warning_states.dart';

import '../../../domain/usecases/item_usecase.dart';

class WarningBloc extends Bloc<WarningEvent, WarningState> {
  ItemLotUsecase itemLotUsecase;
  ItemUsecase itemUsecase;
  LocationUsecase locationUsecase;
  WarningBloc(this.itemLotUsecase,this.itemUsecase, this.locationUsecase)
      : super(ExpirationWarningLoadingState(DateTime.now())) 
      {
// cảnh báo hsd 
    on<ExpirationWarningEvent>((event, emit) async {
      emit(ExpirationWarningLoadingState(DateTime.now()));
      try {
        final itemLot = await itemLotUsecase.getExpiredItemLots(DateTime.now());
        itemLot.isNotEmpty
            ? emit(ExpirationWarningSuccessState(DateTime.now(), itemLot))
            : emit(ExpirationWarningFailState(
                DateTime.now(), 'Chưa có lô được nhập'));
      } catch (e) {
        emit(ExpirationWarningFailState(
            DateTime.now(), 'Không truy xuất được dữ liệu'));
      }
    });
    // hiển thị list bộ phận
   on<GetWarehouseEvent>((event, emit) async {
      emit(GetWarehouseLoadingState(DateTime.now()));
      try {
        final warehouse = await locationUsecase.getAllWarehouse();
        emit(GetWarehouseSuccessState(DateTime.now(), warehouse));
      } catch (e) {
        emit(GetWarehouseFailState(DateTime.now()));
      }
    });
 
  // cảnh báo số lượng tồn kho tối thiểu
   on<MinimumStockWarningEvent>((event, emit) async {
      emit(MinimumStockWarningLoadingState(DateTime.now()));
      try {
        final itemLots = await itemLotUsecase.getUnderStockminItemLots(event.warehouseId);
        itemLots.isNotEmpty
            ? emit(MinimumStockWarningSuccessState(DateTime.now(), itemLots, event.listWarehouse,
            ))
            : emit(MinimumStockWarningFailState(
                DateTime.now(), ''));
      } catch (e) {
        emit(ExpirationWarningFailState(
            DateTime.now(), 'Không truy xuất được dữ liệu'));
      }
    });  
  }
}
