-- BORRAR SI EXISTEN
drop table if exists sesiones_realizadas cascade;
drop table if exists rutina_ejercicios cascade;
drop table if exists rutinas cascade;
drop table if exists perfiles cascade;

-- TABLA PERFIL
create table perfiles (
  id uuid primary key references auth.users(id) on delete cascade,
  nombre text
);

alter table perfiles enable row level security;

create policy "Insertar perfil propio"
on perfiles for insert
with check (auth.uid() = id);

create policy "Ver perfil propio"
on perfiles for select
using (auth.uid() = id);

-- TABLA RUTINAS
create table rutinas (
  id uuid primary key default gen_random_uuid(),
  nombre text not null,
  descripcion text,
  dia_semana text,
  usuario_id uuid references auth.users(id) on delete cascade
);

alter table rutinas enable row level security;

create policy "usuario puede ver sus rutinas"
on rutinas for select using (auth.uid() = usuario_id);

create policy "usuario puede insertar sus rutinas"
on rutinas for insert with check (auth.uid() = usuario_id);

create policy "usuario puede actualizar sus rutinas"
on rutinas for update using (auth.uid() = usuario_id);

create policy "usuario puede borrar sus rutinas"
on rutinas for delete using (auth.uid() = usuario_id);

-- TABLA EJERCICIOS
create table rutina_ejercicios (
  id uuid primary key default gen_random_uuid(),
  rutina_id uuid references rutinas(id) on delete cascade,
  ejercicio text not null,
  duracion_min integer check (duracion_min > 0),
  orden integer
);

alter table rutina_ejercicios enable row level security;

create policy "puede ver ejercicios"
on rutina_ejercicios for select using (true);

create policy "puede insertar ejercicios"
on rutina_ejercicios for insert with check (true);

-- TABLA SESIONES
create table sesiones_realizadas (
  id uuid primary key default gen_random_uuid(),
  sesion_programada_id uuid,
  rutina_id uuid references rutinas(id) on delete set null,
  usuario_id uuid references auth.users(id) on delete cascade,
  tiempo_real integer,
  completada boolean default false,
  ejercicios_realizados jsonb,
  fecha timestamp default current_timestamp
);

alter table sesiones_realizadas enable row level security;

create policy "usuario puede insertar sesiones"
on sesiones_realizadas for insert
with check (auth.uid() = usuario_id);

create policy "usuario puede ver sus sesiones"
on sesiones_realizadas for select
using (auth.uid() = usuario_id);
