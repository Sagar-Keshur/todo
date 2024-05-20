import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/views/pages/home/bloc/home_bloc.dart';
import 'package:todo/views/pages/home/view/loading_view.dart';
import 'package:todo/views/pages/home/view/notes_page.dart';
import 'package:todo/views/pages/home/view/start_your_journey_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeBloc _homeBloc = context.read<HomeBloc>();

  @override
  void initState() {
    super.initState();
    _homeBloc.fetch();
  }

  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: context.read<HomeBloc>(),
      listener: (context, state) {},
      builder: (context, state) {
        if (state.isLoading) return const LoadingView();

        if (state.tasks.isNotEmpty) {
          return NotesPage(tasks: state.tasks);
        } else {
          return const StartYourJourneyView();
        }
      },
    );
  }
}
