# taskflow

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Alcance de TaskFlow

**Problema:** organizar actividades de tecnología y electrónica y reconocer cuáles siguen pendientes.  
**Usuario objetivo:** estudiante que planifica y consulta sus actividades académicas.

### Historias de usuario y criterios de aceptación

1. Como estudiante, quiero definir los datos de cada registro para guardar la información necesaria.
   - Criterio: cada tarea de ejemplo tiene identificador, título, descripción, prioridad, estado y usuario.
2. Como estudiante, quiero consultar una pantalla de bitácora para ver mis registros.
   - Criterio: la pantalla inicial muestra las cinco tareas en una lista desplazable.
3. Como estudiante, quiero identificar rápidamente cada registro para distinguir su contenido y estado.
   - Criterio: cada tarjeta muestra el título y la prioridad, e indica visualmente si está completada.
4. Como estudiante, quiero abrir un registro para consultar sus datos completos.
   - Criterio: al seleccionar una tarjeta se muestra su descripción, prioridad, estado e identificador de usuario.
5. Como estudiante, quiero filtrar la bitácora por categoría para encontrar registros de un tipo específico.
   - Criterio: al elegir una categoría, la lista muestra solo los registros que pertenecen a ella. Esta función requiere incorporar el campo de categoría al modelo; todavía no está implementada.

### Tareas de este proyecto

1. **Definir los datos de cada registro:** establecer qué información se guardará: título, descripción, categoría, fecha y estado.
2. **Diseñar la pantalla de la bitácora:** crear una interfaz clara para consultar registros de tecnología y electrónica.
3. **Crear la tarjeta de registro:** mostrar el título, la descripción, la categoría y el estado en cada elemento.
4. **Implementar la lista de registros:** mostrar las entradas de la bitácora en una lista desplazable.
5. **Agregar filtros por categoría:** filtrar la bitácora por tipo de registro.

### Modelo de datos actual

| Campo | Tipo | Descripción |
|---|---|---|
| `id` | entero | Identificador único de la tarea |
| `title` | texto | Título de la actividad |
| `description` | texto | Descripción de la actividad |
| `priority` | texto | Prioridad: Alta, Media o Baja |
| `isCompleted` | booleano | Indica si la actividad está completada |
| `userId` | entero | Identificador del usuario de prueba |

El modelo actual aún no incluye categoría ni fecha.

### Pantallas previstas

- **Lista:** tarjetas con el título, prioridad y estado; permite abrir el detalle.
- **Detalle:** muestra la descripción, prioridad, estado e identificador del usuario.
- **Filtro por categoría:** pendiente de implementar junto con el campo de categoría.

### Requisitos no funcionales

- La navegación debe ser clara y comprensible.
- Un identificador inexistente debe mostrar un mensaje en lugar de cerrar la aplicación.
- La lista debe permitir consultar todas las tareas mediante desplazamiento.

### Contrato de API previsto

| Método y ruta | Propósito |
|---|---|
| `GET /tasks` | Listar tareas |
| `GET /tasks/:id` | Consultar el detalle de una tarea |
| `POST /tasks` | Crear una tarea |
| `PATCH /tasks/:id` | Actualizar una tarea |
| `DELETE /tasks/:id` | Eliminar una tarea |

La API es una propuesta para una etapa futura. Estas rutas aún no están conectadas a un servidor.

## API de tareas

TaskFlow consulta la API remota `https://jsonplaceholder.typicode.com/todos?userId=2` mediante `TaskApiService` y conserva el repositorio remoto en `main.dart`.

Los campos recibidos se asignan así:

| Campo de la API | Campo de `Task` |
|---|---|
| `id` | `id` |
| `title` | `title` |
| `completed` | `isCompleted` |
| `userId` | `userId` |

La API no incluye `description` ni `priority`, por lo que TaskFlow usa `Sin descripción (API)` y `Sin prioridad (API)` como valores por defecto.

Marcar una tarea como completada o pendiente modifica únicamente la copia local mantenida por `TasksViewModel` y el repositorio configurado en la aplicación.

## Estados de carga y evidencia

La pantalla de tareas escucha `TasksViewModel` con `context.watch` y usa `context.read` para iniciar cargas y reintentos. Mientras se consulta la API aparece un indicador de carga; cuando la respuesta contiene tareas, se muestra la lista remota. Una respuesta vacía muestra el estado vacío y una consulta fallida muestra un mensaje con la acción **Reintentar**. La lista ya cargada se conserva si falla una actualización.

Para reproducir y capturar cada estado:

1. **Lista / éxito:** ejecuta la aplicación con conexión a internet. La API remota devuelve las tareas del usuario 2; captura la lista una vez que termine la carga.
2. **Carga:** pulsa el botón de actualizar o desliza hacia abajo en la lista y captura el indicador mientras la solicitud está en curso. Como la solicitud puede terminar rápido, repítelo si hace falta.
3. **Vacío:** cambia temporalmente `TaskApiService.userId` de `2` a `999` en `lib/features/tasks/data/task_api_service.dart`, reinicia la aplicación y captura el mensaje de lista vacía. Después restaura el valor `2`.
4. **Error y recuperación:** sin conexión a internet, pulsa actualizar para mostrar el error y captura esa pantalla. Restablece la conexión y pulsa **Reintentar**; la lista remota debe volver a mostrarse sin reiniciar la aplicación. Captura también la lista recuperada.
