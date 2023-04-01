part of 'reservation_bloc.dart';

abstract class ReservationEvent extends Equatable {
  const ReservationEvent();

  @override
  List<Object> get props => [];
}

class AddReservation extends ReservationEvent {
  final Reservation reservation;
  const AddReservation({
    required this.reservation
  });

  @override
  List<Object> get props => [reservation]; 
}

class DeleteReservation extends ReservationEvent {
  final Reservation reservation;
  const DeleteReservation({
    required this.reservation
  });

  @override
  List<Object> get props => [reservation];
}