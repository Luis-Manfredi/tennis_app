import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tennis_app/Domain/models/reservation.dart';

part 'reservation_event.dart';
part 'reservation_state.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  ReservationBloc() : super(ReservationInitial()) {
    on<AddReservation>(_onAddReservation);
    on<DeleteReservation>(_onDeleteReservation);
  }

  void _onAddReservation(AddReservation event, Emitter<ReservationState> emit) {
    final state = this.state;
    emit(ReservationState(
      reservationList: List.from(state.reservationList)..add(event.reservation)
    ));
  }

  void _onDeleteReservation(DeleteReservation event, Emitter<ReservationState> emit) {
    final state = this.state;
    emit(ReservationState(
      reservationList: List.from(state.reservationList)..remove(event.reservation)
    ));
  }
}
