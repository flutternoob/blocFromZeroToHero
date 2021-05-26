import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_counter_bloc/constants/enums.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity? connectivity;
  StreamSubscription? connectivityStreamSubscription;

  InternetCubit({required this.connectivity}): super(InternetLoading()){
    monitorInternetConnection();
  }

  void monitorInternetConnection() {
    connectivityStreamSubscription = connectivity!.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi) {
        emitInternetConnected(ConnectionType.Wifi);
      }
      else if (connectivityResult == ConnectivityResult.mobile) {
        emitInternetConnected(ConnectionType.Mobile);
      }
      else if (connectivityResult == ConnectivityResult.none) {
        emitInternetDisconnected();
      }
    });
  }

  void emitInternetConnected (ConnectionType _connectionType) => emit(InternetConnected(connectionType: _connectionType));

  void emitInternetDisconnected() => emit(InternetDisconnected());

  @override
  Future<void> close() async {
    connectivityStreamSubscription!.cancel();
    return super.close();
  }
}