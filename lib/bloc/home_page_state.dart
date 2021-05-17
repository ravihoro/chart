part of 'home_page_cubit.dart';

abstract class HomePageState {}

class InitialHomePageState extends HomePageState {}

class LoadingHomePageState extends HomePageState {}

class LoadedHomePageState extends HomePageState {
  final List<PerformanceModel> dataList;

  LoadedHomePageState({@required this.dataList});
}

class FailedHomePageState extends HomePageState {
  final Exception exception;

  FailedHomePageState({@required this.exception});
}
