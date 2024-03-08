part of 'my_wallet_bloc.dart';

@immutable
sealed class MyWalletEvent {}

final class LoadMyWallet extends MyWalletEvent {
  final String email;

  LoadMyWallet(this.email);
}
