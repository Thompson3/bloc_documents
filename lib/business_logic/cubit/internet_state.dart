part of 'internet_cubit.dart';

@immutable
abstract class InternetState {}

// to indicate when network is loading, when it's delayed.
class InternetLoading extends InternetState {}

class InternetConnected extends InternetState {
  final ConnectionType connectionType;

// defines if the internet is on wifi or mobile
  InternetConnected({required this.connectionType});
}

class InternetDisconnected extends InternetState {}
