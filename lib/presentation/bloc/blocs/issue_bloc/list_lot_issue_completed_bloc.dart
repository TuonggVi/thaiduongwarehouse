import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/goods_issue_usecase.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/issue_event/list_lot_issue_completed_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/issue_state/list_completed_lots_issue_state.dart';

class ListGoodsIssueLotCompletedBloc extends Bloc<GoodsIssueLotCompletedEvent, CompletedGoodsIssueLotState> {
  GoodsIssueUseCase goodsIssueUseCase;
  ListGoodsIssueLotCompletedBloc(this.goodsIssueUseCase):super(LoadCompletedGoodsIssueLotLoadingState(DateTime.now())){
      on<LoadGoodsIssueLotCompletedEvent>((event, emit) async {
      emit(LoadCompletedGoodsIssueLotLoadingState(DateTime.now()));
      try {
         emit(LoadCompletedGoodsIssueLotSuccessState(
            DateTime.now(), event.lotsExpected));
      } catch (e) {
        
        // emit(LoadReceiptExportingStateFail(
        //     DateTime.now(), 'Không truy xuất được dữ liệu'));
      }
    });
  }
}