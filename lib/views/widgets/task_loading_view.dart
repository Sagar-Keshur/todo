import 'package:flutter/material.dart';
import 'package:todo/core/extensions/extensions.dart';
import 'package:todo/core/themes/theme.dart';

class HistoryLoadingViewWidget extends StatelessWidget {
  const HistoryLoadingViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 26),
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: TodoAppThemeData.whiteColor,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [BoxShadow(offset: const Offset(4, 0), color: TodoAppThemeData.blackColor.withOpacity(0.1), blurRadius: 20)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 20, width: 100, color: Colors.black).toShimmer(),
              const SizedBox(height: 4),
              Container(height: 15, color: Colors.black).toShimmer(),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemCount: 8,
    );
  }
}
