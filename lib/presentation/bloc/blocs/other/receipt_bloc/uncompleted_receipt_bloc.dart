import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/other/goods_receipt_usecase.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/other/receipt_event/uncompleted_receipt_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/other/receipt_state/uncomplted_receipt_state.dart';

class ExportingReceiptBloc
    extends Bloc<UncompletedReceiptEvent, ReceiptExportingState> {
  GoodsReceiptUsecase goodsReceiptUsecase;
  ExportingReceiptBloc(this.goodsReceiptUsecase)
      : super(LoadingReceiptExportingState(DateTime.now())) {
        // load phiếu chưa hoàn thành
    on<LoadUncompletedGoodsReceiptEvent>((event, emit) async {
      emit(LoadingReceiptExportingState(DateTime.now()));
      try {
        final receipts =
            await goodsReceiptUsecase.getUnCompletedGoodsReceipts();
        receipts.isNotEmpty
            ? emit(LoadReceiptExportingStateSuccess(DateTime.now(), receipts))
            : emit(LoadReceiptExportingStateFail(
                DateTime.now(), 'Chưa có đơn được nhập'));
      } catch (e) {
        emit(LoadReceiptExportingStateFail(
            DateTime.now(), 'Không truy xuất được dữ liệu'));
      }
    });
  }
}
