-- esquema persona:
create schema personal;

-- esquema ventas:
create schema ventas;

-- esquema relaciones:
create schema relaciones;


-----------------------------------
-- RELACIONES
-----------------------------------

-- Table : roles
create table relaciones.roles(
	id serial primary key,
	nombre varchar(300)
);

------------------------------------
-- PERSONAL
------------------------------------

-- Table: personal.user
create table personal.usuario(
	id serial primary key,
	rol_id int not null,
	nickname varchar(100) not null,
	contrasena varchar(100) not null,
	email varchar(200) not null
);

-- Table: personal.superadmin
create table personal.superadmin(
	id serial primary key,
	usuario_id int unique,
	nombres varchar(100) not null,
	apellidos varchar(200) not null,
	dni varchar(200) not null,
	fecha_nacimiento date not null
);

-- Table: personal.administrador
create table personal.administrador(
	id serial primary key,
	usuario_id int unique,
	nombres varchar(200) not null,
	apellidos varchar(200) not null,
	dni varchar(100) not null,
	fecha_nacimiento date not null
);

-- Table: personal.conductor
create table personal.conductor(
	id serial primary key,
	usuario_id int unique,
	nombres varchar(100) not null,
	apellidos varchar(100) not null,
	licencia varchar (100) not null,
	dni varchar(100) not null,
	fecha_nacimiento date not null
);	

-- Table: personal.empleado
create table personal.empleado(
	id serial primary key,
	usuario_id int unique,
	nombres varchar(100) not null,
	apellidos varchar(200) not null,
	dni varchar(200) not null,
	fecha_nacimiento date not null,
	codigo_empleado varchar(200) not null
);

------------------------------------
-- VENTAS
------------------------------------

-- Table: ventas.cliente
create table ventas.cliente(
	id serial primary key,
	usuario_id int unique,
	frecuencia int,
	nombre varchar(100) not null,
	apellidos varchar(100) not null,
	fecha_nacimiento date,
	sexo varchar(100),
	direccion varchar(150),
	telefono varchar(50),
	dni varchar(100) not null,
	codigo varchar(200),
	saldo_beneficios int,
	direccion_empresa varchar(200),
	suscripcion varchar(200),
	ubicacion varchar(200), --GEOMETRY
	RUC varchar(200),
	nombre_empresa varchar(200),
	zona_trabajo_id int
);

create table ventas.cliente_noregistrado(
	id serial primary key,
	nombre varchar(200),
	apellidos varchar(300),
	direccion varchar(200),
	telefono varchar(50),
	email varchar(50),
	distrito varchar(50),
	ubicacion varchar(300), --geometry
	RUC varchar(20)
);

-- Table: ventas.ruta
create table ventas.ruta(
	id serial primary key,
	conductor_id int,
	administrador_id int,
	empleado_id int,
	distancia_km int,
	tiempo_ruta int,
	zona_trabajo_id int
);

-- Table: ventas.pedido
create table ventas.pedido(
	id serial primary key,
	ruta_id int,
	cliente_id int,
	cliente_nr_id int,
	descuento int,
	monto_total float not null,
	fecha timestamp not null,
	tipo varchar(20),
	foto varchar(200),
	estado varchar(50) -- pendiente, en proceso, entregado
);

--Table: ventas.producto
create table ventas.producto(
	id serial primary key,
	nombre varchar(200) not null,
	precio float not null,
	descripcion varchar(200) not null,
	stock int not null,
	foto varchar(200)
);

--Table: ventas.promos
create table ventas.promocion(
	id serial primary key,
	nombre varchar(200) not null,
	precio float not null,
	descripcion varchar(200) not null,
	fecha_inicio timestamp not null,
	fecha_limite timestamp not null,
	foto varchar(200)
);

-- Table: ventas.vehiculo
create table ventas.vehiculo(
	id serial primary key,
	conductor_id int not null,
	placa varchar(100) not null,
	capacidad_carga_ton int not null
);

--Table: ventas.zona_trabajo
create table ventas.zona_trabajo(
	id serial primary key,
	ubicacion varchar(100), --GEOMETRY(POINT,4326), --municipalidad
	poligono varchar(1000),--GEOMETRY(POLYGON,4326),
	departamento varchar(50),
	provincia varchar(50),
	distrito varchar(50),
	superadmin_id int
);

---------------------------------
-- RELACIONES
---------------------------------

--Table: relaciones.compra
create table relaciones.detalle_pedido(
	id serial primary key,
	pedido_id int,
	producto_id int not null,
	cantidad int not null,
	promocion_id int
);

--Table: productos.pedido
create table relaciones.producto_promocion(
	id serial primary key,
	promocion_id int not null,
	producto_id int not null,
	cantidad int not null
);

---------------------------------
-- CONSTRAINTS
---------------------------------
-- ALTER TABLE orders ADD CONSTRAINT fk_orders_customers FOREIGN KEY (customer_id) REFERENCES customers (id);

--- RUTA
ALTER TABLE ventas.ruta ADD CONSTRAINT fk_ruta_empleado FOREIGN KEY (empleado_id) REFERENCES personal.empleado (id);
ALTER TABLE ventas.ruta ADD CONSTRAINT fk_ruta_conductor FOREIGN KEY (conductor_id) REFERENCES personal.conductor (id);
ALTER TABLE ventas.ruta ADD CONSTRAINT fk_ruta_administrador FOREIGN KEY (administrador_id) REFERENCES personal.administrador (id);
ALTER TABLE ventas.ruta ADD CONSTRAINT fk_ruta_zona_trabajo FOREIGN KEY (zona_trabajo_id) REFERENCES ventas.zona_trabajo (id);

-- PEDIDO
ALTER TABLE ventas.pedido ADD CONSTRAINT fk_pedido_ruta FOREIGN KEY (ruta_id) REFERENCES ventas.ruta (id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE ventas.pedido ADD CONSTRAINT fk_pedido_cliente FOREIGN KEY (cliente_id) REFERENCES ventas.cliente (id) ON DELETE CASCADE ON UPDATE CASCADE;

-- DETALLE PEDIDO
ALTER TABLE relaciones.detalle_pedido ADD CONSTRAINT fk_detallepedido_promocion FOREIGN KEY (promocion_id) REFERENCES ventas.promocion (id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE relaciones.detalle_pedido ADD CONSTRAINT fk_detallepedido_producto FOREIGN KEY (producto_id) REFERENCES ventas.producto (id) ON DELETE CASCADE ON UPDATE CASCADE;

-- PRODUCTO PROMOCION
ALTER TABLE relaciones.producto_promocion ADD CONSTRAINT fk_productopromocion_promocion FOREIGN KEY (promocion_id) REFERENCES ventas.promocion (id) ON DELETE CASCADE ON UPDATE CASCADE;

-- pedido-cliente nr
ALTER TABLE ventas.pedido ADD CONSTRAINT fk_pedido_clientenr FOREIGN KEY (cliente_nr_id) REFERENCES ventas.cliente_noregistrado (id) ON DELETE CASCADE ON UPDATE CASCADE;

-- ZONA TRABAJO
ALTER TABLE ventas.zona_trabajo ADD CONSTRAINT fk_zona_trabajo_superadmin FOREIGN KEY (superadmin_id) REFERENCES personal.superadmin (id);

-- VEHICULO
ALTER TABLE ventas.vehiculo ADD CONSTRAINT fk_vehiculo_conductor FOREIGN KEY (conductor_id) REFERENCES personal.conductor (id) ON DELETE CASCADE ON UPDATE CASCADE;


-- COMPRA
ALTER TABLE relaciones.detalle_pedido ADD CONSTRAINT fk_compra_producto FOREIGN KEY (producto_id) REFERENCES ventas.producto (id);
ALTER TABLE relaciones.detalle_pedido ADD CONSTRAINT fk_compra_pedido FOREIGN KEY (pedido_id) REFERENCES ventas.pedido (id) ON DELETE CASCADE ON UPDATE CASCADE;

-- ROLES
ALTER TABLE personal.usuario ADD CONSTRAINT fk_usuario_rol FOREIGN KEY (rol_id) REFERENCES relaciones.roles(id);

-- CLIENTE
ALTER TABLE ventas.cliente ADD CONSTRAINT fk_cliente_zona FOREIGN KEY (zona_trabajo_id) REFERENCES ventas.zona_trabajo (id) ON DELETE CASCADE ON UPDATE CASCADE;


-- USUARIOS
ALTER TABLE ventas.cliente ADD CONSTRAINT fk_cliente_usuario FOREIGN KEY (usuario_id) REFERENCES personal.usuario(id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE personal.superadmin ADD CONSTRAINT fk_superadmin_usuario FOREIGN KEY (usuario_id) REFERENCES personal.usuario(id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE personal.administrador ADD CONSTRAINT fk_administrador_usuario FOREIGN KEY (usuario_id) REFERENCES personal.usuario(id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE personal.conductor ADD CONSTRAINT fk_conductor_usuario FOREIGN KEY (usuario_id) REFERENCES personal.usuario(id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE personal.empleado ADD CONSTRAINT fk_empleado_usuario FOREIGN KEY (usuario_id) REFERENCES personal.usuario(id) ON DELETE CASCADE ON UPDATE CASCADE;


-- reseteo secuencias
-- Roles
SELECT setval('relaciones.roles_id_seq', 1, false);

-- Usuario
SELECT setval('personal.usuario_id_seq', 1, false);

-- Superadmin
SELECT setval('personal.superadmin_id_seq', 1, false);

-- Administrador
SELECT setval('personal.administrador_id_seq', 1, false);

-- Conductor
SELECT setval('personal.conductor_id_seq', 1, false);

-- Empleado
SELECT setval('personal.empleado_id_seq', 1, false);

-- Cliente
SELECT setval('ventas.cliente_id_seq', 1, false);

-- Cliente No Registrado
SELECT setval('ventas.cliente_noregistrado_id_seq', 1, false);

-- Ruta
SELECT setval('ventas.ruta_id_seq', 1, false);

-- Pedido
SELECT setval('ventas.pedido_id_seq', 1, false);

-- Producto
SELECT setval('ventas.producto_id_seq', 1, false);

-- Vehiculo
SELECT setval('ventas.vehiculo_id_seq', 1, false);

-- Zona Trabajo
SELECT setval('ventas.zona_trabajo_id_seq', 1, false);

-- Detalle Pedido
SELECT setval('relaciones.detalle_pedido_id_seq', 1, false);
