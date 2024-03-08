import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutix/api/api.dart';
import 'package:flutix/model/transaction.dart';
import 'package:meta/meta.dart';

part 'my_wallet_event.dart';
part 'my_wallet_state.dart';

class MyWalletBloc extends Bloc<MyWalletEvent, MyWalletState> {
  final Api api;
  MyWalletBloc({required this.api}) : super(MyWalletInitial()) {
    on<LoadMyWallet>((event, emit) async {
      emit(MyWalletLoading());

      try {
        final result = await api.getFirestoreTransactions(event.email);
        emit(MyWalletLoaded(result));
      } catch (error) {
        emit(MyWalletError(error.toString()));
      }
    });
  }
}
