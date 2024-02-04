import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/colors.dart';
import '../widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: mobileBackgroundColor,
        title: SvgPicture.asset(
          'assets/Socialmedialogo.svg',
          color: Colors.white,
          height: 32,
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var data = snapshot.data!.docs.length;
          return ListView.builder(
            itemCount: data,
            itemBuilder: (context, index) {
              if (snapshot.data?.docs.length != null) {
               return PostCard(
                  snap: snapshot.data?.docs[index].data(),
                );
              }
            },
          );
        },
      ),
    );
  }
}
