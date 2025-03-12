import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/core/utils/app_context.dart';
import 'package:tafaling/features/post/data/data_sources/temp_posts_data.dart';
import 'package:tafaling/features/post/data/models/post_model.dart';
import 'package:tafaling/features/post/presentation/widgets/profile_video_grid.dart';
import 'package:tafaling/features/user/data/data_sources/follower_data.dart';
import 'package:tafaling/features/user/data/data_sources/following_data.dart';
import 'package:tafaling/features/user/domain/usecases/fetch_profile_usecase.dart';
import 'package:tafaling/features/user/presentation/states/profile_bloc/profile_bloc.dart';
import 'package:tafaling/features/user/presentation/widgets/follow_status.dart';
import 'package:tafaling/features/user/presentation/widgets/following_users.dart';
import 'package:tafaling/features/user/presentation/widgets/users_followers.dart';
import 'package:tafaling/injection_container.dart';

class UserProfileScreen extends StatelessWidget {
  final Object? userId;

  const UserProfileScreen({super.key, this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final profileBloc = ProfileBloc(servLoc<FetchProfileUseCase>());
        profileBloc.add(FetchProfileEvent(userId: userId as int, fetchPage: 1));
        return profileBloc;
      },
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.error.isNotEmpty) {
            return Center(child: Text('Error: ${state.error}'));
          }

          if (state.posts.isNotEmpty) {
            return _buildProfilePage(context, posts, state);
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildProfilePage(
      BuildContext context, List<PostModel> posts, ProfileState state) {
    final String profilePic = posts[0].creator.profilePicture ?? '';
    final String userName = posts[0].creator.name;
    final int followers = posts[0].creator.followers;
    final int following = posts[0].creator.following;
    final bool isFollowing = posts[0].creator.isFollowing;
    List<PostModel> myPosts = posts.isNotEmpty && posts[0].id != 0 ? posts : [];

    return PopScope(
      child: DefaultTabController(
        length: 3, // Two tabs: Public and Private
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 2, 37, 39),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color.fromARGB(255, 2, 31, 32),
            title: const Text(
              'Profile',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () {
                  // Search action
                },
              ),
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.white),
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
                    backgroundColor: const Color.fromARGB(255, 2, 37, 39),
                    pinned: true,
                    floating: true,
                    snap: true,
                    expandedHeight: 350.0,
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
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: profilePic.isNotEmpty
                                      ? Image.network(
                                          profilePic,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              'assets/images/avatar.png',
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        )
                                      : Image.asset(
                                          'assets/images/avatar.png',
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              userName,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FollowStatus(
                                  label: "Following",
                                  value: following.toString(),
                                  onPressed: () {},
                                ),
                                FollowStatus(
                                  label: "Followers",
                                  value: followers.toString(),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Show "Edit Profile" and "Share Profile" if it's the authenticated user's profile
                                if (1 == 2) ...[
                                  FilledButton(
                                    child: Text(
                                      "Edit Profile",
                                      style:
                                          context.theme.textTheme.labelMedium,
                                    ),
                                    onPressed: () {
                                      // Share Profile Action
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  FilledButton(
                                    child: Text(
                                      "Share Profile",
                                      style:
                                          context.theme.textTheme.labelMedium,
                                    ),
                                    onPressed: () {
                                      // Share Profile Action
                                    },
                                  ),
                                ]
                                // If it's not the authenticated user's profile, show "Follow/Unfollow" buttons
                                else ...[
                                  isFollowing
                                      ? FilledButton(
                                          child: Text(
                                            "Unfollow",
                                            style: context
                                                .theme.textTheme.labelMedium,
                                          ),
                                          onPressed: () {
                                            // Share Profile Action
                                          },
                                        )
                                      : FilledButton(
                                          child: Text(
                                            "Follow",
                                            style: context
                                                .theme.textTheme.labelMedium,
                                          ),
                                          onPressed: () {
                                            // Share Profile Action
                                          },
                                        ),
                                  const SizedBox(width: 10),
                                  FilledButton(
                                    child: Text(
                                      "Message",
                                      style:
                                          context.theme.textTheme.labelMedium,
                                    ),
                                    onPressed: () {
                                      // Share Profile Action
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.person_add),
                                  ),
                                ],
                                // Always show "Message" and "My Icon Button"
                              ],
                            ),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF0B4B4A),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'This is a short bio about the user. It can include interests, hobbies, or anything the user wants to share.',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverPersistentHeader(
                    delegate: _SliverAppBarDelegate(
                      const TabBar(
                        indicatorColor: Colors.white,
                        tabs: [
                          Tab(text: 'Posts'),
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

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverAppBarDelegate(TabBar tabBar)
      : tabBar = const TabBar(
          indicatorColor: Colors.white,
          labelColor: Colors.white, // Active tab color
          unselectedLabelColor: Colors.grey, // Inactive tab color
          tabs: [
            Tab(text: 'Posts'),
            Tab(text: 'Following'),
            Tab(text: 'followers'),
          ],
        );

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      color: const Color.fromARGB(255, 2, 31, 32),
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
