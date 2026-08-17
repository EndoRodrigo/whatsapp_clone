# Plan de Corrección: Carga de Datos y Base de Datos

Este plan corrige los errores al cargar datos causados por un esquema de base de datos incompleto y desactualizado.

## User Review Required

> [!IMPORTANT]
> Se incrementará la versión de la base de datos a **5** para forzar la actualización del esquema y asegurar que las columnas `photoUrl` e `isArchived` existan para todos los usuarios.

> [!NOTE]
> Se corregirá el nombre del archivo `ChatErrorListener.dart` a `chat_error_listener.dart` para cumplir con las convenciones de Flutter.

## Proposed Changes

### [Component] Data Layer (SQLite)

#### [MODIFY] [app_database.dart](file:///C:/Users/endor/StudioProjects/whatsapp_clone/lib/features/chat/data/database/app_database.dart)
- Incrementar `version` a `5`.
- Actualizar `_onCreate` para incluir `photoUrl TEXT` e `isArchived INTEGER NOT NULL DEFAULT 0`.
- Actualizar `_onUpgrade` para manejar todas las versiones hasta la 5 de forma segura.

---

### [Component] Presentation Layer (Widgets)

#### [MODIFY] [chat_error_listener.dart](file:///C:/Users/endor/StudioProjects/whatsapp_clone/lib/features/chat/presentation/widgets/ChatErrorListener.dart) [RENAME]
- Renombrar archivo a `chat_error_listener.dart`.
- Actualizar importaciones en el proyecto si es necesario.

---

### [Component] Refactoring (Imports)

#### [MODIFY] [sqlite_chat_data_source.dart](file:///C:/Users/endor/StudioProjects/whatsapp_clone/lib/features/chat/data/database/sqlite_chat_data_source.dart)
- Eliminar importación no utilizada `chat_exception.dart`.

## Verification Plan

### Automated Tests
- Ejecutar `flutter analyze` para verificar que no haya advertencias de nombres de archivos o importaciones.

### Manual Verification
- Iniciar la aplicación y verificar que los chats de prueba se carguen correctamente.
- Verificar que no aparezca el mensaje de "Ocurrió un error inesperado" al iniciar.
- Probar la funcionalidad de archivar para asegurar que la columna `isArchived` funciona correctamente.
