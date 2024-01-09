// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../home/models/order_item.dart';

class OrderModel {
  final String paymentMethod;
  final int nominalPayment;
  final List<OrderItem> orders;
  final int totalQuantity;
  final int totalPrice;
  final int cashierId;
  final String cashierName;
  final bool isSync;
  OrderModel({
    required this.paymentMethod,
    required this.nominalPayment,
    required this.orders,
    required this.totalQuantity,
    required this.totalPrice,
    required this.cashierId,
    required this.cashierName,
    required this.isSync,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'paymentMethod': paymentMethod,
      'nominalPayment': nominalPayment,
      'orders': orders.map((x) => x.toMap()).toList(),
      'totalQuantity': totalQuantity,
      'totalPrice': totalPrice,
      'cashierId': cashierId,
      'cashierName': cashierName,
      'isSync': isSync,
    };
  }

  Map<String, dynamic> toMapForLocal() {
    return <String, dynamic>{
      'payment_method': paymentMethod,
      'total_item': totalQuantity,
      'nominal': totalPrice,
      'cashier_id': cashierId,
      'cashier_name': cashierName,
      'is_sync': isSync ? 1 : 0,
    };
  }

  factory OrderModel.fromLocalMap(Map<String, dynamic> map) {
    return OrderModel(
      paymentMethod: map['payment_method'] as String,
      nominalPayment: map['nominal'] as int,
      orders: [],
      totalQuantity: map['total_item'] as int,
      totalPrice: map['nominal'] as int,
      cashierId: map['cashier_id'] as int,
      cashierName: map['cashier_name'] as String,
      isSync: map['is_sync'] == 1 ? true : false,
    );
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      paymentMethod: map['paymentMethod'] as String,
      nominalPayment: map['nominalPayment'] as int,
      orders: List<OrderItem>.from(
        (map['orders'] as List<int>).map<OrderItem>(
          (x) => OrderItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
      totalQuantity: map['totalQuantity'] as int,
      totalPrice: map['totalPrice'] as int,
      cashierId: map['cashierId'] as int,
      cashierName: map['cashierName'] as String,
      isSync: map['isSync'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
