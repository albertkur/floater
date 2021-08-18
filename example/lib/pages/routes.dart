import 'package:example/pages/home/home_page.dart';
import 'package:example/pages/image_exif_extract/image_exif_extract_page.dart';
import 'package:example/pages/manage_todo/manage_todo_description/manage_todo_description_page.dart';
import 'package:example/pages/manage_todo/manage_todo_page.dart';
import 'package:example/pages/manage_todo/manage_todo_title/manage_todo_title_page.dart';
import 'package:example/pages/todos/todos_page.dart';
import 'package:example/pages/view_todo/view_todo_page.dart';
import 'package:floater/floater.dart';
import 'package:example/pages/splash/splash_page.dart';

abstract class Routes {
  static const splash = "/splash";
  static const home = "/home";

  static const imageExifExtract = "$home/imageExifExtract";

  static const todos = "$home/todos";
  static const manageTodo = "$home/manageTodo?{id?: string}";
  static const manageTodoTitle = "$home/manageTodo/title";
  static const manageTodoDescription = "$home/manageTodo/description";

  static const viewTodo = "$home/viewTodo?{id: string}";

  // Call this function in main.dart to register all the app pages
  // and bootstrap the navigation
  static void initializeNavigation() {
    // registering app pages here.
    // root nav pages
    NavigationManager.instance
      ..registerPage(Routes.splash, (routeArgs) => SplashPage())
      ..registerPage(Routes.home, (routeArgs) => HomePage());

    NavigationManager.instance
        .registerPage(Routes.imageExifExtract, (routeArgs) => ImageExifExtractPage());

    // Home Tab Pages
    NavigationManager.instance
      ..registerPage(Routes.todos, (routeArgs) => TodosPage())
      ..registerPage(Routes.manageTodo, (routeArgs) => ManageTodoPage(routeArgs["id"]))
      ..registerPage(Routes.manageTodoTitle, (routeArgs) => ManageTodoTitlePage())
      ..registerPage(Routes.manageTodoDescription, (routeArgs) => ManageTodoDescriptionPage())
      ..registerPage(Routes.viewTodo, (routeArgs) => ViewTodoPage(routeArgs["id"]));

    // bootstrapping Navigation
    NavigationManager.instance.bootstrap();
  }
}
