import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tennis_app/UI/bloc_exports.dart';

import '../../Controllers/weather_controller.dart';
import '../../Data/local/courts_data.dart';
import '../../Data/local/users_list.dart';
import '../../Data/remote/weather_service.dart';
import '../../Domain/entities/reservation.dart';
import '../../Domain/entities/user.dart';
import '../../Domain/entities/weather.dart';
import '../reservations_bloc/reservation_bloc.dart';
import '../components/custom_button.dart';
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
  Weather weather = const Weather();

  getWeatherIcon() {
    if (weather.chanceOfRain > 60) {
      return Icon(Ionicons.rainy, color: primary);
    } else if (weather.chanceOfRain > 30) {
      return Icon(Ionicons.cloudy, color: primary);
    } else {
      return Icon(Ionicons.sunny, color: primary);
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: primary),
        leadingWidth: 120,
        leading: TextButton.icon(
          onPressed: () => Navigator.pushReplacementNamed(context, Home.id),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            foregroundColor: primary
          ),
          icon: const Icon(Icons.arrow_back_ios_new_rounded), 
          label: const Text('Regresar')
        ),
        shadowColor: Colors.black38,
        bottom: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 80),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Reservar',
                          style: TextStyle(color: text, fontSize: 32)),
                      Text('Continue para realizar su reserva',
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Selección de cancha
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
                    hint: Text('Seleccione una cancha', style: TextStyle(color: primary, fontWeight: FontWeight.w500)),
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

                const SizedBox(height: 15),

                // Seleeción de horario
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
                    hint: Text('Seleccione un horario', style: TextStyle(color: primary, fontWeight: FontWeight.w500)),
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

                const SizedBox(height: 15),

                // Selección de fecha
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Fecha: ',
                            style: TextStyle(color: primary, fontWeight: FontWeight.w500, fontSize: 16),
                            children: [
                              TextSpan(
                                text: DateFormat()
                                .add_yMd()
                                .format(DateTime.parse(date.toString())),
                                style: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w400),
                              )
                            ]
                          )
                        ),
                        const Icon(Icons.calendar_today_rounded)
                      ],
                    )
                  ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: () async {
                        weather = await WeatherController.getWeather();
                        if (context.mounted) detailsDialog(context);
                      },
                      style: TextButton.styleFrom(foregroundColor: primary), 
                      icon: const Text('Información actual del clima', style: TextStyle(fontSize: 12)), 
                      label: const Icon(Ionicons.cloudy, size: 20)
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Seleccionar usuario
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
                    hint: Text('Seleccione un usuario', style: TextStyle(color: primary, fontWeight: FontWeight.w500)),
                    items: users
                        .map((user) => DropdownMenuItem(
                              value: user,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: primary,
                                    backgroundImage: NetworkImage(user.imagePath),
                                    radius: 18,
                                  ),
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

            // Custom Button
            BlocBuilder<ReservationBloc, ReservationState>(
              builder: (context, state) {
                List<Reservation> reservations = state.reservationList;

                return CustomButton(
                  label: 'Guardar reservación',
                  icon: const Icon(Icons.calendar_month_rounded, color: Colors.white,),
                  fontSize: 20,
                  onPressed: () {
                    // Crear una reservación
                    var newReservation = Reservation(
                        title: courtSelected ?? '',
                        hours: hourRange ?? '',
                        date: DateFormat()
                            .add_yMd()
                            .format(DateTime.parse(date.toString())),
                        username:
                            userSelected == null ? '' : userSelected!.name,
                        image: userSelected == null
                            ? ''
                            : userSelected!.imagePath);

                    // Validar las reservas
                    if (courtSelected == null ||
                        hourRange == null ||
                        userSelected == null) {
                      errorDialog(context,
                          'Debe seleccionar todos los campos para procesar su reserva.');
                    } else if (reservations.isEmpty) {
                      context
                          .read<ReservationBloc>()
                          .add(AddReservation(reservation: newReservation));
                      Navigator.pushReplacementNamed(context, Home.id);
                    } else {
                      for (var reservation in reservations) {
                        if (reservation.hours == newReservation.hours &&
                            reservation.date == newReservation.date) {
                          errorDialog(context,
                              'Esta cancha no está disponible para este horario y fecha. Pruebe en cambiar el horario, la fecha o la cancha e intente de nuevo.');
                        } else {
                          context
                              .read<ReservationBloc>()
                              .add(AddReservation(reservation: newReservation));
                          Navigator.pushReplacementNamed(context, Home.id);
                        }
                      }
                    }
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }

  // Crear dialog para mostrar errores
  Future<dynamic> errorDialog(BuildContext context, String errorMsg) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reserva fallida'),
        content: Text(errorMsg),
        actionsPadding: const EdgeInsets.only(right: 15, bottom: 15),
        actions: [
          // Custom Button
          CustomButton(
            label: 'Entendido',
            fontSize: 16, 
            onPressed: () => Navigator.pop(context),
            width: 120,
            height: 50,
          ),
        ],
      ),
    );
  }

  Future<dynamic> detailsDialog(BuildContext context) {
    var currentDate = '${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}';

    return showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 15),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Información del clima', style: TextStyle(color: primary, fontSize: 20, fontWeight: FontWeight.w500)),
            const SizedBox(width: 10),
            Icon(Icons.cloud_queue_rounded, color: primary)
          ],
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            DateFormat().add_yMd().format(DateTime.parse(date.toString())) == currentDate 
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${weather.temperature}°', style: const TextStyle(fontSize: 46, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${weather.maxTemp.toInt()}°'),
                      const Text(' | '),
                      Text('${weather.minTemp.toInt()}°'),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text.rich(TextSpan(
                        text: 'Prob. de lluvia: ',
                        style: const TextStyle(fontSize: 20),
                        children: [
                          TextSpan(
                            text: '${weather.chanceOfRain}%',
                            style: TextStyle(color: primary, fontSize: 20, fontWeight: FontWeight.w500)
                          )
                        ]
                      )),

                      const SizedBox(width: 5),

                      getWeatherIcon()
                    ],
                  ),

                  const SizedBox(height: 20),
                  SvgPicture.asset('assets/images/weather.svg', height: 150),
                  const SizedBox(height: 20),
                ],
              ) 
            
            : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('No tenemos información del clima para esta fecha.', 
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Icon(Icons.cloud_off_rounded, size: 42, color: Colors.black54)
              ],
            )
          ],
        ),
        actionsPadding: const EdgeInsets.only(right: 20, bottom: 20),
        actions: [
          // Custom Button
          CustomButton(
            label: 'Cerrar',
            fontSize: 16,
            onPressed: () => Navigator.pop(context),
            height: 50,
            width: 120,
          )
        ],
      ),
    );
  }
}
