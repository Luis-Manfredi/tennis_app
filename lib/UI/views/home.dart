import 'package:flutter/material.dart';

import '../../Domain/bloc_exports.dart';
import '../../Domain/models/reservation.dart';
import 'reservations.dart';

import '../components/custom_list_tile.dart';
import '../constants/colors.dart';
import '../constants/date.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  static const id = 'Inicio';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            color: primary),
        bottom: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 100),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$currentDay $day de $monthsName, $year',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: lightText)),
                      Text('Inicio',
                          style: TextStyle(color: text, fontSize: 32))
                    ],
                  ),
                ],
              ),
            )),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Luis Manfredi'),
              const SizedBox(width: 10),
              CircleAvatar(
                  radius: 20,
                  backgroundColor: background,
                  backgroundImage: const AssetImage('assets/images/me.jpg'))
            ],
          ),
          const SizedBox(width: 15)
        ],
        shadowColor: Colors.black38,
      ),

      body: BlocBuilder<ReservationBloc, ReservationState>(
        builder: (context, state) {
          List<Reservation> reservationList = state.reservationList;

          return reservationList.isEmpty 
              ? const Center(child: Text('No hay reservaciones', style: TextStyle(color: Colors.black54, fontSize: 24))) 
              : SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 60),
            child: Column(
                children: reservationList.map((reservation) => CustomListTile(reservation: reservation)).toList(),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.pushReplacementNamed(context, Reservations.id),
        backgroundColor: primary,
        foregroundColor: white,
        child: const Icon(Icons.calendar_month_rounded),
      ),
    );
  }
}
