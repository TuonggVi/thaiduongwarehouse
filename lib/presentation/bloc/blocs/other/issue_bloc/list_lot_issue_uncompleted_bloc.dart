// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter_bloc/flutter_bloc.dart';
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
    //
    on<LoadGoodsIssueLotEvent>((event, emit) async {
      emit(LoadingGoodsIssueLotsState(DateTime.now()));
      try {
        List<ItemLot> itemLotsSuggest =
            await itemLotUsecase.getItemLotsByItemId(event.itemId);
        emit(LoadGoodsIssueLotsSuccessState(DateTime.now(), event.goodsIssueId,
            event.itemId, event.goodsIssueLot, itemLotsSuggest, [], [], []));
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
        postStatus.detail == "success"
            ? emit(PostIssueLotsSuccessState(DateTime.now()))
            : emit(PostGoodsIssueLotsFailState(
                DateTime.now(),
              ));
      } catch (e) {
        emit(PostGoodsIssueLotsFailState(
          DateTime.now(),
        ));
        // emit(LoadReceiptExportingStateFail(
        //     DateTime.now(), 'Không truy xuất được dữ liệu'));
      }
    });
    // thêm lô vào entry
    on<AddGoodsIssueLotEvent>((event, emit) async {
      // bool check = true;
      int index1;
      int index2;
      int index3;
      emit(LoadingGoodsIssueLotsState(DateTime.now()));
      try {
        //index2 là vị trí lô hàng trong ds dự kiến, nếu chưa thêm lô hàng vào ds dự kiến => index2 =-1
        index2 = event.listLotExported.indexWhere((element) =>
            element.goodsIssueLotId == event.goodsIssueLot.goodsIssueLotId);
        index2 == -1
            ? {
                // thêm lô vào ds dự kiến
                event.listLotExported.add(event.goodsIssueLot),
                index3 = event.listLotExported.length-1,
                // thay đổi số lượng từng vị trí trong lô = số lượng nhập vào
                for (int i = 0;
                    i < event.listLotExported[index3].goodsIssueSublot.length;
                    i++)
                  {
                    event.listLotExported[index3].goodsIssueSublot[i]
                        .quantityPerLocation = 
                        // event.listLotExported[0]
                        //     .goodsIssueSublot[i].quantityPerLocation! 
                            //+
                        event.goodsIssueLot.goodsIssueSublot[i]
                            .newQuantityPerLocation!
                  }
              }
            : {
                // goodIssueLot.quantity = tổng số lượng tại mỗi vị trí trong lô
                // thay đổi số lượng trong danh sách dự kiến
                event.listLotExported[index2].quantity =
                    (event.listLotExported[index2].quantity! +
                        event.goodsIssueLot.quantity!),
                // thay đổi số lượng từng vị trí trong lô
                for (int i = 0;
                    i < event.listLotExported[index2].goodsIssueSublot.length;
                    i++)
                  {
                    event.listLotExported[index2].goodsIssueSublot[i]
                        .quantityPerLocation = (event.listLotExported[index2]
                            .goodsIssueSublot[i].quantityPerLocation! +
                        event.goodsIssueLot.goodsIssueSublot[i]
                            .newQuantityPerLocation!)
                  }
              };
        event.addFullLot
            ? {
                // thêm cả lô => xóa lô trong ds đề xuất
                // event.listLotExported.add(event.goodsIssueLot),
                event.listLotsSuggest.removeWhere((element) =>
                    element.lotId == event.goodsIssueLot.goodsIssueLotId)
              }
            : {
                // thêm 1 phần => tính toán lại số lượng còn lại trong lô
                index1 = event.listLotsSuggest.indexWhere((element) =>
                    element.lotId == event.goodsIssueLot.goodsIssueLotId),
                event.listLotsSuggest[index1].quantity =
                    (event.listLotsSuggest[index1].quantity! -
                        event.goodsIssueLot.quantity!),
                // tính toán số lượng còn lại ở mỗi vị trí
                for (int i = 0;
                    i < event.listLotsSuggest[index1].itemLotSubLot.length;
                    i++)
                  {
                    event.listLotsSuggest[index1].itemLotSubLot[i]
                        .quantityPerLocation = (event.listLotsSuggest[index1]
                            .itemLotSubLot[i].quantityPerLocation! -
                       event.goodsIssueLot.goodsIssueSublot[i]
                         .newQuantityPerLocation!)
                  }
                // nếu xuất hết tại 1 vị trí, xóa vị trí đó
              };
        emit(LoadGoodsIssueLotsSuccessState(
            DateTime.now(),
            event.goodsIssueId,
            event.itemId,
            event.goodsIssueLot,
            event.listLotsSuggest,
            event.listLotExported,
            event.itemLotSublot,
            event.goodsIssueSublots));
      } catch (e) {
        emit(LoadGoodsIssueLotsFailState(DateTime.now()));
        // emit(LoadReceiptExportingStateFail(
        //     DateTime.now(), 'Không truy xuất được dữ liệu'));
      }
    });
  }
}
