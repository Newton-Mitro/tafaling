import 'package:flutter/material.dart';
import 'package:tafaling/core/utils/app_context.dart';

class UserTile extends StatelessWidget {
  final String userAvatar;
  final String userName;
  final bool isFollowing;
  final int friendshipStatus;
  final Function onFollowToggle;
  final Function onFriendRequestToggle;
  final Function onViewProfile;

  const UserTile({
    super.key,
    required this.userAvatar,
    required this.userName,
    required this.isFollowing,
    required this.friendshipStatus,
    required this.onFollowToggle,
    required this.onFriendRequestToggle,
    required this.onViewProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(userAvatar),
        ),
        title: Text(
          userName,
          style: TextStyle(
            fontSize: 14,
            color: context.theme.colorScheme.onSurface,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => onFollowToggle(),
              style: ElevatedButton.styleFrom(
                backgroundColor: isFollowing
                    ? const Color.fromARGB(255, 13, 82, 14)
                    : const Color.fromARGB(255, 6, 47, 82),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                minimumSize: const Size(70, 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: Text(
                isFollowing ? 'Unfollow' : 'Follow',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            friendshipStatus == 2 // If already friends
                ? IconButton(
                    icon: const Icon(
                      Icons.person,
                      color: Colors.white70,
                    ),
                    onPressed: () {},
                  )
                : IconButton(
                    icon: Icon(
                      friendshipStatus == 1
                          ? Icons.person_remove // Pending friend request
                          : Icons.person_add, // Not friends
                      color: friendshipStatus == 1
                          ? const Color.fromARGB(255, 13, 82, 14)
                          : const Color.fromARGB(255, 6, 47, 82),
                    ),
                    onPressed: () => onFriendRequestToggle(),
                  ),
          ],
        ),
        onTap: () => onViewProfile(),
      ),
    );
  }
}
