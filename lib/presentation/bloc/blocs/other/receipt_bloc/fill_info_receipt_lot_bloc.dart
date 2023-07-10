import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/other/goods_receipt_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/item_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/location_usecase.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/other/receipt_event/fill_info_receipt_lot_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/other/receipt_state/fill_info_receipt_lot_state.dart';

import '../../../../../domain/entities/location.dart';

class FillReceiptLotBloc
    extends Bloc<FillInfoLotReceiptEvent, FillInfoReceiptLotState> {
  ItemUsecase itemUsecase;
  LocationUsecase locationUsecase;
  FillReceiptLotBloc(this.itemUsecase, this.locationUsecase)
      : super(LoadItemDataLoadingState(DateTime.now())) {
        // điền thông tin lô nhập kho
    on<FillReceiptLotEvent>((event, emit) async {
      emit(LoadItemDataLoadingState(DateTime.now()));
      try {
        final items = await itemUsecase.getAllItem();

        emit(LoadItemDataSuccessState(
            items,[], event.goodsReceipt, event.index, DateTime.now()));
      } catch (e) {
        //emit(Load(DateTime.now()));
      }
    });
    // sửa thông tin lô nhập kho
    on<RefillReceiptLotEvent>((event, emit) async {
            List<Location> locations = [];

      emit(LoadItemDataLoadingState(DateTime.now()));
      try {
        // final items = await itemUsecase.getAllItem();
        final warehouse = await locationUsecase.getAllWarehouseId();
          for (var element in warehouse) {
          locations = locations + element.locations;
        }
        emit(LoadItemDataSuccessState(
            [],locations, event.goodsReceipt, event.index, DateTime.now()));
      } catch (e) {
        //emit(Load(DateTime.now()));
      }
    });
  }
}