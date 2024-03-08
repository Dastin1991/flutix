part of 'my_wallet_bloc.dart';

@immutable
sealed class MyWalletState {}

final class MyWalletInitial extends MyWalletState {}

final class MyWalletLoading extends MyWalletState {}

final class MyWalletLoaded extends MyWalletState {
  final List<Transactions> transaction;
  MyWalletLoaded(this.transaction);
}

final class MyWalletError extends MyWalletState {
  final String error;
  MyWalletError(this.error);
}
