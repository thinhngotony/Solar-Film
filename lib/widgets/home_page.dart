import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trailerfilm_app/widgets/genres.dart';
import 'package:trailerfilm_app/widgets/now_playing.dart';
import 'package:trailerfilm_app/widgets/persons.dart';
import 'package:trailerfilm_app/widgets/best_movies.dart';
import 'package:trailerfilm_app/theme/colors.dart' as Style;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: <Widget>[
          NowPlaying(),
          GenresScreen(),
          PersonsList(),
          BestMovies(),
        ]
    );
  }
}