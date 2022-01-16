part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

// STATE 1
class HomeLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

// STATE 2
class HomeLoadedState extends HomeState {
  final String activityName;
  final String activityType;
  final int participants;

  const HomeLoadedState(
    this.activityName,
    this.activityType,
    this.participants,
  );

  @override
  List<Object?> get props => [activityName, activityType, participants];
}

// STATE 3
class HomeNoInternetState extends HomeState {
  @override
  List<Object?> get props => [];
}
