import 'package:flutter/material.dart';
import 'package:instagram_flutter/utils/colors.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  @override
  Widget build(BuildContext context) {
    // return Center(
    //     child: IconButton(
    //   onPressed: () {},
    //   icon: const Icon(Icons.upload),
    // ));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Post to'),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Post',
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://lh3.googleusercontent.com/1wTnxFx6paNeV1lv_ht10OFpDucUhg-fL6IZbPrai3Jf_3pHS5dSazhpU_UBn2BVQBUEffYAeoo2iVbCu9LPeUDhmwZwt_7J4xpdrQ',
                ),
              ),
              const Flexible(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Write a caption...',
                      border: InputBorder.none,
                    ),
                    maxLines: 8,
                  ),
                ),
              ),
              SizedBox(
                height: 45,
                width: 45,
                child: AspectRatio(
                    aspectRatio: 487 / 451,
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://lh3.googleusercontent.com/xnaYe8zWGjOG4KNsOsqrCrrysnn8SwZHNH6JdVd0p75Xge88p-edDWs4W6YfrJK4IcO_WAx4p686YiDVwNlGtnzWt9yJxp798gRautI',
                          ),
                          fit: BoxFit.fill,
                          alignment: FractionalOffset.topCenter,
                        ),
                      ),
                    )),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
