import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/movies_models.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final movieUri =
      'https://670ef2d6-dbdd-454c-b4d7-6960afb18cc2.mock.pstmn.io/movies';

  MoviesBloc() : super(MoviesInitial()) {
    on<MoviesEvent>((event, emit) async {
      emit(LoadingMovies());
      await _loadMovies().then((movies) => emit(MoviesLoaded(movies)));
    });
  }

  Future<List<Movie>> _loadMovies() async {
    await Future.delayed(const Duration(seconds: 3));
    final response = await http.get(Uri.parse(movieUri));
    var returnValue = <Movie>[];

    if (response.statusCode == 200) {
      final movies = jsonDecode(response.body) as List;
      returnValue = List.generate(
        movies.length,
        (index) => Movie.fromJson(movies[index] as Map<String, dynamic>),
      );
    }
    return returnValue;
  }
}
