// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/item_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/location_usecase.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/other/receipt_event/fill_info_receipt_lot_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/other/receipt_state/fill_info_receipt_lot_state.dart';


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
   
  }
}