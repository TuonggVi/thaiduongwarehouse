// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/item_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/location_usecase.dart';

import '../../../../../domain/entities/error_package.dart';
import '../../../../../domain/entities/location.dart';
import '../../../../../domain/usecases/other/goods_receipt_usecase.dart';
import '../../../events/other/receipt_event/add_receipt_lot_event.dart';
import '../../../states/other/receipt_state/add_new_receipt_lot_state.dart';

class FillInfoNewReceiptLotBloc
    extends Bloc<FillInfoNewLotReceiptEvent, FillInfoNewReceiptLotState> {
  ItemUsecase itemUsecase;
  LocationUsecase locationUsecase;
  GoodsReceiptUsecase goodsReceiptUsecase;
  FillInfoNewReceiptLotBloc(this.itemUsecase, this.locationUsecase, this.goodsReceiptUsecase)
      : super(LoadNewItemDataLoadingState(DateTime.now())) {
    // điền thông tin lô nhập kho
    on<FillNewReceiptLotEvent>((event, emit) async {
      emit(LoadNewItemDataLoadingState(DateTime.now()));
      try {
        final items = await itemUsecase.getAllItem();

        emit(LoadNewItemDataSuccessState(
            items,[], event.goodsReceipt, event.index, DateTime.now()));
      } catch (e) {
        //emit(Load(DateTime.now()));
      }
    });
    // sửa thông tin lô nhập kho
    on<RefillNewReceiptLotEvent>((event, emit) async {
            List<Location> locations = [];

      emit(LoadNewItemDataLoadingState(DateTime.now()));
      try {
        // final items = await itemUsecase.getAllItem();
        final warehouse = await locationUsecase.getAllWarehouseId();
          for (var element in warehouse) {
          locations = locations + element.locations;
        }
        emit(LoadNewItemDataSuccessState(
            [],locations, event.goodsReceipt, event.index, DateTime.now()));
      } catch (e) {
        //emit(Load(DateTime.now()));
      }
    });
 // thêm lô vào phiếu nhập
    on<AddNewLotToGoodsReceiptEvent>((event, emit) async {
      emit(ReceiptLotLoadingState(DateTime.now()));
      try {
        event.goodsReceipt.lots.add(event.itemLot);
        emit(AddNewLotToGoodsReceiptStateSuccess(
                DateTime.now(),
          event.goodsReceipt,
    
        ));
      } catch (e) {
        emit(AddNewLotToGoodsReceiptStateSuccess(
          DateTime.now(),
          event.goodsReceipt,
          
        ));
      }
    });
    // post phiếu mới lên server
    on<PostNewReceiptLotEvent>((event, emit) async {
      emit(PostAddReceiptLotStateLoadingState(DateTime.now()));
      try {
        final status =
            await goodsReceiptUsecase.patchNewGoodsReceipt(event.goodsReceipt);
        if (status.detail == 'success') {
          emit(PostAddReceiptLotStateSuccess(
             (DateTime.now()), status, event.goodsReceipt));
        } else {
          emit(PostAddReceiptLotStateFailure(
              ErrorPackage('fail'), (DateTime.now()), event.goodsReceipt));
          //   emit(UpdateLotReceiptStateSuccess(
          //   DateTime.now(),
          //   event.goodsReceipt,
          // ));
        }
      } catch (e) {
        emit(PostAddReceiptLotStateFailure(
            ErrorPackage('fail'), (DateTime.now()), event.goodsReceipt));
        // emit(UpdateLotReceiptStateSuccess(
        //   DateTime.now(),
        //   event.goodsReceipt,
        // ));
      }
    });
    // post phiếu thất bại, cập nhật lại thông tin phiếu nhập sai
    on<UpdateReceiptLotFailEvent>((event, emit) async {
      emit(ReceiptLotLoadingState(DateTime.now()));
      try {
        event.goodsReceipt.goodsReceiptId == '' ?
          emit(ReceiptLotInitState(DateTime.now())):
        emit(UpdateReceiptLotStateSuccess(
          DateTime.now(),
          event.goodsReceipt,
        ));
      } catch (e) {
         emit(ReceiptLotInitState(DateTime.now()));
         
      }
    });

  }
}