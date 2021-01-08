// import 'package:eva_icons_flutter/eva_icons_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:trailerfilm_app/bloc/get_result_movies_bloc.dart';
// import 'package:trailerfilm_app/model/movie.dart';
// import 'package:trailerfilm_app/model/movie_response.dart';
// import 'package:trailerfilm_app/screens/detail_screen.dart';
// import 'package:trailerfilm_app/theme/colors.dart' as Style;
//
// class ResultMovies extends StatefulWidget {
//   String query;
//   ResultMovies({this.query});
//   @override
//   _ResultMovies createState() => _ResultMovies();
// }
//
// class _ResultMovies extends State<ResultMovies> {
//   List<Movie> movies;
//   void showSnackBar(BuildContext context) {
//     final snackBar = SnackBar(
//       content: const Text('The movie not found!'),
//       behavior: SnackBarBehavior.floating,
//       duration: const Duration(seconds: 2),
//       action: SnackBarAction(
//         label: 'Done',
//         textColor: Colors.white,
//         onPressed: () {
//           print('Done pressed!');
//         }
//       ),
//     );
//     Scaffold.of(context).showSnackBar(snackBar);
//   }
//   @override
//   void initState() {
//     super.initState();
//     resultMoviesBloc..getResultMovies(widget.query);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<MovieResponse>(
//       stream: resultMoviesBloc.subject.stream,
//       builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
//         if (snapshot.hasData) {
//           if (snapshot.data.error != null && snapshot.data.error.length > 0) {
//             return _buildErrorWidget(snapshot.data.error);
//           }
//           return _buildResultMoviesWidget(snapshot.data);
//         } else if (snapshot.hasError)
//           return _buildErrorWidget(snapshot.error);
//         else
//           return _buildLoadingWidget();
//       },
//     );
//   }
//   Widget _buildLoadingWidget() {
//     return Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SizedBox(
//             height: 25.0,
//             width: 25.0,
//             child: CircularProgressIndicator(
//               valueColor:
//                 new AlwaysStoppedAnimation<Color>(Colors.white),
//               strokeWidth: 4.0,
//             ),
//           )
//         ],
//       );
//   }
//   Widget _buildErrorWidget(String error) {
//     return Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text("Error occured: $error"),
//         ],
//       );
//   }
//   Widget _buildResultMoviesWidget(MovieResponse data) {
//     movies = data.movies;
//     print(movies.length);
//     if (movies.length == 0) {
//       return Container(
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Column(
//               children: <Widget>[
//                 Text(
//                   "No More Movies",
//                   style: TextStyle(color: Colors.black45),
//                 ),
//               ],
//             )
//           ],
//         ),
//       );
//     }
//     else {
//       return Expanded(
//         child: ListView.builder(
//           shrinkWrap: true,
//           scrollDirection: Axis.vertical,
//             itemCount: movies.length,
//             itemBuilder: (context, index) {
//               return Column(
//                 children: <Widget>[
//                   GestureDetector(
//                     onTap: () {
//                       movies[index].backPoster != null ?
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => MovieDetailScreen(movie: movies[index]),
//                           ),
//                         )
//                       : showSnackBar(context);
//                     },
//                     child: Card(
//                       child: Row(
//                         children: <Widget>[
//                           Hero(
//                             tag: movies[index].id,
//                             child: Container(
//                               height: 150,
//                               width: 100,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.only(
//                                   bottomLeft: Radius.circular(5),
//                                   topLeft: Radius.circular(5),
//                                 ),
//                                 image: DecorationImage(
//                                   fit: BoxFit.cover,
//                                   image: movies[index].poster != null ? NetworkImage(
//                                     "https://image.tmdb.org/t/p/w200/" + movies[index].poster
//                                   ) :
//                                   AssetImage("assets/image/empty.gif")
//                                 )
//                               )
//                             ),
//                           ),
//                           Flexible(
//                             child: Container(
//                               padding: const EdgeInsets.all(10),
//                               height: 150,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   Text(
//                                     movies[index].title,
//                                     // overflow: TextOverflow.ellipsis,
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   SizedBox(width: 5.0),
//                                   RatingBar.builder(
//                                     itemSize: 10.0,
//                                     initialRating: movies[index].rating / 2,
//                                     minRating: 1,
//                                     direction: Axis.horizontal,
//                                     allowHalfRating: true,
//                                     itemCount: 5,
//                                     itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
//                                     itemBuilder: (context, _) => Icon(
//                                       EvaIcons.star,
//                                       color: Style.Colors.secondColor,
//                                     ),
//                                     onRatingUpdate: (rating) {
//                                       print(rating);
//                                     },
//                                   ),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   Container(
//                                     width: 240,
//                                     child: Text(
//                                       movies[index].overview,
//                                       maxLines: 3,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ]
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             }
//         ),
//       );
//     }
//   }
// }