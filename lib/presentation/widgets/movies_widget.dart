import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/movies/bloc/movies_bloc.dart';

class ShowMoviesWidget extends StatefulWidget {
  const ShowMoviesWidget({super.key});

  @override
  State<ShowMoviesWidget> createState() => _ShowMoviesWidgetState();
}

class _ShowMoviesWidgetState extends State<ShowMoviesWidget> {

  @override
  void initState() {
    super.initState();
    context.read<MoviesBloc>().add(RequestToLoadAllMovies());
  }

  @override
Widget build(BuildContext context) {
  return BlocBuilder<MoviesBloc, MoviesState>(
    builder: (context, state) {
      return switch (state) {
        LoadingMovies() => const Center(child: CircularProgressIndicator()),
        MoviesLoaded() => ListView.builder(
          itemCount: state.movies.length,
          itemBuilder: (context, index) {
            final movie = state.movies[index];
            print('Rendering movie at index $index: ${movie.title}');
            
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                color: Colors.white,
                shadowColor: Colors.black.withOpacity(0.2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Stack(
                    children: [
                      // Gradient background for the card
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.blueAccent, Colors.purpleAccent],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Movie Title
                            Text(
                              movie.title ?? 'Unknown Title',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            
                            // Movie Info
                            buildInfoText('Director', movie.director),
                            buildInfoText('Writer', movie.writer),
                            buildInfoText('Genre', movie.genre),
                            buildInfoText('Rated', movie.rated),
                            buildInfoText('Released', movie.released),
                            buildInfoText('Runtime', movie.runtime),
                            buildInfoText('Plot', movie.plot ?? 'No description available'),
                            
                            const SizedBox(height: 12),
                            // Movie Image or Placeholder
                            if ((movie.images?.isNotEmpty ?? false))
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  movie.images![0],
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Text('Image failed to load', style: TextStyle(color: Colors.white)),
                                ),
                              )
                            else
                              const Center(child: Text('No image available', style: TextStyle(color: Colors.white))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        _ => const Center(child: Text('Unexpected state')),
      };
    },
  );
}
}

Widget buildInfoText(String label, String? value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4.0),
    child: Text(
      '$label: ${value ?? 'N/A'}',
      style: const TextStyle(fontSize: 16, color: Colors.white70),
    ),
  );
}
