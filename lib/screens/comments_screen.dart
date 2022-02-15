import 'package:flutter/material.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/widgets/comment_card.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({Key? key}) : super(key: key);

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: const Text('Comments'),
          centerTitle: false,
        ),
        body: CommentCard(),
        bottomNavigationBar: SafeArea(
          child: Container(
            height: kToolbarHeight,
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            padding: const EdgeInsets.only(left: 16, right: 8),
            child: Row(
              children: [
                // Profile picture
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://lh3.googleusercontent.com/i7wCRizbg5RZP6B-uPltQEZiwwg7SQbzkXpqJEIQW4MEeV1cmKjwSPb-rj4cZWASl3CdPK5fNWVeAP0dRbX6jTVtWfuzj5083BCisAc'),
                  radius: 18,
                ),

                // Text field
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 8),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Comment as username',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),

                // Post button
                InkWell(
                  onTap: () {},
                  child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text('Post',
                          style: TextStyle(
                            color: blueColor,
                          ))),
                ),
              ],
            ),
          ),
        ));
  }
}
