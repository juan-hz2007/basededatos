# Construccion de base de Datos con lengueje SQL

El lenguje SQL que significa (Structure Querey Langueage) , se divide en cinco grandes categorias:

1.  DDL (Data Definition Language)
2. DML (Data Manmipulation Language)
3. DQL (Data Query Language)
4. DCL (Data Control Language - Controla permisos) - GRANT, REVOKE
5. TCL (Transaction Control Language - Controla Transacciones) - BEGIN TRANSACTION, COMMIT,
ROLLBACK, SAVEPOINT


## SQL-DDL

**Lenguaje de definicoon de datos**

se utiliza para **crear y modificar la estructura** de una base de datso:
- _Base de datos_
- _Tablas_
- _restricciones_
- vistas
- indices 
- Esquemas
- store procedures
- funcions
- triggers
 **comandos principales**
 | comando | funcion |
| :--- | :--- |
| CREATE | Crea objetos de la base de datos |
| ALTER | Modifica objetos de la base de datos |
| DROP | Elimina objetos de la base de datos  |
| TRUNCATE | Vacia una tabla |
| RENAME |Renombra Objetos (segun el SGBD)|

## SQL-DML

**Lenguaje de manipulacion de datos**

sirve para **trabajar con la infromacion almacenada**
con este lenguaje no se cambia la estructura, sino los registron 

**comandos principales**
| comando | funcion |
| :--- | :--- |
| INSERT | Inserta registros |
| UPDATE | Actuliza registros |
| DELETE | Elimina registros  |


## SQL-DQL

**lenguaje de consulta de datos**
 
 su funcion es **consultar infromacion**

 Este es probablemnte el grupo mas utilizado 

 **comando principales**
| comando | funcion |
| :--- | :--- |
| SELECT |Sirve para consultra infromacion |

Generalmente se combina con:

- WHERE
- ORDER BY
- GROPU BY
- HAVING 
- JOIN (LEFT , RIGHT , FULL ,  CROSS)
- DISTINCT
- TOP/LIMIT
- Funciones de agregado (SUM, AVG, MIN, MAX, COUNT)
- Window Funcions (Funciones de Ventana).



## Nomenclatura para construccion de las bases de Datos (Snake case)

la nomenclatura o convecion que mas se recomienda hoy si se busca una nomenclatura moderna,
portable y alineada con buenas practicas en distintos motores de base de datos

la razon es que funciona de forma consistente en **SQL, SERVER, MYSQL O MARIADB** y especialmente
en **POSGRESQL**, donde los identificadores sin commilas se convierten aoutomaticamente a 
minusculas. Con **SNAKE_CASE** evitas problemas de mayusculas y haces que las consultas sean mas 
legibles.
 
| Objetos | convecion | Ejemplo |
|:----------|:---------:|----------:|
| Base de datos | snake_case  | control_escolar |
| Esquema | snake_case  | ventas_rh, seguridad |
| Tablas | Singular en snake_case  | cliente, perdido, detalle_pedido |
| Columna | snake_case  | cliente:id, fecha_registro, correo_electronico |
| pk | <tablas>_id  | cliente_id,  producto_id |
| fk | igual que la pk referenciada  | cliente_id,  producto_id |
| tabla puente | <tablas1>_ <tablas2> | alumno_curso, producto_proveedor  |


## nombrar las restricciones
- pk_clientes
- fk_pedido_cliente
- uq_cliente_correo_electronico
- ck_producto_precio
- df_cliente_activo
- ix_pedido_fecha

**prefijo**
- pk (primary key)
- fk (foreign key)
- uq (unique)
- ck (check)
- df (default)
- ix (index)


## ALTER TABLE 

Permite modificar una tabla existente 

puede:
- agreegar columnas
- Eliminar columnas
- modifcar columnas 
- agregar restricciones
-  eliminar restricciones


