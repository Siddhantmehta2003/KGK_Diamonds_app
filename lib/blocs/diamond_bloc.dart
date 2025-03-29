
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/diamond.dart';
import 'diamond_event.dart';
import 'diamond_state.dart';

class DiamondBloc extends Bloc<DiamondEvent, DiamondState> {
  final List<Diamond> allDiamonds;

  DiamondBloc(this.allDiamonds) : super(DiamondInitial()) {
    on<FilterDiamonds>((event, emit) {
      var filteredDiamonds = allDiamonds.where((d) {
        bool matchesCarat = (event.caratFrom == null || d.carat >= event.caratFrom!) &&
                            (event.caratTo == null || d.carat <= event.caratTo!);
        bool matchesLab = event.lab == null || d.lab == event.lab;
        bool matchesShape = event.shape == null || d.shape == event.shape;
        bool matchesColor = event.color == null || d.color == event.color;
        bool matchesClarity = event.clarity == null || d.clarity == event.clarity;

        return matchesCarat && matchesLab && matchesShape && matchesColor && matchesClarity;
      }).toList();

      emit(DiamondLoaded(filteredDiamonds));
    });

    on<SortDiamonds>((event, emit) {
      if (state is DiamondLoaded) {
        var sortedDiamonds = List<Diamond>.from((state as DiamondLoaded).diamonds);
        sortedDiamonds.sort((a, b) {
          if (event.sortByPriceAsc) {
            return a.finalAmount.compareTo(b.finalAmount);
          } else if (!event.sortByPriceAsc) {
            return b.finalAmount.compareTo(a.finalAmount);
          } else if (event.sortByCaratAsc) {
            return a.carat.compareTo(b.carat);
          } else {
            return b.carat.compareTo(a.carat);
          }
        });
        emit(DiamondLoaded(sortedDiamonds));
      }
    });
  }
}
