import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreenTabCubit extends Cubit<int> {
  MainScreenTabCubit() : super(0);

  void setTab(int tab) {
    assert(tab >= 0 && tab <= 2);

    emit(tab);
  }
}
