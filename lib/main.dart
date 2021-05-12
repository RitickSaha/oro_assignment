/// [Starting Time For the Project] : 5:12 PM 10-05-2021
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:oro_task/bloc/bloc_base_provider.dart';
import 'package:oro_task/bloc/visitBloc.dart';
import 'package:oro_task/pages/home/oroHome_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      home: BlocProvider<VisitBloc>(
        bloc: VisitBloc(),
        child: OroTaskHome(),
      ),
    ),
  );
}
