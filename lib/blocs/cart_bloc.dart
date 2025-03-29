
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/diamond.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<LoadCart>(_onLoadCart);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final String? cartJson = prefs.getString('cart');
    if (cartJson != null) {
      List<dynamic> decoded = json.decode(cartJson);
      List<Diamond> cartItems = decoded.map((d) => Diamond.fromJson(d)).toList();
      emit(CartLoaded(cartItems));
    } else {
      emit(CartLoaded([]));
    }
  }

  Future<void> _onAddToCart(AddToCart event, Emitter<CartState> emit) async {
    final currentState = state;
    if (currentState is CartLoaded) {
      final updatedCart = List<Diamond>.from(currentState.cartItems)..add(event.diamond);
      await _saveCart(updatedCart);
      emit(CartLoaded(updatedCart));
    }
  }

  Future<void> _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) async {
    final currentState = state;
    if (currentState is CartLoaded) {
      final updatedCart = List<Diamond>.from(currentState.cartItems)..remove(event.diamond);
      await _saveCart(updatedCart);
      emit(CartLoaded(updatedCart));
    }
  }

  Future<void> _saveCart(List<Diamond> cartItems) async {
    final prefs = await SharedPreferences.getInstance();
    final String cartJson = json.encode(cartItems.map((d) => d.toJson()).toList());
    await prefs.setString('cart', cartJson);
  }
}
