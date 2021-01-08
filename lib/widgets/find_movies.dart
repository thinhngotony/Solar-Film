import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:trailerfilm_app/model/movie.dart';
import 'package:trailerfilm_app/model/movie_response.dart';
import 'package:trailerfilm_app/repository/repository.g.dart';
import 'package:trailerfilm_app/screens/detail_screen.dart';
import 'package:trailerfilm_app/widgets/result_movies.dart';
import 'package:trailerfilm_app/theme/colors.dart' as Style;

class FindMovies extends StatefulWidget {
  @override
  _FindMoviesState createState() => _FindMoviesState();
}

class _FindMoviesState extends State<FindMovies> {
  _FindMoviesState();
  TextEditingController searchTextController = new TextEditingController();
  String searchText = "";
  MovieResponse movieResponse;

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            child: Row(children: <Widget>[
              Flexible(
                child: TextField(
                  controller: searchTextController, 
                  decoration:InputDecoration(hintText: 'Enter a search term'),
                ),
              ),
              IconButton(
                icon: Icon(Icons.search),
                tooltip: 'Search Movies',
                onPressed: () async {
                    
                  setState(() {
                    searchText = searchTextController.text;
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                    var call = SearchMovies.getIntance().search(searchText);
                    call.then((result) {
                      setState(() {
                        this.movieResponse = result;
                      });
                    });
                  });
                },
              ),
            ]),
          padding: EdgeInsets.all(10),
          ),
          if (searchText.length > 0)
            SearchMoviesWidget(movieResponse),
        ],
      )
    );
  }
}
class SearchMoviesWidget extends StatelessWidget {
  MovieResponse movieResponse;
  SearchMoviesWidget(this.movieResponse);
  void showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text('The movie not found!'),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: 'Done',
        textColor: Colors.white,
        onPressed: () {
          print('Done pressed!');
        }
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }
  @override
  Widget build(BuildContext context) {
    List<Movie> movies;
    print("response" + movieResponse.toString());
    if (movieResponse != null)
    {
      movies = movieResponse.movies;
      return Expanded(
              child: ListView.builder(
          shrinkWrap: true,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          movies[index].backPoster != null ?
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailScreen(movie: movies[index]),
                              ),
                            )
                          : showSnackBar(context);
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
      );
    }
      
    else {
      return Expanded(
        child: Center(child: Text("No result"),)
      );
    };
  }

}