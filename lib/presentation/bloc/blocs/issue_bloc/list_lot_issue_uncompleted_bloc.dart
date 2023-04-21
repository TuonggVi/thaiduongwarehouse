import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/goods_issue_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/item_lot_usecase.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/issue_event/list_lot_issue_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/issue_state/list_lot_issue_state.dart';

class ListGoodsIssueLotUncompletedBloc
    extends Bloc<GoodsIssueLotEvent, GoodsIssueLotState> {
  GoodsIssueUseCase goodsIssueUseCase;
  ItemLotUsecase itemLotUsecase;
  ListGoodsIssueLotUncompletedBloc(this.goodsIssueUseCase, this.itemLotUsecase)
      : super(LoadingGoodsIssueLotsState(DateTime.now())) {
    on<LoadGoodsIssueLotEvent>((event, emit) async {
      emit(LoadingGoodsIssueLotsState(DateTime.now()));
      try {
        final itemLotsSuggest =
            await itemLotUsecase.getItemLotsByItemId(event.itemId);
        emit(LoadGoodsIssueLotsSuccessState(
            DateTime.now(), itemLotsSuggest, event.lotsExpected));
      } catch (e) {
        emit(LoadGoodsIssueLotsFailState(DateTime.now()));
        // emit(LoadReceiptExportingStateFail(
        //     DateTime.now(), 'Không truy xuất được dữ liệu'));
      }
    });
    on<AddGoodsIssueLotEvent>((event, emit) async {
      bool check = true;
      emit(LoadingGoodsIssueLotsState(DateTime.now()));
      try {
        for (var element in event.listLotsSuggest) {
          if (element.lotId == event.goodsIssueLot.goodsIssueLotId) {
            element.quantity = element.quantity - event.goodsIssueLot.quantity;
          }
        }
        event.listLotsSuggest = event.listLotsSuggest
          ..removeWhere((element) => element.quantity == 0);

        if (event.listLotExpected.isNotEmpty) {
          for (var element in event.listLotExpected) {
            if (element.goodsIssueLotId ==
                event.goodsIssueLot.goodsIssueLotId) {
              element.quantity =
                  (element.quantity + event.goodsIssueLot.quantity);
              check = false;
            }
            // else {
            //   listLotTemp.clear();
            //   // thay dổi kích thước list trong for => error
            //   listLotTemp.add(event.lot);
            // }
          }

          check ? event.listLotExpected.add(event.goodsIssueLot) : {};
          // listLotTemp == listLotExportServer ?{}:
          // listLotExportServer.add(listLotTemp[0]);
        } else {
          event.listLotExpected.add(event.goodsIssueLot);
        }
        emit(LoadGoodsIssueLotsSuccessState(
            DateTime.now(), event.listLotsSuggest, event.listLotExpected));
      } catch (e) {
        emit(LoadGoodsIssueLotsFailState(DateTime.now()));
        // emit(LoadReceiptExportingStateFail(
        //     DateTime.now(), 'Không truy xuất được dữ liệu'));
      }
    });
  }
}