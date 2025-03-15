import 'package:flutter/material.dart';
import 'package:tafaling/features/user/data/models/user_model.dart';
import 'package:tafaling/features/user/presentation/widgets/user_tile.dart';

class UsersFollowersScreen extends StatelessWidget {
  final int itemCount;
  final List<UserModel> users;

  const UsersFollowersScreen({
    super.key,
    required this.itemCount,
    required this.users,
  });

  @override
  Widget build(BuildContext context) {
    // Check if there are no users
    if (itemCount == 0) {
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
      itemCount: itemCount,
      itemBuilder: (context, index) {
        var user = users[index];

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
