# 💎 Flutter Diamonds App  

A **Flutter** application for browsing and filtering a dataset of **100 diamonds**, using **BLoC** for state management and persistent storage for the cart functionality.  

---

## 📂 **Project Structure**  

The project follows a **clean architecture** structure:  

```
lib/
│── assets/diamonds.json          # Dataset of diamonds
│── blocs/                        # BLoC State Management
│   ├── diamond_bloc.dart         # Handles filtering & sorting logic
│   ├── diamond_event.dart        # Events for diamonds BLoC
│   ├── diamond_state.dart        # States for diamonds BLoC
│   ├── cart_bloc.dart            # Handles cart functionality
│   ├── cart_event.dart           # Events for cart BLoC
│   ├── cart_state.dart           # States for cart BLoC
│
│── models/                       # Data Models
│   ├── diamond.dart              # Diamond model with JSON parsing
│
│── screens/                      # UI Screens
│   ├── filter_page.dart          # Filters for diamonds
│   ├── result_page.dart          # Displays filtered results
│   ├── cart_page.dart            # Shopping cart page
│
│── main.dart                      # Entry point of the app
│── utils/                         # Helper functions
│   ├── storage_helper.dart        # Handles persistent storage
│
└── pubspec.yaml                   # Dependencies and assets
```

---

## 🔄 **State Management (BLoC)**  

This app uses **Flutter BLoC** for state management, ensuring a **clear separation of concerns** and **efficient UI updates**.  

### 1️⃣ **Diamonds BLoC**
- **`DiamondBloc`** manages filtering and sorting of the diamond list.  
- Users can filter diamonds by **carat, lab, shape, color, clarity**.  
- Sorting is available by **price** and **carat weight**.  

### 2️⃣ **Cart BLoC**
- **`CartBloc`** manages adding and removing diamonds from the cart.  
- Keeps track of **total price, total carat weight, and average price**.  
- Uses **persistent storage** to save the cart between app restarts.  

---

## 💾 **Persistent Storage (Shared Preferences)**  

The cart is **saved locally** using **SharedPreferences** so that:  
✔️ Items added to the cart remain saved after app restarts.  
✔️ Users can continue shopping seamlessly.  

### 🔧 **Implementation (storage_helper.dart)**
```dart
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/diamond.dart';

class StorageHelper {
  static const String cartKey = "cart_items";

  /// Save cart items to persistent storage
  static Future<void> saveCart(List<Diamond> cart) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(cartKey, jsonEncode(cart.map((d) => d.toJson()).toList()));
  }

  /// Load cart items from storage
  static Future<List<Diamond>> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(cartKey);
    if (data == null) return [];
    return (jsonDecode(data) as List).map((item) => Diamond.fromJson(item)).toList();
  }
}
```

---

## 🚀 **How to Run the Project**  

1️⃣ **Clone the repository**  
```sh
git clone https://github.com/your-repo/flutter-diamonds-app.git
cd flutter-diamonds-app
```

2️⃣ **Install dependencies**  
```sh
flutter pub get
```

3️⃣ **Run the app**  
```sh
flutter run
```

---

## 🛠 **Features & Functionality**  

✅ **Diamond Filtering & Sorting**  
✅ **Shopping Cart with Persistence**  
✅ **Interactive UI with Animations**  
✅ **Optimized State Management using BLoC**  

Let me know if you need any modifications! 🚀🔥
