import 'package:flutter/material.dart';
import 'package:tafaling/features/user/data/models/user_model.dart';

class UserTile extends StatelessWidget {
  final UserModel user;
  final Function onFollowToggle;
  final Function onFriendRequestToggle;
  final Function onViewProfile;

  const UserTile(
      {super.key,
      required this.user,
      required this.onFollowToggle,
      required this.onFriendRequestToggle,
      required this.onViewProfile});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 3, 34, 34),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.profilePicture ?? ''),
        ),
        title: Text(
          user.name,
          style: const TextStyle(color: Colors.white),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => onFollowToggle(),
              style: ElevatedButton.styleFrom(
                backgroundColor: user.isFollowing ? Colors.green : Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                minimumSize: const Size(70, 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: Text(
                user.isFollowing ? 'Unfollow' : 'Follow',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            // user.f == 2 // If already friends
            //     ? IconButton(
            //         icon: const Icon(
            //           Icons.person,
            //           color: Colors.white70,
            //         ),
            //         onPressed: () {},
            //       )
            //     : IconButton(
            //         icon: Icon(
            //           user.friendshipStatus == 1
            //               ? Icons.person_remove // Pending friend request
            //               : Icons.person_add, // Not friends
            //           color: user.friendshipStatus == 1
            //               ? Colors.orange
            //               : Colors.green,
            //         ),
            //         onPressed: () => onFriendRequestToggle(),
            //       ),
          ],
        ),
        onTap: () => onViewProfile(),
      ),
    );
  }
}
