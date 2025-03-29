import 'package:diamond_kgk/screens/filter_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/diamond_bloc.dart';
import 'blocs/cart_bloc.dart';
import 'blocs/cart_event.dart';
import 'data/data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadDiamonds();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DiamondBloc(diamonds)),
        BlocProvider(create: (context) => CartBloc()..add(LoadCart())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FilterPage(),
      ),
    );
  }
}
