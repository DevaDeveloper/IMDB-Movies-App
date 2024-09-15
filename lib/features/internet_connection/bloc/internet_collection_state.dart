import 'package:equatable/equatable.dart';

abstract class InternetConnectionState extends Equatable {
  const InternetConnectionState();
}

class HasInternetConnectionStateInitital extends InternetConnectionState {
  const HasInternetConnectionStateInitital();

  @override
  List<Object?> get props => [];
}

class HasInternetConnectionState extends InternetConnectionState {
  const HasInternetConnectionState();

  @override
  List<Object?> get props => [];
}

class LostInternetConnectionState extends InternetConnectionState {
  const LostInternetConnectionState();

  @override
  List<Object?> get props => [];
}
