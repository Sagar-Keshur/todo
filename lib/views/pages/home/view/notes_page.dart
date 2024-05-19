import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/core/data/app_assets.dart';
import 'package:todo/core/extensions/build_context_ex.dart';
import 'package:todo/core/extensions/num_ext.dart';
import 'package:todo/core/themes/theme.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/views/pages/home/bloc/home_bloc.dart';

class NotesPage extends StatelessWidget {
  final List<Task> tasks;
  const NotesPage({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: RefreshIndicator(
        onRefresh: () async => context.read<HomeBloc>().fetch(),
        child: AlignedGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          itemCount: tasks.length,
          padding: const EdgeInsets.all(16),
          itemBuilder: (BuildContext context, int index) {
            return buildItem(context, index, tasks.elementAt(index));
          },
        ),
      ),
    );
  }

  Widget buildItem(BuildContext context, int mainIndex, Task task) {
    const BorderSide border = BorderSide(color: TodoAppThemeData.lightGray);
    const Radius radius = Radius.circular(8);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: context.width,
          decoration: const BoxDecoration(
            border: Border(left: border, right: border, top: border),
            borderRadius: BorderRadius.vertical(top: radius),
            color: TodoAppThemeData.whiteColor,
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title ?? 'N/A',
                style: context.textTheme.titleMedium,
              ),
              16.verticalSpace,
              ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    MainTask? mainTask = task.subTask?.elementAt(index);
                    return Row(
                      children: [
                        SizedBox(
                          height: 28,
                          width: 28,
                          child: Checkbox(
                            side: const BorderSide(color: TodoAppThemeData.basePrimary),
                            activeColor: TodoAppThemeData.basePrimary,
                            checkColor: TodoAppThemeData.whiteColor,
                            value: mainTask?.isCompleted,
                            onChanged: (value) {
                              context.read<HomeBloc>().updateTaskStatus(
                                    mainIndex: mainIndex,
                                    index: index,
                                    value: value!,
                                  );
                            },
                          ),
                        ),
                        12.horizontalSpace,
                        Expanded(
                          child: Text(
                            mainTask?.value ?? 'N/A',
                            style: context.textTheme.titleSmall?.copyWith(
                              color: TodoAppThemeData.blackColor,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => 8.verticalSpace,
                  itemCount: task.subTask?.length ?? 0)
            ],
          ),
        ),
        Container(
          width: context.width,
          decoration: const BoxDecoration(
            border: Border(left: border, right: border, bottom: border),
            borderRadius: BorderRadius.vertical(bottom: radius),
            color: TodoAppThemeData.basePrimary,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(
            'Task',
            style: context.textTheme.titleSmall?.copyWith(
              fontSize: 10,
              color: TodoAppThemeData.whiteColor,
            ),
          ),
        ),
      ],
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 180,
      backgroundColor: TodoAppThemeData.basePrimary,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      title: Row(
        children: [
          16.horizontalSpace,
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Amazing Journey!',
                style: context.textTheme.headlineMedium?.copyWith(color: Colors.white),
              ),
              4.verticalSpace,
              Text(
                'You have successfully\nfinished ${tasks.length} notes',
                style: context.textTheme.titleSmall?.copyWith(color: Colors.white),
                maxLines: 2,
                textAlign: TextAlign.start,
              ),
            ],
          ),
          Expanded(
            child: SvgPicture.asset(AppAssets.journey, alignment: Alignment.bottomCenter),
          ),
        ],
      ),
    );
  }
}
