import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart';
import 'package:flutter/material.dart';
import 'package:tafaling/core/utils/app_context.dart';
import 'package:tafaling/features/post/data/data_sources/temp_posts_data.dart';
import 'package:tafaling/features/post/data/models/post_model.dart';
import 'package:tafaling/features/user/data/data_sources/follower_data.dart';
import 'package:tafaling/features/user/data/data_sources/following_data.dart';
import 'package:tafaling/features/user/presentation/widgets/following_users_widget.dart';
import 'package:tafaling/features/user/presentation/widgets/my_video_grid_widget.dart';
import 'package:tafaling/features/user/presentation/widgets/stat_column_widget.dart';
import 'package:tafaling/features/user/presentation/widgets/users_followers_widget.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildProfilePage(context, postModels);
  }

  Widget _buildProfilePage(BuildContext context, List<PostModel> posts) {
    var profilePic = posts[0].creator.profilePicture ?? '';
    var userName = posts[0].creator.name;
    var followers = posts[0].creator.followers;
    var following = posts[0].creator.following;
    var myPosts = posts.isNotEmpty && posts[0].id != 0 ? posts : [];

    return PopScope(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              'Profile',
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.search,
                ),
                onPressed: () {
                  // Search action
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.more_vert,
                ),
                onPressed: () {
                  // More options
                },
              ),
            ],
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
                    expandedHeight: MediaQuery.of(context).size.height / 3,
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
                                      imageUrl: profilePic),
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
                                StatColumn(
                                  label: "Following",
                                  value: following.toString(),
                                  onPressed: () {},
                                ),
                                const VerticalDivider(),
                                StatColumn(
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
                    delegate: _SliverAppBarDelegate(
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
                  MyVideoGrid(
                    itemCount: myPosts.length,
                    myPosts: myPosts,
                  ),
                  const MyVideoGrid(
                    itemCount: 0,
                    myPosts: [],
                  ),
                  FollowingUsersWidget(
                    itemCount: followingUsers.length,
                    users: followingUsers,
                  ),
                  UsersFollowersWidget(
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

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(TabBar tabBar) : _tabBar = tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      color: context.theme.colorScheme.secondary,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
