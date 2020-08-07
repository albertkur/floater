import 'package:example/pages/routes.dart';
import 'package:example/pages/todos/todos_page.dart';
import 'package:example/sdk/todo/proxies/todo.dart';
import 'package:example/sdk/todo/services/todos_service/todos_service.dart';
import 'package:floater/floater.dart';
import 'package:flutter/material.dart';

class TodosPageState extends WidgetStateBase<TodosPage> {
  final _navigator = NavigationService.instance.retrieveNavigator("/");
  final _todosService = ServiceLocator.instance
      .resolve<TodosService>(); // getting the todoService installed

  List<Todo> _todos;
  List<Todo> get todos => this._todos ?? [];

  bool _isTogglingTodoCompletion = false;
  bool get isTogglingTodoCompletion => this._isTogglingTodoCompletion;
  set isTogglingTodoCompletion(bool value) =>
      (this.._isTogglingTodoCompletion = value).triggerStateChange();

  TodosPageState() : super() {
    this.onInitState(() {
      this._loadTodos();
    });
  }

  Future<void> onTodoPressed(Todo todo) async {
    given(todo, "todo").ensureHasValue();
    await this._navigator.pushNamed(
      NavigationService.instance.generateRoute(Routes.viewTodo),
      arguments: {
        "todo": todo,
      },
    );
    this.triggerStateChange();
  }

  Future<void> onEditTodoPressed(Todo todo) async {
    given(todo, "todo").ensureHasValue();
    this._navigator.pushNamed(
      NavigationService.instance.generateRoute(Routes.manageTodo),
      arguments: {
        "todo": todo,
      },
    );
  }

  void onAddTodoPressed() {
    this._navigator.pushNamed(
      NavigationService.instance.generateRoute(Routes.manageTodo),
      arguments: {
        "todo": null,
      },
    );
  }

  void toggleCompletionForTodo(Todo todo) async {
    given(todo, "todo").ensureHasValue();

    this.isTogglingTodoCompletion = true;
    try {
      await todo.toggleComplete();
    } catch (e) {
      debugPrint(e.toString());
      return;
    } finally {
      this.isTogglingTodoCompletion = false;
    }
  }

  Future<void> _loadTodos() async {
    this.showLoading();
    try {
      this._todos = await this._todosService.getAllTodos();
    } catch (e) {
      debugPrint(e);
      return;
    } finally {
      this.hideLoading();
    }
  }

  void onSwipeDelete(Todo todo) {
    this._todosService.removeTodo(todo);
    this._loadTodos();
  }
}
