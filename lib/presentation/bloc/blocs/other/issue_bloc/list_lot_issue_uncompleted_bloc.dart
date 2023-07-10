import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/goods_issue.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/item_lot.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/other/goods_issue_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/other/item_lot_usecase.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/other/issue_event/list_lot_issue_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/other/issue_state/list_lot_issue_state.dart';

class ListGoodsIssueLotUncompletedBloc
    extends Bloc<GoodsIssueLotEvent, GoodsIssueLotState> {
  GoodsIssueUseCase goodsIssueUseCase;
  ItemLotUsecase itemLotUsecase;
  ListGoodsIssueLotUncompletedBloc(this.goodsIssueUseCase, this.itemLotUsecase)
      : super(LoadingGoodsIssueLotsState(DateTime.now())) {
    on<LoadGoodsIssueLotEvent>((event, emit) async {
      emit(LoadingGoodsIssueLotsState(DateTime.now()));
      try {
         List<ItemLot> itemLotsSuggest =
            await itemLotUsecase.getItemLotsByItemId(event.itemId);
        emit(LoadGoodsIssueLotsSuccessState(DateTime.now(), event.goodsIssueId,
            event.itemId, itemLotsSuggest,   []));
      } catch (e) {
        emit(LoadGoodsIssueLotsFailState(DateTime.now()));
        // emit(LoadReceiptExportingStateFail(
        //     DateTime.now(), 'Không truy xuất được dữ liệu'));
      }
    });
    on<PostGoodsIssueLotEvent>((event, emit) async {
      emit(PostGoodsIssueLotsLoadingState(DateTime.now()));
      try {
        final postStatus = await goodsIssueUseCase.addLotToGoodsIssue(
            event.goodsIssueId, event.itemId, event.lots);
            postStatus.detail == "success" ?
        emit(PostIssueLotsSuccessState(
          DateTime.now()
        )): emit(PostGoodsIssueLotsFailState(DateTime.now()));
      } catch (e) {
        emit(PostGoodsIssueLotsFailState(DateTime.now()));
        // emit(LoadReceiptExportingStateFail(
        //     DateTime.now(), 'Không truy xuất được dữ liệu'));
      }
    });
    on<AddGoodsIssueLotEvent>((event, emit) async {
      // bool check = true;
      int index1;
      int index2;
      List<GoodsIssueLot> listLot = [];
      emit(LoadingGoodsIssueLotsState(DateTime.now()));
      try {
        index2 = event.listLotExported.indexWhere((element) =>
            element.goodsIssueLotId == event.goodsIssueLot.goodsIssueLotId);
        index2 == -1
            ? {
              event.listLotExported.add(event.goodsIssueLot)}
            : {
                event.listLotExported[index2].quantity =
                    (event.listLotExported[index2].quantity! +
                        event.goodsIssueLot.quantity!)
              };

        event.addFullLot
            ? {
                // event.listLotExported.add(event.goodsIssueLot),
                event.listLotsSuggest.removeWhere((element) =>
                    element.lotId == event.goodsIssueLot.goodsIssueLotId)
              }
            : {
                // event.listLotExported.add(event.goodsIssueLot),
                index1 = event.listLotsSuggest.indexWhere((element) =>
                    element.lotId == event.goodsIssueLot.goodsIssueLotId),
                event.listLotsSuggest[index1].quantity =
                    (event.listLotsSuggest[index1].quantity! -
                        event.goodsIssueLot.quantity!)
              };
        //   for (var element in event.listLotsSuggest) {
        //     if (element.lotId == event.goodsIssueLot.goodsIssueLotId) {
        //       element.quantity = element.quantity! - event.goodsIssueLot.quantity;
        //     }
        //   }
        //   event.listLotsSuggest = event.listLotsSuggest
        //     ..removeWhere((element) => element.quantity == 0);

        //   if (event.listLotExpected.isNotEmpty) {
        //     for (var element in event.listLotExpected) {
        //       if (element.goodsIssueLotId ==
        //           event.goodsIssueLot.goodsIssueLotId) {
        //         element.quantity =
        //             (element.quantity + event.goodsIssueLot.quantity);
        //         check = false;
        //       }
        //       // else {
        //       //   listLotTemp.clear();
        //       //   // thay dổi kích thước list trong for => error
        //       //   listLotTemp.add(event.lot);
        //       // }
        //     }

        //     check ? event.listLotExpected.add(event.goodsIssueLot) : {};
        //     // listLotTemp == listLotExportServer ?{}:
        //     // listLotExportServer.add(listLotTemp[0]);
        //   } else {
        //  //   event.listLotExpected.add(event.goodsIssueLot );
        //   }
        emit(LoadGoodsIssueLotsSuccessState(DateTime.now(), event.goodsIssueId,
            event.itemId, event.listLotsSuggest, event.listLotExported));
      } catch (e) {
        emit(LoadGoodsIssueLotsFailState(DateTime.now()));
        // emit(LoadReceiptExportingStateFail(
        //     DateTime.now(), 'Không truy xuất được dữ liệu'));
      }
    });
  }
}
