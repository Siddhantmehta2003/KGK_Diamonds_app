
import '../models/diamond.dart';

abstract class CartEvent {}

class AddToCart extends CartEvent {
  final Diamond diamond;
  AddToCart(this.diamond);
}

class RemoveFromCart extends CartEvent {
  final Diamond diamond;
  RemoveFromCart(this.diamond);
}

class LoadCart extends CartEvent {}
