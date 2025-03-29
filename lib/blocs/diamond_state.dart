
import '../models/diamond.dart'; 

abstract class DiamondState {}

class DiamondInitial extends DiamondState {}

class DiamondLoaded extends DiamondState {
  final List<Diamond> diamonds;
  DiamondLoaded(this.diamonds);
}
