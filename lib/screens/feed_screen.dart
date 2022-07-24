import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';
import 'package:instagram_clone_flutter/utils/global_variable.dart';
import 'package:instagram_clone_flutter/widgets/post_card.dart';
import 'package:stories_for_flutter/stories_for_flutter.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor:
          width > webScreenSize ? webBackgroundColor : mobileBackgroundColor,
      appBar: width > webScreenSize
          ? null
          : AppBar(
              backgroundColor: mobileBackgroundColor,
              centerTitle: false,
              // title: Image(
              //   image: AssetImage('assets/ic_slapface.png'),
              //   fit: BoxFit.cover,
              //   height: 32,
              // ),
              // SvgPicture.asset(
              //   'assets/ic_slapface.png',
              //   color: primaryColor,
              //   height: 32,
              // ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.video_library_rounded),
                  onPressed: () {},
                ),
              ],
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
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => Container(
              margin: EdgeInsets.symmetric(
                horizontal: width > webScreenSize ? width * 0.3 : 0,
                vertical: width > webScreenSize ? 15 : 0,
              ),
              child:
                  // ListView(children: [
                  PostCard(
                snap: snapshot.data!.docs[index].data(),
              ),
              // Stories(
              //   displayProgress: true,
              //   storyItemList: [
              //     // First group of stories
              //     StoryItem(
              //         name: "First Story",
              //         thumbnail: NetworkImage(
              //           "https://assets.materialup.com/uploads/82eae29e-33b7-4ff7-be10-df432402b2b6/preview",
              //         ),
              //         stories: [
              //           // First story
              //           Scaffold(
              //             body: Container(
              //               decoration: BoxDecoration(
              //                 image: DecorationImage(
              //                   fit: BoxFit.cover,
              //                   image: NetworkImage(
              //                     "https://wallpaperaccess.com/full/16568.png",
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ),
              //           // Second story in first group
              //           Scaffold(
              //             body: Center(
              //               child: Text(
              //                 "Second story in first group !",
              //                 style: TextStyle(
              //                   color: Color(0xff777777),
              //                   fontSize: 25,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ]),
              //     // Second story group
              //     StoryItem(
              //       name: "2nd",
              //       thumbnail: NetworkImage(
              //         "https://www.shareicon.net/data/512x512/2017/03/29/881758_cup_512x512.png",
              //       ),
              //       stories: [
              //         Scaffold(
              //           body: Center(
              //             child: Text(
              //               "That's it, Folks !",
              //               style: TextStyle(
              //                 color: Color(0xff777777),
              //                 fontSize: 25,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // )
              // ]),
            ),
          );
        },
      ),
    );
  }
}
