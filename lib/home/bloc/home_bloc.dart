import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:sampleapi/services/boredService.dart';
import 'package:sampleapi/services/connectivityService.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BoredService _boredService;
  final ConnectivityService _connectivityService;

  HomeBloc(this._boredService, this._connectivityService)
      : super(HomeLoadingState()) {
    // check that internet is available state from non bloc package, see pubspec.yaml.
    /// this code is for alerting client to no internet connection.
    // _connectivityService.connectivityStream.stream.listen((event) {
    //   if (event == ConnectivityResult.none) {
    //     print('no internet');
    //     add(NoInternetEvent());
    //   } else {
    //     print('yes internet');
    //     add(LoadApiEvent());
    //   }
    // });

// State from Event 1)
    on<LoadApiEvent>((event, emit) async {
      // State 1: while loading HomeLoadingState: the circular progress indicator is shown.
      emit(HomeLoadingState());
      // get the data from the api.
      final activity = await _boredService.getBoredActivity();
      // State 2: after awaited data returns, HomeLoadedState: is active.
      emit(HomeLoadedState(
          activity.activity, activity.type, activity.participants));
    });
    // State 3: NoInternetState: is active.
    on<NoInternetEvent>((event, emit) {
      emit(HomeNoInternetState());
    });
  }
}
