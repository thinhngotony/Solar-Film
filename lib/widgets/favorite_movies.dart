import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:trailerfilm_app/model/movie.dart';
import 'package:trailerfilm_app/screens/detail_screen.dart';
import 'package:trailerfilm_app/theme/colors.dart' as Style;

class FavoriteMovies extends StatefulWidget {
  List<Movie> movies;
  FavoriteMovies({Key key, @required this.movies}) : super(key: key);
  @override
  _FavoriteMoviesState createState() => _FavoriteMoviesState(movies);
}

class _FavoriteMoviesState extends State<FavoriteMovies> {
  List<Movie> movies;
  _FavoriteMoviesState(this.movies);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.Colors.backgroundColor,
        title: new Text("Yêu thích"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: movies.length == 0 || movies == null ?
        Expanded(
          child: Center(
            child: Text(
              "No result"
            ),
          ),
        )
      : Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailScreen(movie: movies[index]),
                        ),
                      );
                    },
                    child: Card(
                      child: Row(
                          children: <Widget>[
                            Hero(
                              tag: movies[index].id,
                              child: Container(
                                  height: 150,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(5),
                                        topLeft: Radius.circular(5),
                                      ),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: movies[index].poster != null ? NetworkImage(
                                              "https://image.tmdb.org/t/p/w200/" + movies[index].poster
                                          ) :
                                          AssetImage("assets/image/empty.gif")
                                      )
                                  )
                              ),
                            ),
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                height: 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      movies[index].title,
                                      // overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 5.0),
                                    RatingBar.builder(
                                      itemSize: 10.0,
                                      initialRating: movies[index].rating / 2,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                                      itemBuilder: (context, _) => Icon(
                                        EvaIcons.star,
                                        color: Style.Colors.secondColor,
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: 240,
                                      child: Text(
                                        movies[index].overview,
                                        maxLines: 3,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
    );
  }

}