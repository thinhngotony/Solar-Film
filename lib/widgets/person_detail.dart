import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:trailerfilm_app/bloc/get_person_bloc.dart';
import 'package:trailerfilm_app/model/person.dart';
import 'package:trailerfilm_app/model/person_response.dart';

class PersonDetail extends StatefulWidget {
  final Person person;
  PersonDetail({Key key, @required this.person}) : super(key: key);
  @override
  _PersonDetailState createState() => _PersonDetailState(person);
}

class _PersonDetailState extends State<PersonDetail> {
  final Person person;
  _PersonDetailState(this.person);

  @override
  void initState() {
    super.initState();
    personDetailBloc..getPerson(person.id);
  }

  @override
  void dispose() {
    super.dispose();
    personDetailBloc..drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PersonResponse>(
      stream: personDetailBloc.subject.stream,
      builder: (context, AsyncSnapshot<PersonResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildPersonDetailWidget(snapshot.data);
        } else if (snapshot.hasError)
          return _buildErrorWidget(snapshot.error);
        else 
          return _buildLoadingWidget();
      },
    );
    
    // return Scaffold(
    //   body: ListView(
    //     children: <Widget>[
    //       Observer(
    //         name: 'personImage',
    //         builder: (_) {
    //           return  ? 
    //           Container(
    //             height: 180,
    //             width: _size.width,
    //             padding: EdgeInsets.all(10),
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //               //fix

    //                 widget.id != null ?
    //                   Container(
    //                   width: 140,
    //                   height: 140,
    //                   decoration: BoxDecoration(
    //                     shape: BoxShape.circle,
    //                     image: DecorationImage(
    //                       fit: BoxFit.cover,
    //                       image: NetworkImage(


    //                         //enter url


    //                         ""
    //                       ),
    //                     ),
    //                   ),
    //                 )
    //                 : Container(
    //                   width: 140,
    //                     height: 140,
    //                     decoration: BoxDecoration(
    //                       color: Colors.grey,
    //                       shape: BoxShape.circle,
    //                     ),
    //                     child: Icon(
    //                       Icons.person,
    //                       color: Colors.white, size: 60,
    //                     ),
    //                 ),
    //                 Text(

    //                   //enter name
                      
    //                   "",
    //                   style: TextStyle(
    //                     color: Colors.white,
    //                     height: 3.0,
    //                     fontWeight: FontWeight.bold,
    //                     fontSize: 16.0,
    //                   ), 
    //                 ),
    //                 Column(
    //                   children: [
    //                     Text(
    //                       "Born: ",
    //                       style: TextStyle(
    //                         color: Colors.grey,
    //                       ),
    //                     ),
    //                     Text(
    //                       "From: ",
    //                       style: TextStyle(
    //                         color: Colors.grey,
    //                       ),
    //                     )

    //                   ],
    //                 )
    //               ],
    //             ),
    //           )
    //           :
    //           Center(
    //             child: CircularProgressIndicator(),
    //           );
    //         },
    //       ),
    //       Container(
    //         width: _size.width,
    //         padding: EdgeInsets.symmetric(horizontal: 10),
    //         child: Text(
    //           "Biography",
    //           style: TextStyle(
    //             color: Colors.grey,
    //             fontSize: 14.0,
    //           ),
    //           textAlign: TextAlign.start,
    //         ),
    //       ),
    //       Observer(
    //         name: 'personBiography',
    //         builder: (_) {
    //           return widget.id != null ?
    //             Padding(
    //               padding: const EdgeInsets.all(10.0),
    //               child: widget.id != null ?
    //                 Text("")
    //                 : ExpandableTextWidget(
    //                   text: Text(""),
    //                   style: TextStyle(
    //                     color: Colors.white, fontSize: 14
    //                   ),
    //                   defaultLines: 8,
    //                 ),
    //             )
    //             : Center();
    //         },
    //       ),
    //       SizedBox(height: 15.0,),
    //       Container(
    //         width: _size.width,
    //         padding: EdgeInsets.symmetric(horizontal: 10.0),
    //         child: Text(
    //           "Movies",
    //           style: TextStyle(
    //             color: Colors.grey,
    //           ),
    //           textAlign: TextAlign.start,
    //         ),
    //       ),
    //       SizedBox(height: 10.0),
    //       Observer(
    //         name: 'personMovies',
    //         builder: (_) {
    //           return widget.id != null ?
    //             ProductionListWidget(productions: controller.credits.cast)
    //           : Center();
    //         }
    //       )
    //     ],
    //   ),
    // );
  }
  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [],
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

  Widget _buildPersonDetailWidget(PersonResponse data) {
    Person person = data.person;
    Size _size = MediaQuery.of(context).size;
    return ListView(
      children: <Widget>[
        Container(
          height: 180,
          width: _size.width,
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage("https://image.tmdb.org/t/p/w300/"+person.profileImg),
                  ),
                ),
              ),
            ]
          )
        ),
        Column(
          children: [
            Text(
              "Born: ",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            Text(
              "From: ",
              style: TextStyle(
                color: Colors.grey,
              ),
            )

          ],
        )
      ],
    );
  }
}