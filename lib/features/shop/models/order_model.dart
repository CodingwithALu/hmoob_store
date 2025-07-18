import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/features/personalization/models/address_model.dart';
import 'package:t_store/features/shop/models/cart_item_model.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class OrderModel {
  final String id;
  final String userId;
  final OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel? shippingAddress;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;

  OrderModel({
    required this.id,
    this.userId = '',
    required this.status,
    required this.items,
    required this.totalAmount,
    required this.orderDate,
    this.paymentMethod = 'Paypal',
    this.deliveryDate,
    this.shippingAddress,
  });

  String get formattedOrderDate => THelperFunctions.getFormattedDate(orderDate);

  String get formattedDeliveryDate => deliveryDate != null
      ? THelperFunctions.getFormattedDate(deliveryDate!)
      : '';

  String get orderStatusText => status == OrderStatus.delivered
      ? 'Delivered'
      : status == OrderStatus.shipped
      ? 'Shipment on the way'
      : 'Processing';

  // Static function to create an empty user
  static OrderModel empty() => OrderModel(
    id: '',
    status: OrderStatus.pending,
    items: [],
    totalAmount: 0.0,
    orderDate: DateTime.now(),
  );

  // Convert model to JSON structure for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status.toString(),
      'totalAmount': totalAmount,
      'orderDate': orderDate,
      'paymentMethod': paymentMethod,
      'shippingAddress': shippingAddress?.toJson(),
      'deliveryDate': deliveryDate,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  // Create a OrderModel from JSON data
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      status: OrderStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => OrderStatus.pending,
      ),
      totalAmount: (json['totalAmount'] ?? 0.0).toDouble(),
      orderDate: DateTime.parse(json['orderDate']),
      paymentMethod: json['paymentMethod'] ?? 'Cash on Delivery',
      deliveryDate: json['deliveryDate'] != null
          ? DateTime.parse(json['deliveryDate'])
          : null,
      shippingAddress: AddressModel.fromJson(
        json['shippingAddress'] as Map<String, dynamic>,
      ),
      items:
          (json['items'] as List<dynamic>?)
              ?.map((item) => CartItemModel.fromJson(item))
              .toList() ??
          [],
    );
  }
  // Factory method to create a OrderModel from a Firebase document snapshot
  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return OrderModel(
      id: data.containsKey('id') ? data['id'] as String : '',
      userId: data.containsKey('userId') ? data['userId'] as String : '',
      status: data.containsKey('status')
          ? OrderStatus.values.firstWhere((e) => e.toString() == data['status'])
          : OrderStatus.pending,
      // Default status
      totalAmount: data.containsKey('totalAmount')
          ? data['totalAmount'] as double
          : 0.0,
      orderDate: data.containsKey('orderDate')
          ? (data['orderDate'] as Timestamp).toDate()
          : DateTime.now(),
      // Default to current time
      paymentMethod: data.containsKey('paymentMethod')
          ? data['paymentMethod'] as String
          : '',
      // ignore: unnecessary_null_comparison
      deliveryDate: data.containsKey('deliveryDate') != null
          ? (data['deliveryDate'] as Timestamp).toDate()
          : null,
      shippingAddress: data.containsKey('shippingAddress')
          ? AddressModel.fromJson(
              data['shippingAddress'] as Map<String, dynamic>,
            )
          : AddressModel.empty(),
      items: data.containsKey('items')
          ? (data['items'] as List<dynamic>)
                .map(
                  (item) =>
                      CartItemModel.fromJson(item as Map<String, dynamic>),
                )
                .toList()
          : [],
    );
  }
}
