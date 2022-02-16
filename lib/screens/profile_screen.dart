import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/post.dart';
import 'package:instagram_flutter/models/user.dart';
import 'package:instagram_flutter/resources/auth_methods.dart';
import 'package:instagram_flutter/resources/firestore_methods.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/utils.dart';
import 'package:instagram_flutter/widgets/follow_button.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? _user;
  List<Post>? _posts;
  bool _isFollowing = false;

  void _getUser() async {
    final u = await FirestoreMethods.getUser(widget.uid);
    setState(() {
      _user = u;
      _isFollowing = u.followers.contains(AuthMethods.uid);
    });
  }

  void _getData() async {
    try {
      final res = await Future.wait([
        FirestoreMethods.getUser(widget.uid),
        FirestoreMethods.getUserPosts(widget.uid),
      ]);
      setState(() {
        _user = res[0] as User;
        _posts = res[1] as List<Post>;
        _isFollowing = _user!.followers.contains(AuthMethods.uid);
      });
    } catch (error) {
      showSnackBar(error.toString(), context);
    }
  }

  @override
  initState() {
    super.initState();
    _getData();
  }

  Column _buildStateColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _user == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              title: Text(_user!.username),
              centerTitle: false,
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(_user!.photoUrl),
                            radius: 40,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildStateColumn(_posts!.length, 'Posts'),
                                    _buildStateColumn(
                                        _user!.followers.length, 'Followers'),
                                    _buildStateColumn(
                                        _user!.following.length, 'Following'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    AuthMethods.uid == widget.uid
                                        ?
                                        // viewing my profile
                                        FollowButton(
                                            text: 'Edit profile',
                                            backgroundColor:
                                                mobileBackgroundColor,
                                            textColor: primaryColor,
                                            borderColor: Colors.grey,
                                            onPressed: () {},
                                          )
                                        : _isFollowing
                                            ? FollowButton(
                                                text: 'Unfollow',
                                                backgroundColor: Colors.white,
                                                textColor: Colors.black,
                                                borderColor: Colors.grey,
                                                onPressed: () async {
                                                  await FirestoreMethods
                                                      .unfollowUser(
                                                          AuthMethods.uid,
                                                          _user!.uid);
                                                  _getUser();
                                                },
                                              )
                                            : FollowButton(
                                                text: 'Follow',
                                                backgroundColor: Colors.blue,
                                                textColor: Colors.white,
                                                borderColor: Colors.blue,
                                                onPressed: () async {
                                                  await FirestoreMethods
                                                      .followUser(
                                                          AuthMethods.uid,
                                                          _user!.uid);
                                                  _getUser();
                                                },
                                              ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // username
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          _user!.username,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),

                      // bio
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(_user!.bio),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                _posts == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        itemCount: _posts!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) => Image.network(
                          _posts![index].postUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
              ],
            ),
          );
  }
}
