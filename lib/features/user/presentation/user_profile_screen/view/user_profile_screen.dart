import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/core/extensions/app_context.dart';
import 'package:tafaling/features/auth/presentation/views/bloc/auth_bloc/auth_bloc.dart';
import 'package:tafaling/features/post/domain/entities/post_entity.dart';
import 'package:tafaling/features/user/domain/entities/user_entity.dart';
import 'package:tafaling/features/user/presentation/following_users_screen/view/following_users_screen.dart';
import 'package:tafaling/features/user/presentation/user_profile_screen/bloc/profile_bloc.dart';
import 'package:tafaling/features/user/presentation/users_followers_screen/view/users_followers_screen.dart';
import 'package:tafaling/features/user/presentation/widgets/follow_status.dart';
import 'package:tafaling/features/user/presentation/widgets/profile_posts_grid.dart';
import 'package:tafaling/routes/app_route_name.dart';
import 'package:tafaling/shared/widgets/language_switch/language_switch.dart';
import 'package:tafaling/shared/widgets/theme_selector/theme_selector.dart';

final profileTabs = [
  Tab(text: 'Posts'),
  Tab(text: 'Following'),
  Tab(text: 'Followers'),
];

class UserProfileScreen extends StatefulWidget {
  final UserEntity? user;

  const UserProfileScreen({super.key, required this.user});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  void initState() {
    context.read<ProfileBloc>().add(LoadUserProfileEvent(widget.user!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildProfilePage(context);
  }

  Widget _buildProfilePage(BuildContext context) {
    List<PostEntity> myPosts = []; // TODO: need implementation

    return PopScope(
      child: DefaultTabController(
        length: profileTabs.length,
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, authState) {
            if (authState is UnAuthenticated) {
              Navigator.pushReplacementNamed(context, AppRouteName.root);
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Profile'),
                  elevation: 5,
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        Navigator.pushNamed(context, AppRouteName.searchUser);
                      },
                    ),
                    ThemeSelector(),
                    LanguageSwitch(),
                    SizedBox(width: 10),
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
                              child: BlocBuilder<ProfileBloc, ProfileState>(
                                builder: (context, prifileState) {
                                  if (prifileState is ProfileLoaded) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(height: 10),
                                        CachedNetworkImage(
                                          imageUrl:
                                              prifileState
                                                  .user
                                                  .profilePicture ??
                                              '',
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  ClipOval(
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
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                          errorWidget:
                                              (context, url, error) => ClipOval(
                                                child: Image.asset(
                                                  'assets/images/misc/avatar.png',
                                                  fit: BoxFit.cover,
                                                  width:
                                                      100, // Ensure same size
                                                  height:
                                                      100, // Ensure same size
                                                ),
                                              ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          prifileState.user.name,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                context
                                                    .theme
                                                    .colorScheme
                                                    .onPrimary,
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
                                              value:
                                                  prifileState.user.following
                                                      .toString(),
                                              onPressed: () {},
                                            ),
                                            FollowStatus(
                                              label: "Followers",
                                              value:
                                                  prifileState.user.followers
                                                      .toString(),
                                              onPressed: () {},
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            prifileState.user.isFollowing
                                                ? prifileState is ProfileLoading
                                                    ? CircularProgressIndicator(
                                                      color: Colors.red,
                                                    )
                                                    : FilledButton(
                                                      style:
                                                          ElevatedButton.styleFrom(
                                                            backgroundColor:
                                                                context
                                                                    .theme
                                                                    .colorScheme
                                                                    .secondary,
                                                          ),
                                                      child: Text(
                                                        "Unfollow",
                                                        style: TextStyle(
                                                          color:
                                                              context
                                                                  .theme
                                                                  .colorScheme
                                                                  .onSecondary,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        context
                                                            .read<ProfileBloc>()
                                                            .add(
                                                              UnfollowUserEvent(
                                                                prifileState
                                                                    .user
                                                                    .id,
                                                              ),
                                                            );
                                                      },
                                                    )
                                                : prifileState is ProfileLoading
                                                ? CircularProgressIndicator(
                                                  color: Colors.red,
                                                )
                                                : FilledButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            context
                                                                .theme
                                                                .colorScheme
                                                                .tertiary,
                                                      ),
                                                  child: Text(
                                                    "Follow",
                                                    style: TextStyle(
                                                      color:
                                                          context
                                                              .theme
                                                              .colorScheme
                                                              .onSecondary,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    context
                                                        .read<ProfileBloc>()
                                                        .add(
                                                          FollowUserEvent(
                                                            prifileState
                                                                .user
                                                                .id,
                                                          ),
                                                        );
                                                  },
                                                ),
                                            const SizedBox(width: 10),
                                            FilledButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    context
                                                        .theme
                                                        .colorScheme
                                                        .primaryContainer,
                                              ),
                                              child: Text(
                                                "Message",
                                                style: TextStyle(
                                                  color:
                                                      context
                                                          .theme
                                                          .colorScheme
                                                          .onSecondary,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              onPressed: () {
                                                // Share Profile Action
                                              },
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF0B4B4A),
                                            borderRadius: BorderRadius.circular(
                                              5.0,
                                            ),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 5,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Padding(
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
                                                  color:
                                                      context
                                                          .theme
                                                          .colorScheme
                                                          .onPrimary,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  return Container(
                                    height: 300,
                                    alignment: Alignment.center,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.amber,
                                      ),
                                    ),
                                  );
                                },
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
                        FollowingUsersScreen(
                          userId:
                              authState is Authenticated
                                  ? authState.authUser.user.id
                                  : 0,
                        ),
                        UsersFollowersScreen(
                          userId:
                              authState is Authenticated
                                  ? authState.authUser.user.id
                                  : 0,
                        ),
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
