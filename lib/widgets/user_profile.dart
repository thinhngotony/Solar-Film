import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trailerfilm_app/widgets/card_item.dart';
import 'package:trailerfilm_app/widgets/stack_container.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfile createState() => _UserProfile();
}

class _UserProfile extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          StackContainer(),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => CardItem(),
            shrinkWrap: true,
            itemCount: 1,
          ),
        ],
      ),
    );
  }
}