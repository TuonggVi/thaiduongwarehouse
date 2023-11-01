import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/other/goods_receipt_usecase.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/other/receipt_event/uncompleted_receipt_lot_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/other/receipt_state/uncompleted_receipt_lot_state.dart';


class ExportingReceiptLotBloc
    extends Bloc<UncompletedReceiptLotEvent, UncompletedReceiptLotState> {
  GoodsReceiptUsecase goodsReceiptUsecase;
  ExportingReceiptLotBloc(this.goodsReceiptUsecase)
      : super(LoadReceiptLotsLoadingState(DateTime.now())) {

    on<LoadUncompletedReceiptLotEvent>((event, emit) async {
      emit(UpdateReceiptLotSuccessState(event.receipt,  DateTime.now() ));
    });

    on<UpdateReceiptLotEvent>((event, emit) async {
      emit(UpdateReceiptLotLoadingState(DateTime.now()));
      try {
        event.goodsReceipt.lots.removeAt(event.index);
        event.goodsReceipt.lots.insert(event.index, event.goodsReceiptLot);  
        emit(UpdateReceiptLotSuccessState(event.goodsReceipt, DateTime.now()));
      } catch (e) {
        // emit(LoadReceiptExportingStateFail(
        //     DateTime.now(), 'Không truy xuất được dữ liệu'));
      }
    });


  on<PatchReceiptChangedEvent>((event, emit) async {
  emit(PatchReceiptLotChangedLoadingState(DateTime.now()));
  try {
    final status = await goodsReceiptUsecase.updateDetailLotReceipt(event.goodsReceipt);
    if (status.detail == 'success') {
  emit(PatchReceiptLotChangedSuccessState(status, DateTime.now()));
} else {
  bool locationError = false;

  for (int i = 0; i < event.goodsReceipt.lots.length; i++) {
    for (int j = 0; j < event.goodsReceipt.lots[i].goodsReceiptSublots.length; j++) {
      if (status.detail == 'Location with Id ${event.goodsReceipt.lots[i].goodsReceiptSublots[j].locationId} does not exist') {
        locationError = true;
        break;
      }
    }
  }

  if (locationError) {
    emit(PatchReceiptLotChangedFailState(
      ErrorPackage('Nhập sai vị trí'), DateTime.now(), event.goodsReceipt));
  } else {
    emit(PatchReceiptLotChangedFailState(
      ErrorPackage('Nhập sai thông tin'), DateTime.now(), event.goodsReceipt));
  }
}

    // if (status.detail == 'success') {
    //   emit(PatchReceiptLotChangedSuccessState(status, DateTime.now()));
    // } if(status.detail != 'success') {} {
    //   for (int i = 0; i < event.goodsReceipt.lots.length; i++) {
    //     for (int j = 0; j < event.goodsReceipt.lots[i].goodsReceiptSublots.length; j++) {
    //       if (status.detail == 'Location with Id ${event.goodsReceipt.lots[i].goodsReceiptSublots[j].locationId} does not exist') {
    //         emit(PatchReceiptLotChangedFailState(
    //           ErrorPackage('Nhập sai vị trí'), DateTime.now(), event.goodsReceipt));
    //       }
    //     }
    //   } 
    // }; else {  
    //   emit(PatchReceiptLotChangedFailState(
    //           ErrorPackage('Nhập sai vị trí'), DateTime.now(), event.goodsReceipt));}
  } catch (e) {
    emit(PatchReceiptLotChangedFailState(
      ErrorPackage('Lỗi hệ thống'), DateTime.now(), event.goodsReceipt));
  }
});
 on<RemoveGoodsReceiptLotEvent>((event, emit) async {
      emit(RemoveReceiptLotLoadingState(DateTime.now()));
      try {
        final status = await goodsReceiptUsecase
            .removeGoodsReceiptLot(event.goodsReceipt, event.goodsReceiptLot);
        status.detail == 'success'
            ? emit(RemoveReceiptLotSuccessState(
                event.index, event.goodsReceipt, DateTime.now()))
            : emit(RemoveReceiptLotFailState(
                ErrorPackage('Thất bại'), DateTime.now(), event.goodsReceipt));
      } catch (e) {
        emit(RemoveReceiptLotFailState(
            ErrorPackage('Lỗi hệ thống'), DateTime.now(), event.goodsReceipt));
      }
    });
  }}
