# Plan de corrección de errores - WhatsApp Clone

Este plan detalla las correcciones necesarias para resolver los errores de compilación, advertencias de análisis y problemas estructurales en el proyecto.

## User Review Required

> [!IMPORTANT]
> Se realizarán cambios en los nombres de los archivos para seguir las convenciones de Flutter (`snake_case`). Esto afectará a las importaciones en todo el proyecto.

> [!WARNING]
> El archivo `HomeView.dart` actualmente contiene la clase `ArchivedView`. Se modificará para que contenga la clase `HomeView` (Pantalla principal con todos los chats).

## Open Questions

1. ¿Hay algún diseño específico que desees para la `HomeView`? Por defecto, mostraré una lista de todos los chats no archivados con navegación a favoritos y archivados.

## Proposed Changes

### [Component] Renombrado de archivos y directorios
Se cambiarán los nombres de los archivos para cumplir con `lower_case_with_underscores` y se corregirá el nombre del directorio `provaider` a `provider`.

#### [MODIFY] [SQLiteChatDataSource.dart](file:///C:/Users/endor/StudioProjects/whatsapp_clone/lib/features/chat/data/database/SQLiteChatDataSource.dart) -> `sqlite_chat_data_source.dart`
#### [MODIFY] [ChatRepositoryImpl.dart](file:///C:/Users/endor/StudioProjects/whatsapp_clone/lib/features/chat/data/repositories/ChatRepositoryImpl.dart) -> `chat_repository_impl.dart`
#### [MODIFY] [ArchivedView.dart](file:///C:/Users/endor/StudioProjects/whatsapp_clone/lib/features/chat/presentation/pages/ArchivedView.dart) -> `archived_view.dart`
#### [MODIFY] [HomeView.dart](file:///C:/Users/endor/StudioProjects/whatsapp_clone/lib/features/chat/presentation/pages/HomeView.dart) -> `home_view.dart`
#### [MODIFY] [login_button..dart](file:///C:/Users/endor/StudioProjects/whatsapp_clone/lib/features/chat/presentation/widgets/login_button..dart) -> `login_button.dart`

---

### [Component] Presentation Logic (Providers)
Corrección del uso de `AsyncValue` vs `List`.

#### [MODIFY] [favorite_chat_provider.dart](file:///C:/Users/endor/StudioProjects/whatsapp_clone/lib/features/chat/presentation/provaider/favorite_chat_provider.dart)
- Eliminar `.maybeWhen()` ya que `chatProvider` devuelve una lista directa.

#### [MODIFY] [chat_provider.dart](file:///C:/Users/endor/StudioProjects/whatsapp_clone/lib/features/chat/presentation/provaider/chat_provider.dart)
- Asegurar que la carga inicial de chats se realice correctamente.

---

### [Component] UI Components & Pages

#### [MODIFY] [chat_tile.dart](file:///C:/Users/endor/StudioProjects/whatsapp_clone/lib/features/chat/presentation/widgets/chat_tile.dart)
- Envolver `ListTile` en un `GestureDetector` para soportar `onDoubleTap`.
- Eliminar importaciones innecesarias.

#### [MODIFY] [favorites_view.dart](file:///C:/Users/endor/StudioProjects/whatsapp_clone/lib/features/chat/presentation/pages/favorites_view.dart)
- Pasar argumentos obligatorios a `ChatTile`.
- Limpiar el código redundante.

#### [MODIFY] [detail_view.dart](file:///C:/Users/endor/StudioProjects/whatsapp_clone/lib/features/chat/presentation/widgets/detail_view.dart)
- Corregir el uso de `.when()` sobre una lista.

#### [MODIFY] [home_view.dart](file:///C:/Users/endor/StudioProjects/whatsapp_clone/lib/features/chat/presentation/pages/home_view.dart)
- Implementar la clase `HomeView` correctamente con navegación.

#### [MODIFY] [main.dart](file:///C:/Users/endor/StudioProjects/whatsapp_clone/lib/main.dart)
- Actualizar importaciones y el nombre de la clase `HomeView`.

## Verification Plan

### Automated Tests
- Ejecutar `flutter analyze` para verificar que no queden errores ni advertencias.
- Ejecutar `flutter build` (si es posible en el entorno) para asegurar la integridad del proyecto.

### Manual Verification
- Verificar la navegación entre Home, Favoritos y Archivados.
- Comprobar que el doble toque marque favoritos.
- Comprobar que el archivo/desarchivo funcione correctamente.
