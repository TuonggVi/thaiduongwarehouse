import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/other/goods_receipt_usecase.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/other/receipt_event/completed_receipt_lot_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/other/receipt_state/completed_receipt_lot_state.dart';

class CompletedReceiptLotBloc
    extends Bloc<CompletedReceiptLotEvent, CompletedReceiptLotState> {
  GoodsReceiptUsecase goodsReceiptUsecase;
  CompletedReceiptLotBloc(this.goodsReceiptUsecase)
      : super(CompletedReceiptLotLoadingState(DateTime.now())) {
    on<LoadReceiptLotCompletedEvent>((event, emit) async {
      emit(LoadGoodsReceiptLotSuccessState(event.goodsReceipt, DateTime.now()));
    });
   
  }
}
