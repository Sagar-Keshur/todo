// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/core/data/app_assets.dart';
import 'package:todo/core/extensions/build_context_ex.dart';
import 'package:todo/core/extensions/num_ext.dart';
import 'package:todo/core/themes/theme.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/views/layouts/layouts.dart';
import 'package:todo/views/pages/home/bloc/home_bloc.dart';
import 'package:todo/views/widgets/app_bars.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  static const String route = '/add-note';

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  late final HomeBloc _homeBloc = context.read<HomeBloc>();

  final TextEditingController title = TextEditingController();

  // @override
  // void dispose() {
  //   super.dispose();
  //   _homeBloc.addToDb(title.text);
  // }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) => _homeBloc.addToDb(title.text),
      child: Scaffold(
        appBar: BackButtonAppBar(context),
        body: BlocConsumer<HomeBloc, HomeState>(
          bloc: _homeBloc,
          listener: (context, state) {},
          builder: (context, state) => buildBody(state),
        ),
      ),
    );
  }

  Widget buildBody(HomeState state) {
    return ScrollableColumn.withSafeArea(
      padding: const EdgeInsets.all(16),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          style: context.textTheme.headlineLarge,
          cursorColor: TodoAppThemeData.basePrimary,
          controller: title,
          onFieldSubmitted: (value) {
            if (value.isNotEmpty) {
              _homeBloc.updateIsAllowed(true);
            } else {
              _homeBloc.updateIsAllowed(false);
            }
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Title',
            hintStyle: context.textTheme.headlineLarge?.copyWith(color: TodoAppThemeData.grayTitle),
          ),
        ),
        16.verticalSpace,
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            MainTask mainTask = state.subTask.elementAt(index);

            TextStyle? style;
            if (mainTask.isCompleted) {
              style = context.textTheme.labelMedium?.copyWith(
                decoration: TextDecoration.lineThrough,
                color: TodoAppThemeData.darkGray,
              );
            } else {
              style = context.textTheme.labelMedium?.copyWith(color: TodoAppThemeData.blackColor);
            }

            return Row(
              children: [
                Checkbox(
                  side: const BorderSide(color: TodoAppThemeData.basePrimary),
                  activeColor: TodoAppThemeData.basePrimary,
                  checkColor: TodoAppThemeData.whiteColor,
                  value: mainTask.isCompleted,
                  onChanged: (value) => _homeBloc.doneTask(index, value!),
                ),
                12.horizontalSpace,
                Expanded(
                  child: Text(
                    mainTask.value ?? 'N/A',
                    style: style,
                  ),
                ),
                GestureDetector(
                  onTap: () => _homeBloc.remove(index),
                  child: SvgPicture.asset(AppAssets.trash),
                ),
              ],
            );
          },
          separatorBuilder: (context, index) => 20.verticalSpace,
          itemCount: state.subTask.length,
        ),
        24.verticalSpace,
        buildAddMainTask(context, state),
      ],
    );
  }

  Widget buildAddMainTask(BuildContext context, HomeState state) {
    bool isAllowed = state.isAllowed;

    return Visibility(
      visible: isAllowed ? state.isAdding : false,
      replacement: GestureDetector(
        onTap: isAllowed ? () => _homeBloc.updateIsAdding(true) : () => _homeBloc.updateIsAdding(false),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              AppAssets.add,
              color: isAllowed ? TodoAppThemeData.basePrimary : TodoAppThemeData.gray,
              height: 20,
              width: 20,
            ),
            8.horizontalSpace,
            Text(
              'Add main task',
              style: context.textTheme.labelMedium?.copyWith(
                color: isAllowed ? TodoAppThemeData.basePrimary : TodoAppThemeData.gray,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
      child: TextFormField(
        style: context.textTheme.titleMedium,
        cursorColor: TodoAppThemeData.basePrimary,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Enter Task',
          hintStyle: context.textTheme.titleMedium?.copyWith(color: TodoAppThemeData.grayTitle),
        ),
        onFieldSubmitted: (newValue) {
          if (newValue.isNotEmpty) {
            _homeBloc.addTask(task: MainTask(value: newValue));
          }
          _homeBloc.updateIsAdding(false);
        },
      ),
    );
  }
}
