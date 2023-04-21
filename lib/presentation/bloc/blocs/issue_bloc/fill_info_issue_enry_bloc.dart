import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/goods_issue_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/item_usecase.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/issue_event/fill_info_issue_entry_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/issue_state/fill_info_lot_issue_state.dart';

class FillInfoIssueEntryBloc
    extends Bloc<FillInfoIssueEntryEvent, FillInfoIssueEntryState> {
  GoodsIssueUseCase goodsIssueUseCase;
  ItemUsecase itemUsecase;
  FillInfoIssueEntryBloc(this.goodsIssueUseCase, this.itemUsecase)
      : super(LoadItemDataLoadingState(DateTime.now())) {
    on<GetAllItemIssueEvent>((event, emit) async {
      emit(LoadItemDataLoadingState(DateTime.now()));
      try {
        final items = await itemUsecase.getAllItem();

        emit(LoadItemDataSuccessState(
           items, event.entries, event.index, DateTime.now()));
      } catch (e) {
        //emit(Load(DateTime.now()));
      }
    });
  }
}