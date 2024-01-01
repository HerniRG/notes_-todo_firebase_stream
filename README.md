# Notes Cloud App

Notes Cloud App es una aplicación Flutter que facilita la toma y gestión segura de notas. La aplicación utiliza Firebase para la autenticación y el almacenamiento en la nube.

## Capturas de Pantalla

![Captura de Pantalla 1](https://live.staticflickr.com/65535/53434943161_9d84da21aa_o.png)
![Captura de Pantalla 2](https://live.staticflickr.com/65535/53434943166_aa63f7b794_o.png)
![Captura de Pantalla 3](https://live.staticflickr.com/65535/53435095253_49d2eb752f_o.png)
![Captura de Pantalla 4](https://live.staticflickr.com/65535/53434026262_36963146be_o.png)
![Captura de Pantalla 5](https://live.staticflickr.com/65535/53435272569_a8c4444852_o.png)

## Características

- **Autenticación de Usuario:** Iniciar sesión o registrarse.
- **Gestión de Notas:** Crear, editar y eliminar notas.
- **Favoritos:** Marcar notas como favoritas.

## Tecnologías Utilizadas

- **Flutter:** Desarrollo de la aplicación.
- **Firebase Authentication:** Autenticación de usuarios.
- **Cloud Firestore:** Almacenamiento y sincronización de datos en tiempo real.

## Estructura del Proyecto

- **`lib/`**: Código fuente principal.
  - **`pages/`**: Diferentes páginas de la aplicación.
  - **`services/`**: Servicios para autenticación y Firestore.
  - **`widgets/`**: Componentes de interfaz de usuario reutilizables.

## Streaming de Datos con StreamBuilder

Se utiliza `StreamBuilder` para manejar y actualizar en tiempo real los cambios en la interfaz de usuario basados en flujos de datos de Firestore. Por ejemplo, al mostrar las notas o sus actualizaciones de manera dinámica.

```dart
StreamBuilder(
  stream: firestoreService.getNotesStream(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      // Renderizar la interfaz de usuario basada en los datos del stream.
      return YourCustomWidget(data: snapshot.data);
    }
  },
)
```

## Comprendiendo el Código

- **`main.dart`:** Punto de entrada, inicializa Firebase y ejecuta la aplicación.
- **`pages/`:** Pantallas de la aplicación (autenticación, inicio, etc.).
- **`services/`:** Servicios de autenticación y Firestore.
- **`widgets/`:** Componentes de interfaz de usuario reutilizables.

## Contacto

- Hernán Rodríguez Garnica
- Email: hernanrg85@gmail.com
