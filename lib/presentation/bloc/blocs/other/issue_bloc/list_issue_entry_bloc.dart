import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/other/goods_issue_usecase.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/other/issue_event/list_issue_entry_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/other/issue_state/list_entry_issue_state.dart';

class ListGoodsIssueEntryBloc extends Bloc<GoodsIssueEntryEvent, GoodsIssueEntryState> {
  GoodsIssueUseCase goodsIssueUseCase;
  ListGoodsIssueEntryBloc(this.goodsIssueUseCase):super(LoadGoodsIssueEntryLoadingState(DateTime.now())){
     on<LoadGoodsIssueEntryEvent>((event, emit) async {
      emit(LoadGoodsIssueEntryLoadingState(DateTime.now()));
      try {
        // final entries = await goodsIssueUseCase.getUncompletedGoodsIssue();
        // emit(LoadGoodsIssuesSuccessState( DateTime.now(), issues));
      } catch (e) {
        // emit(LoadReceiptExportingStateFail(
        //     DateTime.now(), 'Không truy xuất được dữ liệu'));
      }
    });
  }
}
