// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:trailerfilm_app/model/paginated_search_results.dart';
// // import 'package:trailerfilm_app/model/search_result.dart';
// // import 'package:trailerfilm_app/widgets/detail_image_widget.dart';
//
// // import '../config.dart';
//
// // class SearchMovies extends StatefulWidget {
// //   @override
// //   _SearchMoviesState createState() => _SearchMoviesState();
// // }
//
// // class _SearchMoviesState extends State<SearchMovies> {
// //   String  searchQuery;
// //   PaginatedSearchResults searchResults;
//
// //   @override
// //   Widget build(BuildContext context) {
//    
// //   }
//
// // }
//
// // class SearchMovieWidget extends StatelessWidget {
// //   PaginatedSearchResults results;
// //   SearchMovieWidget(this.results);
//
// //   @override
// //   Widget build(BuildContext context) {
// //     return ListView.builder(
// //         shrinkWrap: true,
// //         itemCount: results?.results?.length ?? 0,
// //         itemBuilder: (BuildContext context, int index) {
// //           var movie = results.results[index];
// //           var container = Container(
// //               width: 200,
// //               child: _buildMovieWidget(context, movie, "searchResult", index));
// //           return container;
// //         });
// //   }
//
// //   _buildMovieWidget(
// //       BuildContext context, SearchResult movie, String heroKey, int index) {
// //     var posterUrl = "$IMAGE_URL_500${movie.poster_path}";
// //     var detailUrl = "$IMAGE_URL_500${movie.backdrop_path}";
// //     var heroTag = "${movie.id.toString()}$heroKey";
//
// //     return DetailImageWidget(
// //       posterUrl,
// //       movie.title,
// //       index,
// //       callback: (index) {
// //         Navigator.of(context)
// //             .push(MaterialPageRoute(builder: (BuildContext context) {
// //           return MovieDetailPage(movie.id, movie.title, detailUrl, heroTag);
// //         }));
// //       },
// //       heroTag: heroTag,
// //     );
// //   }
// // }
//
//
// import 'dart:async';
//
// import 'package:dio/dio.dart';
// import 'package:eva_icons_flutter/eva_icons_flutter.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:trailerfilm_app/model/movie.dart';
// import 'package:trailerfilm_app/bloc/get_result_movies_bloc.dart';
// import 'package:trailerfilm_app/model/movie_response.dart';
// import 'package:trailerfilm_app/screens/detail_screen.dart';
// import 'package:trailerfilm_app/theme/colors.dart' as Style;
// import 'package:trailerfilm_app/widgets/result_movies.dart';
//
// class SearchFilm extends StatefulWidget {
//   @override
//   _SearchFilmState createState() =>  _SearchFilmState();
// }
// _SearchFilmState
// class _SearchFilmState extends State<SearchFilm> {
//   String query="";
//   TextEditingController controller = new TextEditingController();
//   final dio = new Dio();
//   List<MovieResponse> movieResponse = new List();
//
//   void _getMovies() async {
//     final response = await dio.get("");
//   }
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
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
//
//   onSearchTextChanged(String text) async {
//     if (text.isEmpty) {
//       setState(() {});
//       return;
//     }
//     setState(() {});
//   }
//  
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         new Container(
//           color: Theme.of(context).primaryColor,
//           child: new Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Card(
//               child: ListTile(
//                 leading: new Icon(Icons.search),
//                 title: new TextField(
//                   controller: controller,
//                   decoration: new InputDecoration(
//                     hintText: 'Search', border: InputBorder.none
//                   ),
//                   onChanged: onSearchTextChanged,
//                 ),
//                 trailing: new IconButton(icon: new Icon(Icons.cancel), onPressed: () {
//                   controller.clear();
//                   onSearchTextChanged('');
//                 },),
//               ),
//             ),
//           ),
//         ),
//        
//         // new Expanded(
//         //   child: movies.length != 0 || controller.text.isNotEmpty ? 
//         //     new ListView.builder(
//         //       itemCount: movies.length,
//         //       itemBuilder: (context, index) {
//         //         return Column(
//         //           children: <Widget>[
//         //             GestureDetector(
//         //               onTap: () {
//         //               movies[index].backPoster != null ?
//         //                 Navigator.push(
//         //                   context,
//         //                   MaterialPageRoute(
//         //                     builder: (context) => MovieDetailScreen(movie: movies[index]),
//         //                   ),
//         //                 )
//         //               : showSnackBar(context);
//         //             },
//         //             child: Card(
//         //               child: Row(
//         //                 children: <Widget>[
//         //                   Hero(
//         //                     tag: movies[index].id,
//         //                     child: Container(
//         //                       height: 150,
//         //                       width: 100,
//         //                       decoration: BoxDecoration(
//         //                         borderRadius: BorderRadius.only(
//         //                           bottomLeft: Radius.circular(5),
//         //                           topLeft: Radius.circular(5),
//         //                         ),
//         //                         image: DecorationImage(
//         //                           fit: BoxFit.cover,
//         //                           image: movies[index].poster != null ? NetworkImage(
//         //                             "https://image.tmdb.org/t/p/w200/" + movies[index].poster
//         //                           ) :
//         //                           AssetImage("assets/image/empty.gif")
//         //                         )
//         //                       )
//         //                     ),
//         //                   ),
//         //                   Flexible(
//         //                     child: Container(
//         //                       padding: const EdgeInsets.all(10),
//         //                       height: 150,
//         //                       child: Column(
//         //                         crossAxisAlignment: CrossAxisAlignment.start,
//         //                         children: <Widget>[
//         //                           Text(
//         //                             movies[index].title,
//         //                             // overflow: TextOverflow.ellipsis,
//         //                             style: TextStyle(
//         //                               fontSize: 16,
//         //                               fontWeight: FontWeight.bold,
//         //                             ),
//         //                           ),
//         //                           SizedBox(width: 5.0),
//         //                           RatingBar.builder(
//         //                             itemSize: 10.0,
//         //                             initialRating: movies[index].rating / 2,
//         //                             minRating: 1,
//         //                             direction: Axis.horizontal,
//         //                             allowHalfRating: true,
//         //                             itemCount: 5,
//         //                             itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
//         //                             itemBuilder: (context, _) => Icon(
//         //                               EvaIcons.star,
//         //                               color: Style.Colors.secondColor,
//         //                             ),
//         //                             onRatingUpdate: (rating) {
//         //                               print(rating);
//         //                             },
//         //                           ),
//         //                           SizedBox(
//         //                             height: 10,
//         //                           ),
//         //                           Container(
//         //                             width: 240,
//         //                             child: Text(
//         //                               movies[index].overview,
//         //                               maxLines: 3,
//         //                             ),
//         //                           ),
//         //                         ],
//         //                       ),
//         //                     ),
//         //                   ),
//         //                 ]
//         //               ),
//         //             ),
//         //             )
//         //           ],
//         //         );
//         //       }
//         //     ) :
//         //     new Container(),
//         // ),
//       ],
//     );
//   }
// }