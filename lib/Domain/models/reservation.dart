import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Reservation extends Equatable {
  String title;
  String hours;
  String date;
  String username;
  String image;

  Reservation({
    required this.title,
    required this.hours,
    required this.date,
    required this.username,
    required this.image
  });

  Reservation copyWith({
    String? title,
    String? hours,
    String? date,
    String? username,
    String? image
  }) {
    return Reservation(
      title: title ?? this.title, 
      hours: hours ?? this.hours, 
      date: date ?? this.date, 
      username: username ?? this.date, 
      image: image ?? this.date
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'hours': hours,
      'date': date,
      'username': username,
      'image': image
    };
  }

  factory Reservation.fromMap(Map<String, dynamic> map) {
    return Reservation(
      title: map['title'] ?? '', 
      hours: map['hours'] ?? '', 
      date: map['date'] ?? '', 
      username: map['username'] ?? '', 
      image: map['image'] ?? ''
    );
  }
  
  @override
  List<Object?> get props => [
    title,
    hours,
    date,
    username,
    image
  ];
}