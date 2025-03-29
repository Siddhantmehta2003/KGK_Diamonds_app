import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart'; 
import '../blocs/cart_bloc.dart';
import '../blocs/cart_state.dart';
import '../blocs/cart_event.dart';
import '../models/diamond.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoaded) {
            return Column(
              children: [
                Expanded(
                  child: state.cartItems.isNotEmpty
                      ? ListView.builder(
                          padding: EdgeInsets.all(12),
                          itemCount: state.cartItems.length,
                          itemBuilder: (context, index) {
                            final diamond = state.cartItems[index];
                            return _buildCartItem(context, diamond, index);
                          },
                        )
                      : Center(child: Text("Your cart is empty!", style: TextStyle(fontSize: 18))),
                ),
                _buildCartSummary(state),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, Diamond diamond, int index) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.redAccent,
          child: Text(diamond.shape[0], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        title: Text(
          "Lot ID: ${diamond.lotId}",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text("Carat: ${diamond.carat} | Price: \$${diamond.finalAmount}", style: TextStyle(fontSize: 14)),
        trailing: IconButton(
          icon: Icon(Icons.remove_shopping_cart, color: Colors.red),
          onPressed: () {
            BlocProvider.of<CartBloc>(context).add(RemoveFromCart(diamond));
            _showRemovedFromCartSnackbar(context, diamond.lotId);
          },
        ),
      )
          .animate()
          .fade(duration: (500 + (index * 100)).ms)
          .slide(begin: Offset(0, 0.3), end: Offset(0, 0.0)),
    );
  }

  Widget _buildCartSummary(CartLoaded state) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Cart Summary", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text("Total Carat: ${state.totalCarat}", style: TextStyle(fontSize: 16)),
          Text("Total Price: \$${state.totalPrice}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
          Text("Average Price: \$${state.avgPrice}", style: TextStyle(fontSize: 16)),
          Text("Average Discount: ${state.avgDiscount}%", style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  void _showRemovedFromCartSnackbar(BuildContext context, String lotId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Diamond (Lot ID: $lotId) removed from cart!"),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }
}
