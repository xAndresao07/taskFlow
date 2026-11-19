import '../domain/task.dart';
import 'task_repository.dart';

class LocalTaskRepository implements TaskRepository {
  LocalTaskRepository() {
    _tasks.addAll(const [
      Task(
        id: 1,
        title: 'Definir los datos de cada registro',
        description: 'Establecer qué información se guardará: título, descripción, categoría, fecha y estado.',
        priority: 'Alta',
        isCompleted: true,
        userId: 1,
      ),
      Task(
        id: 2,
        title: 'Diseñar la pantalla de la bitácora',
        description: 'Crear una interfaz clara para consultar registros de tecnología y electrónica.',
        priority: 'Alta',
        isCompleted: true,
        userId: 1,
      ),
      Task(
        id: 3,
        title: 'Crear la tarjeta de registro',
        description: 'Mostrar el título, la descripción, la categoría y el estado en cada elemento.',
        priority: 'Media',
        isCompleted: false,
        userId: 1,
      ),
      Task(
        id: 4,
        title: 'Implementar la lista de registros',
        description:
            'Mostrar las entradas de la bitácora en una lista desplazable.',
        priority: 'Alta',
        isCompleted: false,
        userId: 1,
      ),
      Task(
        id: 5,
        title: 'Agregar filtros por categoría',
        description: 'Filtrar la bitácora por tipo de registro.',
        priority: 'Media',
        isCompleted: false,
        userId: 1,
      ),
    ]);
  }

  final List<Task> _tasks = [];

  @override
  List<Task> getTasks() => List.unmodifiable(_tasks);

  @override
  void save(Task task) {
    final index = _tasks.indexWhere((item) => item.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
    }
  }
}
