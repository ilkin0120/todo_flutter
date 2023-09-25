import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_test/src/features/add_task/presentation/cubits/add_task/add_task_cubit.dart';
import 'package:todo_test/src/features/add_task/presentation/cubits/tasks/tasks_cubit.dart';
import 'package:todo_test/src/features/add_task/presentation/screens/add_task.dart';
import 'package:todo_test/src/features/local_auth/presentation/screens/local_auth.dart';
import 'package:todo_test/src/routes/route_names.dart';

import '../features/home/presentation/screens/home.dart';
import 'custom_page_route.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case authRoute:
        return MaterialPageRoute(builder: (_) => const LocalAuth());
      case homeRoute:
        return CustomPageRoute(
            builder: (_) => BlocProvider<TasksCubit>(
                create: (_) => TasksCubit()..getAllTodos(),
                child: const Home()));
      case addTaskRoute:
        return CustomPageRoute(
            builder: (_) => BlocProvider<AddTaskCubit>(
                create: (_) => AddTaskCubit(), child: const AddTask()));
      default:
        throw UnimplementedError('No defined route: ${routeSettings.name}');
    }
  }
}
