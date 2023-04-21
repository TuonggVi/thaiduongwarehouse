import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/goods_receipt_usecase.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/receipt_event/completed_receipt_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/receipt_state/completed_receipt_state.dart';

class CompletedReceiptBloc
    extends Bloc<CompletedReceiptEvent, CompletedReceiptState> {
  GoodsReceiptUsecase goodsReceiptUsecase;
  CompletedReceiptBloc(this.goodsReceiptUsecase)
  :super(CompletedReceiptInitState(DateTime.now())){
      on<LoadCompletedGoodsReceiptEvent>((event, emit) async {
      emit(LoadingReceiptCompletedState(DateTime.now()));
      try {
            final receipts =
            await goodsReceiptUsecase.getCompletedGoodsReceipts();
        receipts.isNotEmpty
            ? emit(LoadReceiptCompletedStateSuccess(DateTime.now(), await goodsReceiptUsecase.getCompletedGoodsReceipts()))
            : emit(LoadReceiptCompletedStateFail(
                DateTime.now(), 'Chưa có đơn được nhập'));
      } catch (e) {
        emit(LoadReceiptCompletedStateFail(
            DateTime.now(), 'Không truy xuất được dữ liệu'));
      }
    });
  }
}
