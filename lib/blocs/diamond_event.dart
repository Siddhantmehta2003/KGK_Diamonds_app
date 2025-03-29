
abstract class DiamondEvent {}

class FilterDiamonds extends DiamondEvent {
  final double? caratFrom;
  final double? caratTo;
  final String? lab;
  final String? shape;
  final String? color;
  final String? clarity;

  FilterDiamonds({this.caratFrom, this.caratTo, this.lab, this.shape, this.color, this.clarity});
}

class SortDiamonds extends DiamondEvent {
  final bool sortByPriceAsc;
  final bool sortByCaratAsc;

  SortDiamonds({required this.sortByPriceAsc, required this.sortByCaratAsc});
}
