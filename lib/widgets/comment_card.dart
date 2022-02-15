import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/comment.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatefulWidget {
  final Comment comment;
  const CommentCard({Key? key, required this.comment}) : super(key: key);

  @override
  CommentCardState createState() => CommentCardState();
}

class CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      child: Row(
        children: [
          // Profile picture
          CircleAvatar(
            backgroundImage: NetworkImage(widget.comment.profilePic),
            radius: 18,
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${widget.comment.username}  ',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: widget.comment.text,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      widget.comment.datePublished == null
                          ? ''
                          : DateFormat.yMd()
                              .format(widget.comment.datePublished!),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.favorite,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}
