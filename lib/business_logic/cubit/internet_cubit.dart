// ignore_for_file: unrelated_type_equality_checks, no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_class/constants/enums.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  late StreamSubscription connectivityStreamSubscription;

  // Single constructor
  InternetCubit({required this.connectivity}) : super(InternetLoading()) {
    checkCurrentConnection(); // Check initial connection state
    monitorInternetConnection(); // Start monitoring connection changes
  }

  // Check the current connection state when the app starts
  void checkCurrentConnection() async {
    var result = await connectivity.checkConnectivity();
    if (result == ConnectivityResult.wifi) {
      emitInternetConnected(ConnectionType.Wifi);
    } else if (result == ConnectivityResult.mobile) {
      emitInternetConnected(ConnectionType.Mobile);
    } else {
      emitInternetDisconnected();
    }
  }

  // Monitor connectivity changes during app runtime
  void monitorInternetConnection() {
    connectivityStreamSubscription = connectivity.onConnectivityChanged
        .cast<ConnectivityResult>()
        .listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi) {
        emitInternetConnected(ConnectionType.Wifi);
      } else if (connectivityResult == ConnectivityResult.mobile) {
        emitInternetConnected(ConnectionType.Mobile);
      } else if (connectivityResult == ConnectivityResult.none) {
        emitInternetDisconnected();
      }
    });
  }

  void emitInternetConnected(ConnectionType connectionType) =>
      emit(InternetConnected(connectionType: connectionType));

  void emitInternetDisconnected() => emit(InternetDisconnected());

  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}
