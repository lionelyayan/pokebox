import 'dart:math';

import 'package:flutter/material.dart';

Widget pagination({
  required BuildContext context,
  required int currentPage,
  required int totalPage,
  required int visibleCount,
  required Function(int page) onPageChange,
}) {
  int half = (visibleCount / 2).floor();
  int start = max(1, currentPage - half);
  int end = min(totalPage, start + visibleCount - 1);

  if (end - start + 1 < visibleCount) {
    start = max(1, end - visibleCount + 1);
  }

  Widget smallIcon(IconData icon, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Icon(icon, size: 26),
      ),
    );
  }

  return Center(
    child: Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 4,
      children: [
        smallIcon(
          Icons.first_page,
          currentPage > 1 ? () => onPageChange(1) : null,
        ),
        smallIcon(
          Icons.chevron_left,
          currentPage > 1 ? () => onPageChange(currentPage - 1) : null,
        ),
        for (int i = start; i <= end; i++)
          SizedBox(
            width: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: i == currentPage
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey[300],
                foregroundColor: i == currentPage ? Colors.white : Colors.black,
              ),
              onPressed: () => onPageChange(i),
              child: Text(i.toString(), style: const TextStyle(fontSize: 14)),
            ),
          ),
        smallIcon(
          Icons.chevron_right,
          currentPage < totalPage ? () => onPageChange(currentPage + 1) : null,
        ),
        smallIcon(
          Icons.last_page,
          currentPage < totalPage ? () => onPageChange(totalPage) : null,
        ),
      ],
    ),
  );
}
