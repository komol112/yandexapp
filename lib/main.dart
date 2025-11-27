import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex/core/injection/di.dart';
import 'package:yandex/presentation/blocs/map_bloc.dart';
import 'package:yandex/presentation/screens/carta_screen.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (context) => sl<MapBloc>())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: CartaScreen());
  }
}
