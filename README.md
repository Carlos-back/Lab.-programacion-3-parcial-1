# Tienda Online - Parcial 1

Parcial 1 de **Laboratorio de Programación 3** (ISSD - Desarrollo de Software, 2026).

Sistema web para gestionar los productos de una tienda online, con altas, bajas, modificaciones y consultas sobre dos tablas relacionadas: `productos` y `categorias`.

* **Autor:** Carlos Gabriel Alanis Luna
* **Video explicativo:** https://drive.google.com/file/d/1Qd0NqeGLLuNQcyVr1hwl1szob8nW1kB5/view?usp=sharing

## Funcionalidades

|Página|Qué hace|
|-|-|
|`Default.aspx`|Página principal con hipervínculos a cada formulario|
|`altaproducto.aspx`|Carga de nuevos productos (valida nombre y precio)|
|`consultaproducto.aspx`|Listado de productos con su categoría (JOIN), con paginación y orden|
|`modificacionproducto.aspx`|Búsqueda por código y modificación de producto y categoría (solo guarda si cambió algún campo)|
|`bajaproducto.aspx`|Eliminación del producto seleccionado, con confirmación (no afecta a `categorias`)|

Cada formulario incluye un hipervínculo para volver a la página principal.

## Esquema de la base de datos

* `categorias` (`idCategoria` PK, `descripcion`)
* `productos` (`idProducto` PK, `nombre`, `precio`, `idCategoria` FK → `categorias`)

El campo "categoría" de `productos` se guarda como `idCategoria`, clave foránea hacia la tabla `categorias`.

## Cómo ejecutar el proyecto

1. Abrí SQL Server Management Studio y ejecutá el script `script\_tienda.sql`. Crea la base `tienda`, las tablas, la relación y 8 productos de ejemplo.
2. Abrí la solución (`.sln`) con Visual Studio 2022.
3. Revisá la cadena de conexión en `Web.config`:

```xml
   <connectionStrings>
     <add name="tienda"
          connectionString="Data Source=(local);Initial Catalog=tienda;Integrated Security=SSPI;" />
   </connectionStrings>
   ```

   Si tu servidor SQL tiene otro nombre (por ejemplo `.\\SQLEXPRESS` o `(localdb)\\MSSQLLocalDB`), cambialo en `Data Source`.

4. Establecé `Default.aspx` como página de inicio y ejecutá

## Estructura del proyecto

```
Default.aspx                 Página principal
altaproducto.aspx            Alta de productos
consultaproducto.aspx        Consulta con JOIN
modificacionproducto.aspx    Modificación
bajaproducto.aspx            Baja
estilos.css                  Hoja de estilos
Web.config                   Configuración y cadena de conexión
script\_tienda.sql            Script de la base de datos
```

