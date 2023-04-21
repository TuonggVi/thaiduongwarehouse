import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/goods_receipt_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/item_usecase.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/receipt_event/fill_info_receipt_lot_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/receipt_state/fill_info_receipt_lot_state.dart';

class FillReceiptLotBloc
    extends Bloc<FillInfoLotReceiptEvent, FillInfoReceiptLotState> {
  GoodsReceiptUsecase goodsReceiptUsecase;
  ItemUsecase itemUsecase;
  FillReceiptLotBloc(this.goodsReceiptUsecase, this.itemUsecase)
      : super(LoadItemDataLoadingState(DateTime.now())) {
    on<FillReceiptLotEvent>((event, emit) async {
      emit(LoadItemDataLoadingState(DateTime.now()));
      try {
        final items = await itemUsecase.getAllItem();

        emit(LoadItemDataSuccessState(
            items, event.goodsReceipt, event.index,event.function, DateTime.now()));
      } catch (e) {
        //emit(Load(DateTime.now()));
      }
    });
     
  }
}