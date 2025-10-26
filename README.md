# 🧠 Modelos de Bases de Datos – Óptica & Pizzería


## 🕶️ Ejercicio 1: Óptica – `cul_de_ampolla`

### 📘 Descripción
Modelo de base de datos para una tienda de óptica que gestiona clientes, proveedores, marcas y ventas de gafas.  
El diseño aplica principios de **normalización** y asegura integridad referencial mediante claves foráneas y restricciones adecuadas.

### 🧩 Estructura principal
- **supplier** → Datos de proveedores (con NIF único).
- **brand** → Marcas asociadas a un proveedor.
- **glasses** → Catálogo de gafas con graduación y tipo de montura.
- **client** → Clientes, con posibilidad de ser recomendados por otros clientes.
- **seller** → Empleados que gestionan las ventas.
- **sale** → Cabecera de venta (cliente, vendedor, fecha).
- **sale_detail** → Detalle de venta (gafas, cantidad, precio unitario).
- **address** → Direcciones asociadas a clientes y proveedores.

## 🍕 Proyecto 2: Pizzería – `pizzeria`

### 📘 Descripción
Modelo de base de datos para una cadena de pizzerías que gestiona productos, pedidos, empleados, tiendas y clientes.  
Incluye relaciones **muchos a muchos** (productos ↔ categorías y pedidos ↔ productos) mediante tablas intermedias.

### 🧩 Estructura principal
- **town** → Pueblos y comarcas.
- **store** → Tiendas físicas (referencia a `town`).
- **worker** → Empleados (cocineros y repartidores) asignados a una tienda.
- **client** → Clientes vinculados a un `town`.
- **product** → Catálogo de productos (`pizza`, `burger`, `drink`).
- **category** → Clasificación de productos (vegana, sin gluten, picante…).
- **pizza_category** → Relación *muchos a muchos* entre `product` y `category`.
- **request** → Cabecera del pedido (cliente, tienda, trabajador, tipo de entrega).
- **request_detail** → Detalle del pedido (producto, cantidad, precio unitario).

---

## 🧰 Tecnologías utilizadas
- **MySQL Workbench**
- **MySQL Server** 
- **Git / GitHub** 
