import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart';
import 'package:flutter/material.dart';
import 'package:tafaling/core/utils/app_context.dart';
import 'package:tafaling/features/post/data/data_sources/temp_posts_data.dart';
import 'package:tafaling/features/post/data/models/post_model.dart';
import 'package:tafaling/features/user/data/data_sources/follower_data.dart';
import 'package:tafaling/features/user/data/data_sources/following_data.dart';
import 'package:tafaling/features/user/presentation/widgets/following_users.dart';
import 'package:tafaling/features/post/presentation/widgets/profile_video_grid.dart';
import 'package:tafaling/features/user/presentation/widgets/sliver_app_bar_delegate.dart';
import 'package:tafaling/features/user/presentation/widgets/follow_status.dart';
import 'package:tafaling/features/user/presentation/widgets/users_followers.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildProfilePage(context, posts);
  }

  Widget _buildProfilePage(BuildContext context, List<PostModel> posts) {
    final String profilePic = posts[0].creator.profilePicture ?? '';
    final String userName = posts[0].creator.name;
    final int followers = posts[0].creator.followers;
    final int following = posts[0].creator.following;
    List<PostModel> myPosts = posts.isNotEmpty && posts[0].id != 0 ? posts : [];

    return PopScope(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              'My Profile',
            ),
          ),
          body: SafeArea(
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    toolbarHeight: 0,
                    pinned: true,
                    floating: true,
                    snap: true,
                    expandedHeight: MediaQuery.of(context).size.height / 2.5,
                    flexibleSpace: FlexibleSpaceBar(
                      background: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 10),
                            SizedBox(
                              width: 100,
                              child: Container(
                                width: 100,
                                height: 100,
                                padding: const EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: CacheNetworkImagePlus(
                                    imageUrl: profilePic,
                                    errorWidget: Image.asset(
                                        'assets/images/misc/avatar.png'),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              userName,
                              style: context.theme.textTheme.labelLarge,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FollowStatus(
                                  label: "Following",
                                  value: following.toString(),
                                  onPressed: () {},
                                ),
                                const VerticalDivider(),
                                FollowStatus(
                                  label: "Followers",
                                  value: followers.toString(),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FilledButton(
                                  child: Text(
                                    "Edit Profile",
                                    style: context.theme.textTheme.labelMedium,
                                  ),
                                  onPressed: () {
                                    // Edit Profile Action
                                  },
                                ),
                                const SizedBox(width: 10),
                                FilledButton(
                                  child: Text(
                                    "Share Profile",
                                    style: context.theme.textTheme.labelMedium,
                                  ),
                                  onPressed: () {
                                    // Share Profile Action
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'This is a short bio about the user. It can include interests, hobbies, or anything the user wants to share.',
                                    style: context.theme.textTheme.labelMedium,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverPersistentHeader(
                    delegate: SliverAppBarDelegate(
                      TabBar(
                        tabs: [
                          Tab(text: 'Posts'),
                          Tab(text: 'Private'),
                          Tab(text: 'Following'),
                          Tab(text: 'followers'),
                        ],
                      ),
                    ),
                    pinned: true,
                  ),
                ];
              },
              body: TabBarView(
                children: [
                  ProfileVideoGrid(
                    itemCount: myPosts.length,
                    myPosts: myPosts,
                  ),
                  const ProfileVideoGrid(
                    itemCount: 0,
                    myPosts: [],
                  ),
                  FollowingUsers(
                    itemCount: followingUsers.length,
                    users: followingUsers,
                  ),
                  UsersFollowers(
                    itemCount: myFollowers.length,
                    users: myFollowers,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
