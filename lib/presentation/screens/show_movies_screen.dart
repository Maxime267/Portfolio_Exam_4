
import 'package:flutter/material.dart';

import '../widgets/movies_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: ShowMoviesWidget());
  }
}