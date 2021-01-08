import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trailerfilm_app/bloc/get_now_playing_bloc.dart';
import 'package:trailerfilm_app/model/movie.dart';
import 'package:trailerfilm_app/model/movie_response.dart';
import 'package:trailerfilm_app/screens/detail_screen.dart';
import 'package:trailerfilm_app/theme/colors.dart' as Style;

class CardTinder extends StatefulWidget {
  @override
  _CardTinderState createState() => _CardTinderState();
}

class _CardTinderState extends State<CardTinder> {
  @override
  void initState() {
    super.initState();
    nowPlayingMoviesBloc..getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<MovieResponse>(
        stream: nowPlayingMoviesBloc.subject.stream,
        builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return _buildErrorWidget(snapshot.data.error);
            }
            return _buildHomeWidget(snapshot.data);
          } else if (snapshot.hasError)
            return _buildErrorWidget(snapshot.error);
          else
            return _buildLoadingWidget();
        },
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 25.0,
            width: 25.0,
            child: CircularProgressIndicator(
              valueColor:
                new AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 4.0,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Error occured: $error"),
        ],
      ),
    );
  }

  Widget _buildHomeWidget(MovieResponse data) {
    List<Movie> movies = data.movies;
    if (movies.length == 0) {
      return Container();
    }
    else {
      return Container(
        height: 220.0,
        child: TinderSwapCard(
          orientation: AmassOrientation.TOP,
          totalNum: movies.length,
          stackNum: 3,
          maxWidth: MediaQuery.of(context).size.width*1.0,
          maxHeight: MediaQuery.of(context).size.width*1.0,
          minWidth: MediaQuery.of(context).size.width*0.8,
          minHeight: MediaQuery.of(context).size.width*0.8,
          cardBuilder: (context, index) => Card(
            child: GestureDetector(
              onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailScreen(movie: movies[index]),
                    ),
                  );
                },
                child: Stack(
                  children: <Widget>[
                    Hero(
                      tag: movies[index].id,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 220.0,
                        decoration: new BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage("https://image.tmdb.org/t/p/w500/" + movies[index].backPoster)
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     gradient: LinearGradient(
                    //       begin: Alignment.bottomCenter,
                    //       end: Alignment.topCenter,
                    //       stops: [
                    //         0.0,
                    //         0.9
                    //       ],
                    //       colors: [
                    //         Style.Colors.mainColor.withOpacity(1.0),
                    //         Style.Colors.mainColor.withOpacity(0.0)
                    //       ]
                    //     ),
                    //   ),
                    // ),
                    Positioned(
                      bottom: 0.0,
                      top: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Icon(FontAwesomeIcons.playCircle, color: Style.Colors.secondColor, size: 40.0,)
                    ),
                    Positioned(
                      bottom: 30.0,
                      child: Container(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        width: 250.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                          Text(
                            movies[index].title,
                            style: TextStyle(
                              height: 1.5,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}