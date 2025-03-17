import 'package:flutter/material.dart';
import 'package:tafaling/features/user/data/data_sources/follower_data.dart';
import 'package:tafaling/features/user/presentation/widgets/user_tile.dart';

class UsersFollowersScreen extends StatelessWidget {
  const UsersFollowersScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Check if there are no users
    if (myFollowers.isEmpty) {
      return Center(
        child: Text(
          'No followers available',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey[500],
          ),
        ),
      );
    }

    // Build the followers list if there are users
    return ListView.builder(
      itemCount: myFollowers.length,
      itemBuilder: (context, index) {
        var user = myFollowers[index];

        return UserTile(
          userAvatar: user.profilePicture ?? '',
          userName: user.name,
          isFollowing: user.isFollowing,
          friendshipStatus: 2,
          onFollowToggle: () {},
          onFriendRequestToggle: () {},
          onViewProfile: () {},
        );
      },
    );
  }
}
