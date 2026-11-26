import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/features/tasks/data/task_repository.dart';
import 'package:taskflow/features/tasks/domain/task.dart';
import 'package:taskflow/features/tasks/presentation/tasks_view_model.dart';

void main() {
  const task = Task(
    id: 1,
    title: 'Tarea de prueba',
    description: 'Descripción',
    priority: 'Media',
    isCompleted: false,
    userId: 2,
  );

  test('retry recovers tasks after a failed refresh', () async {
    final repository = _FakeTaskRepository([
      () async => [task],
      () async => throw Exception('Sin conexión'),
      () async => [task],
    ]);
    final viewModel = TasksViewModel(repository);

    await viewModel.loadTasks();
    expect(viewModel.tasks, [task]);
    expect(viewModel.errorMessage, isNull);

    await viewModel.loadTasks();
    expect(viewModel.errorMessage, isNotNull);
    expect(viewModel.tasks, [task]);

    await viewModel.loadTasks();
    expect(viewModel.errorMessage, isNull);
    expect(viewModel.tasks, [task]);
  });

  test('empty response sets the empty state', () async {
    final viewModel = TasksViewModel(
      _FakeTaskRepository([() async => <Task>[]]),
    );

    await viewModel.loadTasks();

    expect(viewModel.isEmpty, isTrue);
    expect(viewModel.errorMessage, isNull);
  });
}

class _FakeTaskRepository implements TaskRepository {
  _FakeTaskRepository(this._responses);

  final List<Future<List<Task>> Function()> _responses;

  @override
  Future<List<Task>> getTasks() => _responses.removeAt(0)();

  @override
  void save(Task task) {}
}
