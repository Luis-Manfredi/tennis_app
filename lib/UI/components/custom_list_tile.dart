import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

import '../../Data/weather_service.dart';
import '../../Domain/bloc_exports.dart';
import '../../Domain/models/reservation.dart';
import '../../Domain/models/weather.dart';
import '../constants/colors.dart';

class CustomListTile extends StatefulWidget {
  const CustomListTile({
    super.key, 
    required this.reservation
  });

  final Reservation reservation;

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {

  WeatherService weatherService = WeatherService();
  Weather weather = const Weather();

  Future<Weather> getWeather() async {
    weather = await weatherService.getWeatherData('Caracas');
    return weather;
  }

  void deleteReservation (BuildContext context) {
    context.read<ReservationBloc>().add(DeleteReservation(reservation: widget.reservation));
  }

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
    return SizedBox(
      height: 180,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20)
              ),
              child: Image.asset(
                'assets/images/court.png', 
                height: 200, 
                width: 150,
                fit: BoxFit.cover,
              )
            ),
    
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.reservation.title,
                    style: TextStyle(fontSize: 24, color: primary, fontWeight: FontWeight.w500)),
            
                  Chip(label: Text(widget.reservation.hours)),
            
                  RichText(text: TextSpan(
                    text: 'Reservado: ',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500, 
                      color: Colors.black54,
                      fontSize: 14
                    ),
                    children: [
                      TextSpan(text: widget.reservation.date, 
                        style: const TextStyle(color: Colors.black))
                    ]
                  )),
            
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(backgroundColor: primary, backgroundImage: NetworkImage(widget.reservation.image)),
                      const SizedBox(width: 5),
                      Text(widget.reservation.username, style: const TextStyle(fontWeight: FontWeight.w500))
                    ],
                  )
                ],
              ),
            ),

            PopupMenuButton(
              icon: const Icon(Icons.more_vert, color: Colors.black87),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              itemBuilder: (context) => [
              PopupMenuItem(
                child: TextButton.icon(
                  onPressed: () async {
                    Navigator.pop(context);
                    await getWeather();
                    if (context.mounted) detailsDialog(context);
                  }, 
                  style: TextButton.styleFrom(foregroundColor: primary),
                  icon: const Icon(Icons.info_outline_rounded), 
                  label: const Text('Detalles')
                )),
              PopupMenuItem(
                onTap: () => deleteReservation(context),
                child: TextButton.icon(
                  onPressed: null, 
                  style: TextButton.styleFrom(disabledForegroundColor: primary),
                  icon: const Icon(Icons.delete), 
                  label: const Text('Eliminar')
                ))
            ])
          ],
        ),
      ),
    );
  }

  Future<dynamic> detailsDialog(BuildContext context) {
    var currentDate = '${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}';

    return showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Información', style: TextStyle(fontSize: 26)),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Cancha reservada'),
                    Text(widget.reservation.title, style: TextStyle(color: primary))
                  ],
                ),   
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Día'),
                    Text(widget.reservation.date, style: TextStyle(color: primary))
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Horario'),
                    Text(widget.reservation.hours, style: TextStyle(color: primary))
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Usuario'),
                    Text(widget.reservation.username, style: TextStyle(color: primary))
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),
            const Divider(color: Colors.black54),
            const SizedBox(height: 20),

            widget.reservation.date == currentDate 
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Información del clima', style: TextStyle(color: primary, fontSize: 20, fontWeight: FontWeight.w500)),
                      const SizedBox(width: 10),
                      Icon(Icons.cloud_queue_rounded, color: primary)
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text('${weather.temperature}', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w500)),
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
          Container(
            height: 40,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                colors: [primary, secondary],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight
              )
            ),
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                shadowColor: Colors.transparent,
              ),
              child: const Text('Cerrar', style: TextStyle(fontSize: 16))
            ),
          )
        ],
      ),
    );
  }
}