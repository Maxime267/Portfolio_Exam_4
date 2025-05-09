part of 'movies_bloc.dart';

@immutable
sealed class MoviesEvent {}

final class RequestToLoadAllMovies extends MoviesEvent {}