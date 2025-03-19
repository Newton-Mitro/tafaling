import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/configs/routes/route_name.dart';
import 'package:tafaling/core/utils/app_context.dart';
import 'package:tafaling/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:tafaling/features/home/presentation/notifier/notifiers.dart';
import 'package:tafaling/features/post/domain/entities/post_entity.dart';
import 'package:tafaling/features/user/presentation/following_users_screen/bloc/following_users_bloc.dart';
import 'package:tafaling/features/user/presentation/users_followers_screen/bloc/users_followers_bloc.dart';
import 'package:tafaling/features/user/presentation/users_followers_screen/view/users_followers_screen.dart';
import 'package:tafaling/features/user/presentation/widgets/profile_posts_grid.dart';
import 'package:tafaling/features/user/presentation/user_profile_screen/bloc/profile_bloc.dart';
import 'package:tafaling/features/user/presentation/widgets/follow_status.dart';
import 'package:tafaling/features/user/presentation/following_users_screen/view/following_users_screen.dart';
import 'package:tafaling/injection_container.dart';

final profileTabs = [
  Tab(text: 'Posts'),
  Tab(text: 'Following'),
  Tab(text: 'Followers'),
];

class UserProfileScreen extends StatelessWidget {
  final Object? userId;

  const UserProfileScreen({super.key, this.userId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  sl<ProfileBloc>()..add(
                    FetchProfileEvent(
                      userId: (userId ?? 0) as int,
                      fetchPage: 1,
                    ),
                  ),
        ),
        BlocProvider(create: (context) => sl<AuthBloc>()),
        BlocProvider(create: (context) => sl<UserFollowersBloc>()),
        BlocProvider(create: (context) => sl<FollowingUsersBloc>()),
      ],
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          // if (state.loading) {
          //   return Center(child: CircularProgressIndicator());
          // }

          if (state.error.isNotEmpty) {
            return Center(child: Text('Error: ${state.error}'));
          }

          if (state.posts.isNotEmpty) {
            return _buildProfilePage(context, state.posts, state);
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildProfilePage(
    BuildContext context,
    List<PostEntity> posts,
    ProfileState state,
  ) {
    var profilePic = posts[0].creator.profilePicture ?? '';
    var userId = posts[0].creator.id;
    var userName = posts[0].creator.name;
    var followers = posts[0].creator.followers;
    var following = posts[0].creator.following;
    var isFollowing = posts[0].creator.isFollowing;
    List<PostEntity> myPosts =
        posts.isNotEmpty && posts[0].id != 0 ? posts : [];

    return PopScope(
      child: DefaultTabController(
        length: profileTabs.length, // Two tabs: Public and Private
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, authState) {
            if (authState is Unauthenticated) {
              Navigator.pushReplacementNamed(context, RoutesName.homePage);
              selectedPageNotifier.value = 0;
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState) {
              return Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading:
                      userId == authUserNotifier.value?.id ? false : true,
                  title: const Text('Profile'),
                  actions: [
                    if (authUserNotifier.value?.id == userId)
                      authState is AuthLoading
                          ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(),
                          )
                          : IconButton(
                            icon: const Icon(Icons.logout),
                            onPressed: () {
                              context.read<AuthBloc>().add(LogoutEvent());
                            },
                          ),
                  ],
                ),
                body: SafeArea(
                  child: NestedScrollView(
                    headerSliverBuilder: (
                      BuildContext context,
                      bool innerBoxIsScrolled,
                    ) {
                      return <Widget>[
                        SliverAppBar(
                          toolbarHeight: 0,
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
                                  CachedNetworkImage(
                                    imageUrl: profilePic,
                                    imageBuilder:
                                        (context, imageProvider) => ClipOval(
                                          child: Image(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                            width: 100, // Set width
                                            height: 100, // Set height
                                          ),
                                        ),
                                    placeholder:
                                        (context, url) => SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: CircularProgressIndicator(),
                                        ),
                                    errorWidget:
                                        (context, url, error) => ClipOval(
                                          child: Image.asset(
                                            'assets/images/misc/avatar.png',
                                            fit: BoxFit.cover,
                                            width: 100, // Ensure same size
                                            height: 100, // Ensure same size
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                      if (userId ==
                                          authUserNotifier.value?.id) ...[
                                        FilledButton(
                                          child: Text(
                                            "Edit Profile",
                                            style:
                                                context
                                                    .theme
                                                    .textTheme
                                                    .labelMedium,
                                          ),
                                          onPressed: () {
                                            // Edit Profile Action
                                          },
                                        ),
                                        const SizedBox(width: 10),
                                        FilledButton(
                                          child: Text(
                                            "Share Profile",
                                            style:
                                                context
                                                    .theme
                                                    .textTheme
                                                    .labelMedium,
                                          ),
                                          onPressed: () {
                                            // Share Profile Action
                                          },
                                        ),
                                      ]
                                      // If it's not the authenticated user's profile, show "Follow/Unfollow" buttons
                                      else ...[
                                        isFollowing
                                            ? state.loading
                                                ? CircularProgressIndicator(
                                                  color: Colors.red,
                                                )
                                                : FilledButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            Color.fromARGB(
                                                              255,
                                                              13,
                                                              82,
                                                              14,
                                                            ),
                                                      ),
                                                  child: Text(
                                                    "Unfollow",
                                                    style:
                                                        context
                                                            .theme
                                                            .textTheme
                                                            .labelMedium,
                                                  ),
                                                  onPressed: () {
                                                    context
                                                        .read<ProfileBloc>()
                                                        .add(
                                                          UnFollowUserEvent(
                                                            userId,
                                                          ),
                                                        );
                                                  },
                                                )
                                            : state.loading
                                            ? CircularProgressIndicator(
                                              color: Colors.red,
                                            )
                                            : FilledButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color.fromARGB(
                                                  255,
                                                  6,
                                                  47,
                                                  82,
                                                ),
                                              ),
                                              child: Text(
                                                "Follow",
                                                style:
                                                    context
                                                        .theme
                                                        .textTheme
                                                        .labelMedium,
                                              ),
                                              onPressed: () {
                                                context.read<ProfileBloc>().add(
                                                  FollowUserEvent(userId),
                                                );
                                              },
                                            ),
                                        const SizedBox(width: 10),
                                        FilledButton(
                                          child: Text(
                                            "Message",
                                            style:
                                                context
                                                    .theme
                                                    .textTheme
                                                    .labelMedium,
                                          ),
                                          onPressed: () {
                                            // Share Profile Action
                                          },
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
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                            TabBar(
                              indicatorColor: Colors.white,
                              labelColor: Colors.white, // Active tab color
                              unselectedLabelColor:
                                  Colors.grey, // Inactive tab col
                              tabs: profileTabs,
                            ),
                          ),
                          pinned: true,
                        ),
                      ];
                    },
                    body: TabBarView(
                      children: [
                        ProfilePostsGrid(
                          itemCount: myPosts.length,
                          myPosts: myPosts,
                        ),
                        FollowingUsersScreen(userId: userId),
                        UsersFollowersScreen(userId: userId),
                      ],
                    ),
                  ),
                ),
              );
            },
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
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Material(
      color: const Color.fromARGB(255, 2, 31, 32),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
