import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../home/models/order_item.dart';

part 'order_event.dart';
part 'order_state.dart';
part 'order_bloc.freezed.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(const _Success([], 0, 0, 0, '', 0, '')) {
    on<_AddPaymentMethod>((event, emit) {
      emit(const _Loading());

      emit(_Success(
        event.orders,
        event.orders.fold(
            0, (previousValue, element) => previousValue + element.quantity),
        event.orders.fold(0,
            (previousValue, element) => previousValue + element.product.price),
        0,
        event.paymentMethod,
        0,
        '',
      ));
    });

    on<_AddNominalPayment>((event, emit) {
      var currentStates = state as _Success;
      emit(const _Loading());
      emit(_Success(
        currentStates.products,
        currentStates.totalQuantity,
        //currentStates.totalPrice,
        event.nominal,
        event.nominal,
        currentStates.paymentMethod,
        currentStates.cashierId,
        currentStates.cashierName,
      ));
    });

    on<_Started>((event, emit) {
      emit(const _Loading());
      emit(const _Success([], 0, 0, 0, '', 0, ''));
    });
  }
}
