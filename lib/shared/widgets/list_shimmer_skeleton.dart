import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListShimmerSkeleton extends StatelessWidget {
  const ListShimmerSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListTile(
        leading: const CircleAvatar(radius: 24, backgroundColor: Colors.white),
        title: Container(
          height: 12,
          width: 120,
          color: Colors.white,
          margin: const EdgeInsets.only(bottom: 8),
        ),
        subtitle: Container(height: 12, width: 200, color: Colors.white),
      ),
    );
  }
}
