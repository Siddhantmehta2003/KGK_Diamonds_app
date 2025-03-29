import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart'; 
import '../blocs/diamond_bloc.dart';
import '../blocs/diamond_state.dart';
import '../blocs/cart_bloc.dart';
import '../blocs/cart_event.dart';
import '../models/diamond.dart';
import 'cart_page.dart';

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filtered Diamonds"),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, size: 28), 
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
            },
          ),
        ],
      ),
      body: BlocBuilder<DiamondBloc, DiamondState>(
        builder: (context, state) {
          if (state is DiamondLoaded) {
            return state.diamonds.isNotEmpty
                ? ListView.builder(
                    padding: EdgeInsets.all(12),
                    itemCount: state.diamonds.length,
                    itemBuilder: (context, index) {
                      final diamond = state.diamonds[index];
                      return _buildDiamondCard(context, diamond, index);
                    },
                  )
                : Center(child: Text("No diamonds found.", style: TextStyle(fontSize: 18)));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildDiamondCard(BuildContext context, Diamond diamond, int index) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blueAccent,
          child: Text(diamond.shape[0], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        title: Text(
          "Lot ID: ${diamond.lotId}",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text("Carat: ${diamond.carat} | Price: \$${diamond.finalAmount}", style: TextStyle(fontSize: 14)),
        trailing: IconButton(
          icon: Icon(Icons.add_shopping_cart, color: Colors.green),
          onPressed: () {
            BlocProvider.of<CartBloc>(context).add(AddToCart(diamond));
            _showAddedToCartSnackbar(context, diamond.lotId);
          },
        ),
      )
          .animate()
          .fade(duration: (500 + (index * 100)).ms)
          .slide(begin: Offset(0, 0.3), end: Offset(0, 0.0)),
    );
  }

  void _showAddedToCartSnackbar(BuildContext context, String lotId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Diamond (Lot ID: $lotId) added to cart!"),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }
}
