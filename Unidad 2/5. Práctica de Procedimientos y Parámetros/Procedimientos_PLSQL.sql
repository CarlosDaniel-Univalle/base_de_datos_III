Procedimiento llamado "visualizar" que muestre el nombre y salario de todos los empleados:

CREATE OR REPLACE PROCEDURE visualizar

IS

BEGIN

FOR emp IN (SELECT nombre, salario FROM empleados) LOOP

DBMS_OUTPUT.PUT_LINE('Nombre: ' || emp.nombre || ', Salario: ' || emp.salario);

END LOOP;

END;

Procedimiento para incluir un parámetro que especifique el número de departamento y devuelva el número de empleados en una variable de tipo OUT:

CREATE OR REPLACE PROCEDURE visualizar(depto_id NUMBER, num_empleados OUT NUMBER)

IS

BEGIN

FOR emp IN (SELECT nombre, salario FROM empleados WHERE departamento_id = depto_id) LOOP

DBMS_OUTPUT.PUT_LINE('Nombre: ' || emp.nombre || ', Salario: ' || emp.salario);

END LOOP;

SELECT COUNT(*) INTO num_empleados

FROM empleados

WHERE departamento_id = depto_id;

END;

Bloque para formatear un número de cuenta y use un parámetro de tipo IN-OUT:

CREATE OR REPLACE PROCEDURE formatear_cuenta(numero_cuenta IN OUT VARCHAR2)

IS

BEGIN

-- Verificar si el número de cuenta tiene el formato correcto antes de formatear

IF LENGTH(numero_cuenta) <> 20 THEN

DBMS_OUTPUT.PUT_LINE('Error: El número de cuenta debe tener 20 caracteres.');

RETURN;

END IF;

-- Formatear el número de cuenta

numero_cuenta := SUBSTR(numero_cuenta, 1, 4) || '-' || SUBSTR(numero_cuenta, 5, 4) || '-' ||

SUBSTR(numero_cuenta, 9, 2) || '-' || SUBSTR(numero_cuenta, 11);

END;