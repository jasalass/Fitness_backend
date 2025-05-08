# 🗄️ FitnessApp - Backend (Supabase SQL)

Este repositorio contiene el archivo SQL necesario para inicializar el backend de **FitnessApp** en Supabase.

Incluye la creación de:

- Tabla de perfiles (`perfiles`)
- Tabla de rutinas y ejercicios
- Tabla de sesiones realizadas
- Políticas RLS (Row-Level Security) seguras para cada tabla

---

## 📄 Archivo principal

- `esquemas.sql`: contiene toda la definición de las tablas y políticas necesarias.

---

## ⚙️ Uso

1. Crea un proyecto en [https://supabase.com](https://supabase.com)
2. Ve al panel → `SQL Editor`
3. Copia y ejecuta el contenido de [`esquemas.sql`](./esquemas.sql)

---

## ✅ Requisitos

Tu proyecto Supabase debe tener:

- Autenticación activada (`auth.users`)
- `Row Level Security` habilitado
- JWT correctamente configurado para que las políticas usen `auth.uid()`

---

## 📝 Contenido del esquemas.sql

- Tabla `perfiles` con vínculo a `auth.users(id)`
- Tabla `rutinas` por usuario
- Tabla `rutina_ejercicios` con orden y duración
- Tabla `sesiones_realizadas` con JSON de ejercicios
- Políticas seguras de `select`, `insert`, `update` y `delete` para cada tabla

---

## 📦 Instalación (pasos resumidos)

```sql
-- Dentro del SQL Editor de Supabase
-- Copiar y ejecutar el contenido de esquemas.sql
```

---

## 📜 Licencia

MIT — creado con fines educativos y para demostración de Supabase + React.
