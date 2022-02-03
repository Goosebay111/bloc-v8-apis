import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sampleapi/home/bloc/home_bloc.dart';
import 'package:sampleapi/services/boredService.dart';
import 'package:sampleapi/services/connectivityService.dart';

///
///
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        //Services used in the widgets.
        RepositoryProvider.of<BoredService>(context),
        RepositoryProvider.of<ConnectivityService>(context),
      )..add(LoadApiEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Activities for bored people'),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is HomeLoadedState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  Center(
                      child: Text(
                    state.activityName,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.lato(fontSize: 28),
                    maxLines: 2,
                  )),
                  Center(child: Text(state.activityType)),
                  Center(
                    child: Text(
                      state.participants.toString(),
                    ),
                  ),
                  const Spacer(),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => BlocProvider.of<HomeBloc>(context)
                          .add(LoadApiEvent()),
                      child: const Text('LOAD NEXT'),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              );
            }
            if (state is HomeNoInternetState) {
              return const Text('no internet :(');
            }
            return Container();
          },
        ),
      ),
    );
  }
}
