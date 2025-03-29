import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart'; 
import '../blocs/diamond_bloc.dart';
import '../blocs/diamond_event.dart';
import 'result_page.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final _caratFromController = TextEditingController();
  final _caratToController = TextEditingController();
  String? _selectedLab;
  String? _selectedShape;
  String? _selectedColor;
  String? _selectedClarity;

  final List<String> labs = ['GIA', 'IGI', 'HRD'];
  final List<String> shapes = ['Round', 'Princess', 'Oval', 'Cushion'];
  final List<String> colors = ['D', 'E', 'F', 'G', 'H', 'I', 'J'];
  final List<String> clarities = ['IF', 'VVS1', 'VVS2', 'VS1', 'VS2', 'SI1', 'SI2'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, 
      appBar: AppBar(title: Text("Filter Diamonds")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildFilterCard(),
              const SizedBox(height: 20),
              _buildSearchButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Filter Options", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            // Carat From
            _buildInputField(controller: _caratFromController, label: "Carat From", icon: Icons.balance)
                .animate()
                .fade(duration: 500.ms)
                .slide(begin: Offset(0, 0.3), end: Offset(0, 0.0)),

            // Carat To
            _buildInputField(controller: _caratToController, label: "Carat To", icon: Icons.balance)
                .animate()
                .fade(duration: 600.ms)
                .slide(begin: Offset(0, 0.3), end: Offset(0, 0.0)),

            // Lab Selection
            _buildDropdown(label: "Lab", value: _selectedLab, items: labs, onChanged: (value) => setState(() => _selectedLab = value))
                .animate()
                .fade(duration: 700.ms)
                .slide(begin: Offset(0, 0.3), end: Offset(0, 0.0)),

            // Shape Selection
            _buildDropdown(label: "Shape", value: _selectedShape, items: shapes, onChanged: (value) => setState(() => _selectedShape = value))
                .animate()
                .fade(duration: 800.ms)
                .slide(begin: Offset(0, 0.3), end: Offset(0, 0.0)),

            // Color Selection
            _buildDropdown(label: "Color", value: _selectedColor, items: colors, onChanged: (value) => setState(() => _selectedColor = value))
                .animate()
                .fade(duration: 900.ms)
                .slide(begin: Offset(0, 0.3), end: Offset(0, 0.0)),

            // Clarity Selection
            _buildDropdown(label: "Clarity", value: _selectedClarity, items: clarities, onChanged: (value) => setState(() => _selectedClarity = value))
                .animate()
                .fade(duration: 1000.ms)
                .slide(begin: Offset(0, 0.3), end: Offset(0, 0.0)),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({required TextEditingController controller, required String label, required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget _buildDropdown({required String label, required String? value, required List<String> items, required Function(String?) onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildSearchButton() {
    return ElevatedButton(
      onPressed: () {
        BlocProvider.of<DiamondBloc>(context).add(
          FilterDiamonds(
            caratFrom: _caratFromController.text.isNotEmpty ? double.parse(_caratFromController.text) : null,
            caratTo: _caratToController.text.isNotEmpty ? double.parse(_caratToController.text) : null,
            lab: _selectedLab,
            shape: _selectedShape,
            color: _selectedColor,
            clarity: _selectedClarity,
          ),
        );
        Navigator.push(context, MaterialPageRoute(builder: (context) => ResultPage()));
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text("Search", style: TextStyle(fontSize: 18)),
    ).animate().fade(duration: 1200.ms);
  }
}
