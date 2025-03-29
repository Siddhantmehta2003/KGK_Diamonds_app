
import '../models/diamond.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final List<Diamond> cartItems;
  CartLoaded(this.cartItems);

  double get totalCarat => cartItems.fold(0.0, (double sum, d) => sum + d.carat);
  double get totalPrice => cartItems.fold(0.0, (double sum, d) => sum + d.finalAmount);
  double get avgPrice => cartItems.isNotEmpty ? totalPrice / cartItems.length : 0.0;
  double get avgDiscount => cartItems.isNotEmpty
      ? cartItems.fold(0.0, (double sum, d) => sum + d.discount) / cartItems.length
      : 0.0;
}
