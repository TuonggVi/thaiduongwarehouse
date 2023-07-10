import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/item_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/location_usecase.dart';

import '../../../../../domain/entities/location.dart';
import '../../../events/other/receipt_event/add_receipt_lot_event.dart';
import '../../../states/other/receipt_state/add_new_receipt_lot_state.dart';

class FillInfoNewReceiptLotBloc
    extends Bloc<FillInfoNewLotReceiptEvent, FillInfoNewReceiptLotState> {
  ItemUsecase itemUsecase;
  LocationUsecase locationUsecase;
  FillInfoNewReceiptLotBloc(this.itemUsecase, this.locationUsecase)
      : super(LoadNewItemDataLoadingState(DateTime.now())) {
    // điền thông tin lô nhập kho
    on<FillNewReceiptLotEvent>((event, emit) async {
      emit(LoadNewItemDataLoadingState(DateTime.now()));
      try {
        final items = await itemUsecase.getAllItem();

        emit(LoadNewItemDataSuccessState(
            items,[], event.goodsReceipt, event.index, DateTime.now()));
      } catch (e) {
        //emit(Load(DateTime.now()));
      }
    });
    // sửa thông tin lô nhập kho
    on<RefillNewReceiptLotEvent>((event, emit) async {
            List<Location> locations = [];

      emit(LoadNewItemDataLoadingState(DateTime.now()));
      try {
        // final items = await itemUsecase.getAllItem();
        final warehouse = await locationUsecase.getAllWarehouseId();
          for (var element in warehouse) {
          locations = locations + element.locations;
        }
        emit(LoadNewItemDataSuccessState(
            [],locations, event.goodsReceipt, event.index, DateTime.now()));
      } catch (e) {
        //emit(Load(DateTime.now()));
      }
    });
  }
}