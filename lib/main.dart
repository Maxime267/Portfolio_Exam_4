import 'package:bloc_demo/logic/movies/bloc/movies_bloc.dart';
import 'package:bloc_demo/presentation/screens/show_movies_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (BuildContext context) => MoviesBloc(),
        child: const MainScreen(),
      ),
    ),
  );
}
