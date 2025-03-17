import 'package:flutter/material.dart';
import 'package:tafaling/features/user/data/data_sources/following_data.dart';
import 'package:tafaling/features/user/presentation/widgets/user_tile.dart';

class FollowingUsersScreen extends StatefulWidget {
  const FollowingUsersScreen({
    super.key,
  });

  @override
  State<FollowingUsersScreen> createState() => _FollowingUsersScreenState();
}

class _FollowingUsersScreenState extends State<FollowingUsersScreen> {
  @override
  Widget build(BuildContext context) {
    // Check if there are no users
    if (followingUsers.isEmpty) {
      return Center(
        child: Text(
          'Not following anyone',
          style: TextStyle(fontSize: 18, color: Colors.grey[500]),
        ),
      );
    }

    // Build the user list if there are users
    return ListView.builder(
      itemCount: followingUsers.length,
      itemBuilder: (context, index) {
        var user = followingUsers[index];

        return UserTile(
          userAvatar: user.profilePicture ?? '',
          userName: user.name,
          isFollowing: user.isFollowing,
          friendshipStatus: 1,
          onFollowToggle: () {},
          onFriendRequestToggle: () {},
          onViewProfile: () {},
        );
      },
    );
  }
}
