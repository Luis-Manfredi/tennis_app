import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tennis_app/Domain/bloc_exports.dart';

import '../../Domain/models/reservation.dart';
import '../../Domain/models/user.dart';
import '../constants/colors.dart';
import 'home.dart';

class Reservations extends StatefulWidget {
  const Reservations({super.key});

  static const id = 'Reservaciones';

  @override
  State<Reservations> createState() => _ReservationsState();
}

class _ReservationsState extends State<Reservations> {
  String? courtSelected;
  String? hourRange;
  User? userSelected;
  DateTime date = DateTime.now();

  List<String> courtsList = ['Cancha A', 'Cancha B', 'Cancha C'];
  List<String> hours = [
    '9:00 - 12:00',
    '14:00 - 17:00',
    '17:00 - 20:00',
  ];
  List<User> users = [
    User(
        name: 'Luis Manfredi',
        imagePath: 'https://avatars.githubusercontent.com/u/75541418?v=4'),
    User(
        name: 'Anna Patrick',
        imagePath:
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'),
    User(
        name: 'John Doe',
        imagePath:
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'),
    User(
        name: 'Karen Smith',
        imagePath:
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: primary),
        leading: IconButton(
            onPressed: () => Navigator.pushReplacementNamed(context, Home.id),
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        shadowColor: Colors.black38,
        bottom: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 100),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Reservar',
                          style: TextStyle(color: text, fontSize: 32)),
                      Text('Seleccione las opciones para realizar su reserva',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: lightText))
                    ],
                  ),
                ],
              ),
            )),
        actions: [
          IconButton(
              onPressed: () {},
              color: primary,
              icon: const Icon(Icons.help_outline_rounded)),
          const SizedBox(width: 10)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Court selection
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text('Elegir una cancha',
                      style: TextStyle(fontSize: 20, color: primary)),
                ),
                const SizedBox(height: 5),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: DropdownButton(
                    value: courtSelected,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    underline: Container(),
                    borderRadius: BorderRadius.circular(15),
                    isExpanded: true,
                    hint: const Text('Seleccione una cancha'),
                    items: courtsList
                        .map((court) => DropdownMenuItem(
                              value: court,
                              child: Text(court),
                            ))
                        .toList(),
                    onChanged: (value) =>
                        setState(() => courtSelected = value ?? ''),
                  ),
                ),

                const SizedBox(height: 20),

                // Hours selection
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text('Elegir una horario',
                      style: TextStyle(fontSize: 20, color: primary)),
                ),
                const SizedBox(height: 5),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: DropdownButton(
                    value: hourRange,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    underline: Container(),
                    borderRadius: BorderRadius.circular(15),
                    isExpanded: true,
                    hint: const Text('Seleccione un horario'),
                    items: hours
                        .map((hour) => DropdownMenuItem(
                              value: hour,
                              child: Text(hour),
                            ))
                        .toList(),
                    onChanged: (value) =>
                        setState(() => hourRange = value ?? ''),
                  ),
                ),

                const SizedBox(height: 20),

                // Date selection
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text('Seleccionar una fecha',
                      style: TextStyle(fontSize: 20, color: primary)),
                ),
                const SizedBox(height: 5),
                ElevatedButton(
                    onPressed: () async {
                      DateTime? selectedDate = await showDatePicker(
                          fieldHintText: 'Seleccionar fecha',
                          cancelText: 'CANCELAR',
                          confirmText: 'CONFIRMAR',
                          builder: (context, child) => Theme(
                              data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.light(
                                primary: primary,
                              )),
                              child: child!),
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2023),
                          lastDate: DateTime(2100));
                      setState(() {
                        date = selectedDate ?? DateTime.now();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      backgroundColor: white,
                      foregroundColor: primary,
                      elevation: 0,
                      minimumSize: Size(MediaQuery.of(context).size.width, 65),
                    ),
                    child: Text(
                        DateFormat()
                            .add_yMd()
                            .format(DateTime.parse(date.toString())),
                        style: const TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w400,
                            fontSize: 16))),

                const SizedBox(height: 20),

                // Select User
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text('Elegir un usuario',
                      style: TextStyle(fontSize: 20, color: primary)),
                ),
                const SizedBox(height: 5),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: DropdownButton(
                    value: userSelected,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    underline: Container(),
                    borderRadius: BorderRadius.circular(15),
                    isExpanded: true,
                    hint: const Text('Seleccione un usuario'),
                    items: users
                        .map((user) => DropdownMenuItem(
                              value: user,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(user.imagePath),
                                      backgroundColor: primary,
                                      radius: 18),
                                  const SizedBox(width: 10),
                                  Text(user.name),
                                ],
                              ),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() {
                      userSelected = value;
                    }),
                  ),
                ),
              ],
            ),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                      colors: [primary, secondary],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight)),
              child: BlocBuilder<ReservationBloc, ReservationState>(
                builder: (context, state) {
                  List<Reservation> reservations = state.reservationList;

                  return ElevatedButton.icon(
                      onPressed: () {
                        var newReservation = Reservation(
                          title: courtSelected ?? '',
                          hours: hourRange ?? '',
                          date: DateFormat().add_yMd().format(DateTime.parse(date.toString())),
                          username: userSelected == null ? '' : userSelected!.name,
                          image: userSelected == null ? '' : userSelected!.imagePath
                        );
                        
                        if (courtSelected == null || hourRange == null) {
                          errorDialog(context, 'Debe elegir una cancha y un horario para procesar su reserva.');
                        } 
                        else if (reservations.isEmpty) {
                          context.read<ReservationBloc>().add(AddReservation(reservation: newReservation));
                          Navigator.pushReplacementNamed(context, Home.id);
                        }
                        else {
                          for (var reservation in reservations) {
                            if (reservation.hours == newReservation.hours && reservation.date == newReservation.date) {
                              errorDialog(context, 'Esta cancha no está disponible para este horario y fecha. Pruebe en cambiar el horario, la fecha o la cancha e intente de nuevo.');
                            } else {
                              context.read<ReservationBloc>().add(AddReservation(reservation: newReservation));
                              Navigator.pushReplacementNamed(context, Home.id);
                            }
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      label: Icon(Icons.calendar_today_rounded, color: white),
                      icon: Text('Guardar reservación',
                          style: TextStyle(color: white, fontSize: 20)));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> errorDialog(BuildContext context, String errorMsg) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text('Reserva fallida'),
        content: Text(errorMsg),
        actionsPadding: const EdgeInsets.only(right: 15, bottom: 15),
        actions: [
          Container(
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                    colors: [primary, secondary],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight)),
            child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: Text('Entendido',
                    style: TextStyle(color: white, fontSize: 16))),
          )
        ],
      ),
    );
  }
}
