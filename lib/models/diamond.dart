import 'package:equatable/equatable.dart';

class Diamond extends Equatable {
  final String lotId;
  final double size;
  final double carat;
  final String lab;
  final String shape;
  final String color;
  final String clarity;
  final String cut;
  final String polish;
  final String symmetry;
  final String fluorescence;
  final double discount;
  final double perCaratRate;
  final double finalAmount;
  final String keyToSymbol;
  final String labComment;

  const Diamond({
    required this.lotId,
    required this.size,
    required this.carat,
    required this.lab,
    required this.shape,
    required this.color,
    required this.clarity,
    required this.cut,
    required this.polish,
    required this.symmetry,
    required this.fluorescence,
    required this.discount,
    required this.perCaratRate,
    required this.finalAmount,
    required this.keyToSymbol,
    required this.labComment,
  });

 
  factory Diamond.fromJson(Map<String, dynamic> json) {
    return Diamond(
      lotId: json['Lot ID'] ?? '',
      size: _parseDouble(json['Size']),
      carat: _parseCarat(json['Carat']), 
      lab: json['Lab'] ?? '',
      shape: json['Shape'] ?? '',
      color: json['Color'] ?? '',
      clarity: json['Clarity'] ?? '',
      cut: json['Cut'] ?? '',
      polish: json['Polish'] ?? '',
      symmetry: json['Symmetry'] ?? '',
      fluorescence: json['Fluorescence'] ?? '',
      discount: _parseDouble(json['Discount']),
      perCaratRate: _parseDouble(json['Per Carat Rate']),
      finalAmount: _parseDouble(json['Final Amount']),
      keyToSymbol: json['Key To Symbol'] ?? '',
      labComment: json['Lab Comment'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Lot ID': lotId,
      'Size': size,
      'Carat': carat,
      'Lab': lab,
      'Shape': shape,
      'Color': color,
      'Clarity': clarity,
      'Cut': cut,
      'Polish': polish,
      'Symmetry': symmetry,
      'Fluorescence': fluorescence,
      'Discount': discount,
      'Per Carat Rate': perCaratRate,
      'Final Amount': finalAmount,
      'Key To Symbol': keyToSymbol,
      'Lab Comment': labComment,
    };
  }

  @override
  List<Object?> get props => [
        lotId,
        size,
        carat,
        lab,
        shape,
        color,
        clarity,
        cut,
        polish,
        symmetry,
        fluorescence,
        discount,
        perCaratRate,
        finalAmount,
        keyToSymbol,
        labComment,
      ];

  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value; 
    if (value is int) return value.toDouble(); 
    if (value is String) {
      return double.tryParse(value.replaceAll(',', '')) ?? 0.0; 
    }
    return 0.0;
  }

  
  static double _parseCarat(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      if (value.contains('-')) {
        return double.tryParse(value.split('-')[0]) ?? 0.0; 
      }
      return double.tryParse(value) ?? 0.0;
    }
    return 0.0;
  }
}
