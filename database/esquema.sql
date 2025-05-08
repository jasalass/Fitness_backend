-- 1. Tabla de ejercicios comunes
create table if not exists ejercicios_comunes (
  id uuid primary key default gen_random_uuid(),
  nombre text not null,
  tipo text check (tipo in ('cardio', 'fuerza', 'movilidad')),
  grupo_muscular text,
  imagen_url text,
  descripcion text
);

-- 2. Tabla de rutinas de entrenamiento
create table if not exists rutinas (
  id uuid primary key default gen_random_uuid(),
  nombre text not null,
  descripcion text,
  usuario_id uuid references auth.users(id) on delete cascade
);

-- 3. Tabla intermedia: ejercicios que componen una rutina
create table if not exists rutina_ejercicios (
  id uuid primary key default gen_random_uuid(),
  rutina_id uuid references rutinas(id) on delete cascade,
  ejercicio_id uuid references ejercicios_comunes(id) on delete cascade,
  duracion_min integer not null check (duracion_min > 0),
  orden integer not null check (orden >= 0)
);

-- 4. Tabla de sesiones programadas (asignadas por día)
create table if not exists sesiones_programadas (
  id uuid primary key default gen_random_uuid(),
  rutina_id uuid references rutinas(id) on delete cascade,
  fecha date not null,
  hora_inicio time,
  tiempo_total_objetivo integer check (tiempo_total_objetivo >= 0),
  tiempo_minimo integer check (tiempo_minimo >= 0),
  tiempo_maximo integer check (tiempo_maximo >= 0),
  usuario_id uuid references auth.users(id) on delete cascade
);

-- 5. Tabla de sesiones realizadas por el usuario
create table if not exists sesiones_realizadas (
  id uuid primary key default gen_random_uuid(),
  sesion_programada_id uuid references sesiones_programadas(id) on delete cascade,
  tiempo_real integer not null check (tiempo_real >= 0),
  completada boolean default false,
  ejercicios_realizados jsonb
);
 -- Permitir que cada usuario vea solo sus rutinas
create policy "usuario puede ver sus rutinas"
on rutinas
for select
using (auth.uid() = usuario_id);

-- Permitir que cada usuario vea solo sus sesiones_programadas
create policy "usuario ve sus sesiones programadas"
on sesiones_programadas
for select
using (auth.uid() = usuario_id);
