## miestados

Estudio de estados en Flutter

- v0.0: El contador original

- v0.1: Multiples contadores
  * Un modelo de datos
  * Un estado para almacenar las instancias del modelo
  * Un widget para el modelo
  * Distintos setState()

- v1.0: Versión con Future
  * El nombre se obtine de un futuro _lejano_
  * El modelo cambia una de sus propiedades a Future
  
- v2.0: Versión con Strems
  * Se introduce dart:async
  * Cada instancia del modelo se añade al stream
  
- v3.0: Streams Future con API
  * Utilizamos Streams como en V2.0
  * Utilizamos Future como en V1.0
  * El nombre lo obtenemos de una public API, y mantenemos el retardo.



```
git log --oneline

git checkout fa7e26c; # para ir al contador original
git checkout 0a622fc; # multiples contadores
git checkout 86b3d22; # Con future
git checkout ef4a24f; # Con strems
```