import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/other/item_lot_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/location_usecase.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/other/warning_stocklevel_events.dart';


import '../../../../domain/usecases/item_usecase.dart';
import '../../states/other/warning_states.dart';

class WarningBloc extends Bloc<WarningStockLevelEvent, WarningState> {
  ItemLotUsecase itemLotUsecase;
  ItemUsecase itemUsecase;
  LocationUsecase locationUsecase;
  WarningBloc(this.itemLotUsecase, this.itemUsecase, this.locationUsecase)
      : super(ExpirationWarningLoadingState(DateTime.now())) {
// cảnh báo hsd
    on<LoadExpirationWarningEvent>((event, emit) async {
      emit(ExpirationWarningLoadingState(DateTime.now()));
      try {
        final itemLot =
            await itemLotUsecase.getExpiredItemLots(event.expirationDate);
        itemLot.isNotEmpty
            ? emit(ExpirationWarningSuccessState(DateTime.now(), itemLot))
            : emit(ExpirationWarningFailState(
                DateTime.now(), 'Không có hàng hóa cảnh báo'));
      } catch (e) {
        emit(ExpirationWarningFailState(
            DateTime.now(), 'Không truy xuất được dữ liệu'));
      }
    });
    // hiển thị list bộ phận
    on<GetWarehouseEvent>((event, emit) async {
      emit(GetWarehouseLoadingState(DateTime.now()));
      try {
        final warehouse = await locationUsecase.getAllWarehouseId();
        
        emit(GetWarehouseSuccessState(DateTime.now(), warehouse));
      } catch (e) {
        emit(GetWarehouseFailState(DateTime.now(),const []));
      }
    });

    // cảnh báo số lượng tồn kho tối thiểu
    on<LoadMinimumStockWarningEvent>((event, emit) async {
      emit(MinimumStockWarningLoadingState(DateTime.now()));
      try {
        final itemLots =
            await itemLotUsecase.getUnderStockminItemLots(event.warehouseId);
        itemLots.isNotEmpty
            ? emit(MinimumStockWarningSuccessState(
                DateTime.now(),
                itemLots,
                event.warehouseId,
                event.listWarehouse,
                event.listWarehouse,
              ))
            : emit(MinimumStockWarningFailState(
                DateTime.now(), 'Không có hàng hóa cảnh báo', event.listWarehouse));
      } catch (e) {
        emit(ExpirationWarningFailState(
            DateTime.now(), 'Không truy xuất được dữ liệu'));
      }
    });
  }
}
