import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/goods_issue_usecase.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/issue_event/list_goods_issue_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/issue_state/list_goods_issue_state.dart';

class ListGoodsIssueUncompletedBloc
    extends Bloc<GoodsIssueEvent, GoodsIssueState> {
  GoodsIssueUseCase goodsIssueUseCase;
  ListGoodsIssueUncompletedBloc(this.goodsIssueUseCase)
      : super(LoadGoodsIssuesLoadingState(DateTime.now())) {
    on<LoadGoodsIssuesEvent>((event, emit) async {
      emit(LoadGoodsIssuesLoadingState(DateTime.now()));
      try {
        final issues = await goodsIssueUseCase.getUncompletedGoodsIssue();
        emit(LoadGoodsIssuesSuccessState( DateTime.now(), issues));
      } catch (e) {
        // emit(LoadReceiptExportingStateFail(
        //     DateTime.now(), 'Không truy xuất được dữ liệu'));
      }
    });
  }
}