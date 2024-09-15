import 'package:bloc/bloc.dart';
import 'package:imdb_movies_app/features/internet_connection/bloc/internet_collection_state.dart';

class InternetConnectionCubit extends Cubit<InternetConnectionState> {
  InternetConnectionCubit() : super(const HasInternetConnectionStateInitital());

  void handleHasInternetConnection() {
    emit(const HasInternetConnectionState());
  }

  void handleLostInternetConnection() {
    emit(const LostInternetConnectionState());
  }
}
