import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/goods_receipt.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/other/goods_receipt_usecase.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/other/receipt_event/uncompleted_receipt_lot_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/other/receipt_state/uncompleted_receipt_lot_state.dart';

import '../../../../../datasource/models/other/goods_receipt_model.dart';
import '../../../states/other/receipt_state/create_new_receipt_state.dart';

class ExportingReceiptLotBloc
    extends Bloc<UncompletedReceiptLotEvent, UncompletedReceiptLotState> {
  GoodsReceiptUsecase goodsReceiptUsecase;
  ExportingReceiptLotBloc(this.goodsReceiptUsecase)
      : super(LoadReceiptLotsLoadingState(DateTime.now())) {
    // load lô chưa hoàn thành, k có trường hợp phiếu nhập không có lô
    on<LoadUncompletedReceiptLotEvent>((event, emit) async {
      emit(UpdateReceiptLotSuccessState(event.receipt, DateTime.now()));
    });
    // cập nhật thông tin lô chưa hoàn thành bằng cách remove => insert
    on<UpdateReceiptLotEvent>((event, emit) async {
      emit(UpdateReceiptLotLoadingState(DateTime.now()));
      try {
        event.goodsReceipt.lots.removeAt(event.index);
        event.goodsReceipt.lots.insert(event.index, event.itemLot);
        emit(UpdateReceiptLotSuccessState(event.goodsReceipt, DateTime.now()));
      } catch (e) {
        // emit(LoadReceiptExportingStateFail(
        //     DateTime.now(), 'Không truy xuất được dữ liệu'));
      }
    });
    // patch lô đã chỉnh sửa
    on<PatchReceiptChangedEvent>((event, emit) async {
      emit(PatchReceiptLotChangedLoadingState(DateTime.now()));
      try {
        final status = await goodsReceiptUsecase
            .updateDetailLotReceipt(event.goodsReceipt);
        status.detail == 'success'
            ? emit(PatchReceiptLotChangedSuccessState(
                ErrorPackage('Thành công'), DateTime.now()))
            : emit(PatchReceiptLotChangedFailState(
                ErrorPackage('Thất bại'), DateTime.now()));
      } catch (e) {
       emit(PatchReceiptLotChangedFailState(
                ErrorPackage('Lỗi hệ thống'), DateTime.now()));
      }
    });
    // post lô mới nhập thêm vào phiếu lên server
     on<PostReceiptChangedEvent>((event, emit) async {
      emit(PostReceiptLotChangedLoadingState(DateTime.now()));
      try {
        final status =
            await goodsReceiptUsecase.patchNewGoodsReceipt(event.goodsReceipt);
        if (status.detail == 'success') {
          emit(PostReceiptLotChangedSuccessState(
            DateTime.now(),    status, event.goodsReceipt));
        } else {
          emit(PostReceiptLotChangedFailState(
              ErrorPackage('fail'), DateTime.now(), event.goodsReceipt));
          //   emit(UpdateLotReceiptStateSuccess(
          //   DateTime.now(),
          //   event.goodsReceipt,
          // ));
        }
      } catch (e) {
        emit(PostReceiptLotChangedFailState(
            ErrorPackage('fail'), DateTime.now(), event.goodsReceipt));
        // emit(UpdateLotReceiptStateSuccess(
        //   DateTime.now(),
        //   event.goodsReceipt,
        // ));
      }
    });
    
   // thêm lô mới vào phiếu nhập kho
    on<AddNewLotToGoodsReceiptEvent>((event, emit) async {
      emit(NewReceiptLoadingState(DateTime.now()));
      try {
        // GoodsReceiptLot itemLot = event.goodsReceipt.lots  as GoodsReceiptLotModel;
        // event.goodsReceipt.lots.add(itemLot);
        event.goodsReceipt.lots.add(event.itemLot);
        emit(UpdateReceiptLotSuccessState(event.goodsReceipt, DateTime.now(), ) );
      } catch (e) {
       
        emit(UpdateReceiptLotSuccessState( event.goodsReceipt, DateTime.now(),));
      
      }
    });
    

  }
}
    