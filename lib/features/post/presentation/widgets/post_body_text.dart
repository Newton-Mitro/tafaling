import 'package:flutter/material.dart';
import 'package:tafaling/core/utils/app_context.dart';
import 'package:tafaling/features/post/domain/entities/post_entity.dart';
import 'package:tafaling/features/post/presentation/widgets/read_more_text.dart';

class PostBodyText extends StatefulWidget {
  final PostEntity postModel;

  const PostBodyText({super.key, required this.postModel});

  @override
  State<PostBodyText> createState() => _PostBodyTextState();
}

class _PostBodyTextState extends State<PostBodyText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return _isExpanded
        ? Container(
          width: double.infinity,
          color: context.theme.colorScheme.primary,
          padding: const EdgeInsets.only(bottom: 10, left: 15, right: 80),
          child: Column(
            spacing: 5,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.postModel.creator.name,
                style: context.theme.textTheme.titleMedium,
              ),
              ReadMoreText(
                postModel: widget.postModel,
                isExpanded: _isExpanded,
                onClick: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
              ),
            ],
          ),
        )
        : Container(
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: 10, left: 15, right: 80),
          child: Column(
            spacing: 5,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.postModel.creator.name,
                style: context.theme.textTheme.titleMedium,
              ),
              ReadMoreText(
                postModel: widget.postModel,
                isExpanded: _isExpanded,
                onClick: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
              ),
            ],
          ),
        );
  }
}
