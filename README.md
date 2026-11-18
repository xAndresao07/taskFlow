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
