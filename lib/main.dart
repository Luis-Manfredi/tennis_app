import 'package:flutter/material.dart';

import 'Domain/bloc_exports.dart';
import 'UI/constants/colors.dart';
import 'UI/views/welcome.dart';
import 'UI/services/router_service.dart';

void main() {
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReservationBloc(),
      child: BlocBuilder<ReservationBloc, ReservationState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Tennis App',
            theme: ThemeData(
              fontFamily: 'Montserrat',
              appBarTheme:
                  AppBarTheme(backgroundColor: white, foregroundColor: text),
              backgroundColor: background,
              scaffoldBackgroundColor: background,
            ),
            debugShowCheckedModeBanner: false,
            home: const Welcome(),
            onGenerateRoute: appRouter.onGeneratedRoute,
          );
        },
      ),
    );
  }
}
