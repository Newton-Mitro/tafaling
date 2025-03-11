import 'package:flutter/material.dart';
import 'package:tafaling/core/utils/app_context.dart';
import 'package:tafaling/features/post/data/models/post_model.dart';

class ReadMoreText extends StatefulWidget {
  final PostModel postModel;
  final int maxLines;
  final bool isExpanded;
  final VoidCallback? onClick; // Add onClick callback

  const ReadMoreText({
    super.key,
    required this.postModel,
    this.maxLines = 2,
    required this.isExpanded,
    required this.onClick, // Receive the callback function
  });

  @override
  State<ReadMoreText> createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  @override
  Widget build(BuildContext context) {
    final double maxHeight = MediaQuery.of(context).size.height - 260;
    final String text = widget.postModel.body ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(maxHeight: maxHeight),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Text(
              style: context.theme.textTheme.bodySmall,
              widget.isExpanded
                  ? text
                  : (text.length > 100 ? '${text.substring(0, 100)}...' : text),
              maxLines: widget.isExpanded ? null : widget.maxLines,
              overflow: widget.isExpanded ? null : TextOverflow.ellipsis,
            ),
          ),
        ),
        if (text.length > 100)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '...',
                style: context.theme.textTheme.bodySmall,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {
                  if (widget.onClick != null) {
                    widget.onClick!(); // Call the onClick function
                  }
                },
                child: Text(
                  widget.isExpanded ? 'Less' : 'More',
                  style: context.theme.textTheme.bodySmall,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
