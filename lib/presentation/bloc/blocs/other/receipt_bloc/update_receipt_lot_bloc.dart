// ignore_for_file: prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../domain/usecases/item_usecase.dart';
import '../../../../../domain/usecases/other/goods_receipt_usecase.dart';
import '../../../events/other/receipt_event/update_receipt_lot_event.dart';
import '../../../states/other/receipt_state/update_receipt_lot_states.dart';

class GoodsReceiptSublotBloc
    extends Bloc<UpdateGoodsReceiptLotEvent, UpdateReceiptLotState> {
  ItemUsecase itemUsecase;
  GoodsReceiptUsecase goodsReceiptUsecase;
  GoodsReceiptSublotBloc(this.itemUsecase, this.goodsReceiptUsecase)
      : super(ReceiptLotInitState(DateTime.now())) {
    on<RefillReceiptLotEvent>((event, emit) async {
      emit(LoadItemDataUpdateLoadingState(DateTime.now()));
      try {
        final items = await itemUsecase.getAllItem();
        emit(LoadItemDataUpdateSuccessState(event.index, [], event.goodsReceipt,
            event.goodsReceipt.lots[event.index], DateTime.now()));
      } catch (e) {
        emit(LoadItemDataUpdateLoadingState(DateTime.now()));
      }
    });

    on<AddGoodsReceiptSublotEvent>((event, emit) async {
      emit(AddGoodsReceiptSublotLoadingState(DateTime.now(),
          event.goodsReceiptLot, event.goodsReceiptSublotModel));

      try {
        event.goodsReceiptLot.goodsReceiptSublots
            .add(event.goodsReceiptSublotModel);

        emit(AddGoodsReceiptSublotSuccessState(event.index, event.goodsReceipt,
            event.goodsReceiptLot, event.item, DateTime.now()));
      } catch (e) {
        // emit(UpdateLotReceiptStateSuccess(DateTime.now(), event.goodsReceipt));
        // emit(LoginStateLoginFailure(DateTime.now()));
      }
    });
    on<RemoveGoodsReceiptSublotEvent>((event, emit) async {
      emit(RemoveReceiptSublotLoadingState(DateTime.now()));
      try {
        event.goodsReceiptLot.goodsReceiptSublots
            .removeWhere((sublot) => sublot == event.goodsReceiptSublotModel);
        emit(RemoveReceiptSublotSuccessState(event.index, event.goodsReceipt,
            event.goodsReceiptLot, event.item, DateTime.now()));
      } catch (e) {
        // emit(UpdateLotReceiptStateSuccess(DateTime.now(), event.goodsReceipt));
        // emit(LoginStateLoginFailure(DateTime.now()));
      }
    });
  }
}
