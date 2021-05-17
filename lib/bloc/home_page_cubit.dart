import '../model/performance_model.dart';
import 'package:meta/meta.dart';
import '../data/data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(InitialHomePageState());

  void fetchData() async {
    emit(LoadingHomePageState());
    try {
      await Future.delayed(Duration(seconds: 2));
      emit(LoadedHomePageState(dataList: dataList));
    } catch (e) {
      emit(FailedHomePageState(exception: e));
    }
  }
}
