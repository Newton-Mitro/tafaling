import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/routes/route_name.dart';
import 'package:tafaling/core/injection.dart';
import 'package:tafaling/core/extensions/app_context.dart';
import 'package:tafaling/features/post/domain/entities/post_entity.dart';
import 'package:tafaling/features/user/domain/entities/user_entity.dart';
import 'package:tafaling/features/user/presentation/following_users_screen/bloc/following_users_bloc.dart';
import 'package:tafaling/features/user/presentation/users_followers_screen/bloc/users_followers_bloc.dart';
import 'package:tafaling/features/user/presentation/users_followers_screen/view/users_followers_screen.dart';
import 'package:tafaling/features/user/presentation/widgets/profile_posts_grid.dart';
import 'package:tafaling/features/user/presentation/user_profile_screen/bloc/profile_bloc.dart';
import 'package:tafaling/features/user/presentation/widgets/follow_status.dart';
import 'package:tafaling/features/user/presentation/following_users_screen/view/following_users_screen.dart';

final profileTabs = [
  Tab(text: 'Posts'),
  Tab(text: 'Following'),
  Tab(text: 'Followers'),
];

class UserProfileScreen extends StatelessWidget {
  final UserEntity user;

  const UserProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => sl<ProfileBloc>()..add(LoadUserProfileEvent(user)),
        ),
        BlocProvider(create: (context) => sl<UserFollowersBloc>()),
        BlocProvider(create: (context) => sl<FollowingUsersBloc>()),
      ],
      child: _buildProfilePage(context),
    );
  }

  Widget _buildProfilePage(BuildContext context) {
    List<PostEntity> myPosts = []; // TODO: need implementation

    return PopScope(
      child: DefaultTabController(
        length: profileTabs.length, // Two tabs: Public and Private
        child: Container(),
        // child: BlocListener<AuthBloc, AuthState>(
        //   listener: (context, authState) {
        //     if (authState is Unauthenticated) {
        //       Navigator.pushReplacementNamed(context, RoutesName.root);
        //     }
        //   },
        //   child: BlocBuilder<AuthBloc, AuthState>(
        //     builder: (context, authState) {
        //       return Scaffold(
        //         appBar: AppBar(
        //           title: const Text('Profile'),
        //           automaticallyImplyLeading: false,
        //           actions: [
        //             IconButton(
        //               icon: const Icon(Icons.logout),
        //               onPressed: () {
        //                 // context.read<AuthBloc>().add(LogoutEvent());
        //               },
        //             ),
        //           ],
        //         ),
        //         body: SafeArea(
        //           child: NestedScrollView(
        //             headerSliverBuilder: (
        //               BuildContext context,
        //               bool innerBoxIsScrolled,
        //             ) {
        //               return <Widget>[
        //                 SliverAppBar(
        //                   toolbarHeight: 0,
        //                   pinned: true,
        //                   floating: true,
        //                   snap: true,
        //                   expandedHeight: 350.0,
        //                   flexibleSpace: FlexibleSpaceBar(
        //                     background: SingleChildScrollView(
        //                       child: BlocBuilder<ProfileBloc, ProfileState>(
        //                         builder: (context, state) {
        //                           if (state is ProfileLoaded) {
        //                             return Column(
        //                               mainAxisSize: MainAxisSize.min,
        //                               children: [
        //                                 const SizedBox(height: 10),
        //                                 CachedNetworkImage(
        //                                   imageUrl:
        //                                       state.user.profilePicture ?? '',
        //                                   imageBuilder:
        //                                       (context, imageProvider) =>
        //                                           ClipOval(
        //                                             child: Image(
        //                                               image: imageProvider,
        //                                               fit: BoxFit.cover,
        //                                               width: 100, // Set width
        //                                               height: 100, // Set height
        //                                             ),
        //                                           ),
        //                                   placeholder:
        //                                       (context, url) => SizedBox(
        //                                         width: 100,
        //                                         height: 100,
        //                                         child:
        //                                             CircularProgressIndicator(),
        //                                       ),
        //                                   errorWidget:
        //                                       (context, url, error) => ClipOval(
        //                                         child: Image.asset(
        //                                           'assets/images/misc/avatar.png',
        //                                           fit: BoxFit.cover,
        //                                           width:
        //                                               100, // Ensure same size
        //                                           height:
        //                                               100, // Ensure same size
        //                                         ),
        //                                       ),
        //                                 ),
        //                                 const SizedBox(height: 10),
        //                                 Text(
        //                                   state.user.name,
        //                                   style: const TextStyle(
        //                                     fontSize: 20,
        //                                     fontWeight: FontWeight.bold,
        //                                     color: Colors.white,
        //                                   ),
        //                                 ),
        //                                 const SizedBox(height: 10),
        //                                 Row(
        //                                   mainAxisSize: MainAxisSize.min,
        //                                   crossAxisAlignment:
        //                                       CrossAxisAlignment.center,
        //                                   children: [
        //                                     FollowStatus(
        //                                       label: "Following",
        //                                       value:
        //                                           state.user.following
        //                                               .toString(),
        //                                       onPressed: () {},
        //                                     ),
        //                                     FollowStatus(
        //                                       label: "Followers",
        //                                       value:
        //                                           state.user.followers
        //                                               .toString(),
        //                                       onPressed: () {},
        //                                     ),
        //                                   ],
        //                                 ),
        //                                 const SizedBox(height: 20),
        //                                 Row(
        //                                   mainAxisSize: MainAxisSize.min,
        //                                   children: [
        //                                     // Show "Edit Profile" and "Share Profile" if it's the authenticated user's profile
        //                                     if (true) ...[
        //                                       FilledButton(
        //                                         child: Text(
        //                                           "Edit Profile",
        //                                           style:
        //                                               context
        //                                                   .theme
        //                                                   .textTheme
        //                                                   .labelMedium,
        //                                         ),
        //                                         onPressed: () {
        //                                           // Edit Profile Action
        //                                         },
        //                                       ),
        //                                       const SizedBox(width: 10),
        //                                       FilledButton(
        //                                         child: Text(
        //                                           "Share Profile",
        //                                           style:
        //                                               context
        //                                                   .theme
        //                                                   .textTheme
        //                                                   .labelMedium,
        //                                         ),
        //                                         onPressed: () {
        //                                           // Share Profile Action
        //                                         },
        //                                       ),
        //                                     ]
        //                                     // If it's not the authenticated user's profile, show "Follow/Unfollow" buttons
        //                                     else ...[
        //                                       state.user.isFollowing
        //                                           ? state is ProfileLoading
        //                                               ? CircularProgressIndicator(
        //                                                 color: Colors.red,
        //                                               )
        //                                               : FilledButton(
        //                                                 style:
        //                                                     ElevatedButton.styleFrom(
        //                                                       backgroundColor:
        //                                                           Color.fromARGB(
        //                                                             255,
        //                                                             13,
        //                                                             82,
        //                                                             14,
        //                                                           ),
        //                                                     ),
        //                                                 child: Text(
        //                                                   "Unfollow",
        //                                                   style:
        //                                                       context
        //                                                           .theme
        //                                                           .textTheme
        //                                                           .labelMedium,
        //                                                 ),
        //                                                 onPressed: () {
        //                                                   context
        //                                                       .read<
        //                                                         ProfileBloc
        //                                                       >()
        //                                                       .add(
        //                                                         UnfollowUserEvent(
        //                                                           state.user.id,
        //                                                         ),
        //                                                       );
        //                                                 },
        //                                               )
        //                                           : state is ProfileLoading
        //                                           ? CircularProgressIndicator(
        //                                             color: Colors.red,
        //                                           )
        //                                           : FilledButton(
        //                                             style:
        //                                                 ElevatedButton.styleFrom(
        //                                                   backgroundColor:
        //                                                       Color.fromARGB(
        //                                                         255,
        //                                                         6,
        //                                                         47,
        //                                                         82,
        //                                                       ),
        //                                                 ),
        //                                             child: Text(
        //                                               "Follow",
        //                                               style:
        //                                                   context
        //                                                       .theme
        //                                                       .textTheme
        //                                                       .labelMedium,
        //                                             ),
        //                                             onPressed: () {
        //                                               context
        //                                                   .read<ProfileBloc>()
        //                                                   .add(
        //                                                     FollowUserEvent(
        //                                                       user.id,
        //                                                     ),
        //                                                   );
        //                                             },
        //                                           ),
        //                                       const SizedBox(width: 10),
        //                                       FilledButton(
        //                                         child: Text(
        //                                           "Message",
        //                                           style:
        //                                               context
        //                                                   .theme
        //                                                   .textTheme
        //                                                   .labelMedium,
        //                                         ),
        //                                         onPressed: () {
        //                                           // Share Profile Action
        //                                         },
        //                                       ),
        //                                     ],
        //                                     // Always show "Message" and "My Icon Button"
        //                                   ],
        //                                 ),
        //                                 const SizedBox(height: 10),
        //                                 Container(
        //                                   decoration: BoxDecoration(
        //                                     color: const Color(0xFF0B4B4A),
        //                                     borderRadius: BorderRadius.circular(
        //                                       5.0,
        //                                     ),
        //                                   ),
        //                                   child: const Padding(
        //                                     padding: EdgeInsets.symmetric(
        //                                       horizontal: 5,
        //                                     ),
        //                                   ),
        //                                 ),
        //                                 const SizedBox(height: 10),
        //                                 const Padding(
        //                                   padding: EdgeInsets.symmetric(
        //                                     horizontal: 20,
        //                                   ),
        //                                   child: Column(
        //                                     crossAxisAlignment:
        //                                         CrossAxisAlignment.start,
        //                                     children: [
        //                                       Text(
        //                                         'This is a short bio about the user. It can include interests, hobbies, or anything the user wants to share.',
        //                                         style: TextStyle(
        //                                           color: Colors.white,
        //                                           fontSize: 16,
        //                                         ),
        //                                       ),
        //                                     ],
        //                                   ),
        //                                 ),
        //                               ],
        //                             );
        //                           }
        //                           return Container(
        //                             height: 300,
        //                             alignment: Alignment.center,
        //                             child: Center(
        //                               child: CircularProgressIndicator(
        //                                 color: Colors.amber,
        //                               ),
        //                             ),
        //                           );
        //                         },
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //                 SliverPersistentHeader(
        //                   delegate: _SliverAppBarDelegate(
        //                     TabBar(
        //                       indicatorColor: Colors.white,
        //                       labelColor: Colors.white, // Active tab color
        //                       unselectedLabelColor:
        //                           Colors.grey, // Inactive tab col
        //                       tabs: profileTabs,
        //                     ),
        //                   ),
        //                   pinned: true,
        //                 ),
        //               ];
        //             },
        //             body: TabBarView(
        //               children: [
        //                 ProfilePostsGrid(
        //                   itemCount: myPosts.length,
        //                   myPosts: myPosts,
        //                 ),
        //                 FollowingUsersScreen(userId: user.id),
        //                 UsersFollowersScreen(userId: user.id),
        //               ],
        //             ),
        //           ),
        //         ),
        //       );
        //     },
        //   ),
        // ),
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
