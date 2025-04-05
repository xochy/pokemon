# 📱 Pokémon App (Flutter + BLoC + Modular Architecture)

## 1. 🧾 Descripción del proyecto

Este proyecto es una aplicación móvil desarrollada con **Flutter** que permite visualizar una lista de Pokémon consumiendo datos desde la [PokéAPI](https://pokeapi.co/).  
Está diseñada siguiendo el **patrón BLoC (Business Logic Component)** para la gestión del estado y está estructurada utilizando una **arquitectura modular**.

La aplicación se apoya en un **micro paquete independiente llamado `pokemon_package`**, encargado de manejar la capa de modelos y la comunicación con la API externa. Esto promueve una mayor escalabilidad, mantenibilidad y reutilización de código.

---

## 2. 🚀 Pasos para instalar y ejecutar la aplicación

### 🔧 Requisitos previos:
- Flutter SDK (>= 3.0.0)
- Dart SDK
- Un emulador o dispositivo físico

### 📥 Clonar el repositorio:
```bash
git clone https://github.com/tu_usuario/pokemon.git
cd pokemon
```

### 📦 Instalar dependencias:
```bash
flutter pub get
```

### ▶️ Ejecutar la aplicación:
```bash
flutter run
```
Asegúrate de tener un emulador activo o un dispositivo conectado.

## 3. 🔗 Comunicación con el micro paquete pokemon_package

### 📁 ¿Qué contiene pokemon_package?
1. Definición de modelos (Pokemon, PokemonList, etc.)
2. Servicios HTTP para consumir la PokéAPI
3. Clases de repositorio que abstraen la lógica de acceso a datos

### 🔄 ¿Cómo se comunica la app con el paquete?
1. Importación del paquete: El paquete está definido como una dependencia en el archivo pubspec.yaml del proyecto principal:

```bash
dependencies:
  pokemon_package:
    git:
      url: https://github.com/tu_usuario/pokemon_package.git
```

2. Uso dentro del BLoC: En los BLoCs de la app principal, se inyectan o instancian repositorios provistos por el micro paquete.
Ejemplo:

```bash
final repository = PokemonRepository();
repository.getPokemonList(); // Llama al API a través del micro paquete
```

3. Retorno de datos: Los datos recibidos son emitidos como estados a la UI mediante el patrón BLoC, asegurando una separación clara entre presentación y lógica.