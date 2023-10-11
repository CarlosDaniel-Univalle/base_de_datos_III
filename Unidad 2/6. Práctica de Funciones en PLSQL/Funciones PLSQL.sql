Función que devuelve la suma de los salarios de un departamento dado:

CREATE OR REPLACE FUNCTION calcular_suma_salarios(depto_id NUMBER)

RETURN NUMBER

IS

total_salario NUMBER := 0;

BEGIN

SELECT SUM(salario) INTO total_salario

FROM empleados

WHERE departamento_id = depto_id;

IF total_salario IS NULL THEN

RAISE_APPLICATION_ERROR(-20001, 'El departamento no existe o no tiene empleados.');

END IF;

RETURN total_salario;

END;

Función para incluir un parámetro OUT para el número de empleados afectados por la consulta:

CREATE OR REPLACE FUNCTION calcular_suma_salarios(depto_id NUMBER, num_empleados OUT NUMBER)

RETURN NUMBER

IS

total_salario NUMBER := 0;

BEGIN

SELECT COUNT(*) INTO num_empleados

FROM empleados

WHERE departamento_id = depto_id;

IF num_empleados = 0 THEN

RAISE_APPLICATION_ERROR(-20002, 'El departamento existe, pero no tiene empleados.');

END IF;

SELECT SUM(salario) INTO total_salario

FROM empleados

WHERE departamento_id = depto_id;

RETURN total_salario;

END;

Función llamada CREAR_REGION que devuelve el código de región asignado automáticamente:

CREATE OR REPLACE FUNCTION crear_region(nombre_region VARCHAR2)

RETURN NUMBER

IS

nuevo_codigo NUMBER;

BEGIN

-- Encontrar el código de región más alto existente

SELECT MAX(codigo_region) + 1 INTO nuevo_codigo

FROM regiones;

-- Insertar la nueva región con el nombre y el código calculado

INSERT INTO regiones(codigo_region, nombre_region)

VALUES (nuevo_codigo, nombre_region);

-- Comprobar si se realizó la inserción correctamente

IF SQL%ROWCOUNT = 0 THEN

RAISE_APPLICATION_ERROR(-20003, 'Error al crear la región.');

END IF;

RETURN nuevo_codigo;

END;