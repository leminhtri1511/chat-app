import 'package:connectivity_plus/connectivity_plus.dart';

sealed class Result<S, E extends Exception> {
  const Result();

  when(
      {required Function(dynamic service) success,
      required Null Function(dynamic exception) failure}) {}
}

final class Success<S, E extends Exception> extends Result<S, E> {
  const Success(this.value);
  final S value;
}

final class Failure<S, E extends Exception> extends Result<S, E> {
  const Failure(this.exception);
  final E exception;
}

  // Future<void> checkInternetConnection(dynamic dialog) async {
  //   var connectivityResult = await Connectivity().checkConnectivity();
  //   if (connectivityResult == ConnectivityResult.none) {
  //     dialog;
  //   }
  // }

