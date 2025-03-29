import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/diamond.dart';

List<Diamond> diamonds = [];

Future<void> loadDiamonds() async {
  try {
    final String response = await rootBundle.loadString('assets/diamonds.json'); // ✅ Correct path
    final List<dynamic> data = json.decode(response);
    diamonds = data.map((e) => Diamond.fromJson(e)).toList();
    print("✅ Diamonds data loaded successfully!");
  } catch (e) {
    print("❌ Error loading diamonds.json: $e");
  }
}
