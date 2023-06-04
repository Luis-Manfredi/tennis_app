part of 'reservation_bloc.dart';

class ReservationState extends Equatable {
  final List<Reservation> reservationList;
  const ReservationState({
    this.reservationList = const <Reservation>[]
  });
  
  @override
  List<Object> get props => [reservationList];

  Map<String, dynamic> toMap() {
    return {
      'reservationList': reservationList.map((e) => e.toMap()).toList()
    };
  }
}

class ReservationInitial extends ReservationState {}
