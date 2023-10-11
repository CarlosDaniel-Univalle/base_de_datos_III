--Trigger de Tipo Sentencia para la Tabla FACTURAS
CREATE OR REPLACE TRIGGER TRG_FACTURAS_CONTROL_LOG
AFTER INSERT OR UPDATE OR DELETE ON FACTURAS
DECLARE
    V_OPERATION CHAR(1);
BEGIN
    IF INSERTING THEN
        V_OPERATION := 'I';
    ELSIF UPDATING THEN
        V_OPERATION := 'U';
    ELSIF DELETING THEN
        V_OPERATION := 'D';
    END IF;

    INSERT INTO CONTROL_LOG (COD_EMPLEADO, FECHA, TABLA, COD_OPERACION)
    VALUES (USER, SYSDATE, 'FACTURAS', V_OPERATION);
END;
/

--Trigger de Tipo Sentencia para la Tabla LINEAS_FACTURA
CREATE OR REPLACE TRIGGER TRG_LINEAS_FACTURA_CONTROL_LOG
AFTER INSERT OR UPDATE OR DELETE ON LINEAS_FACTURA
DECLARE
    V_OPERATION CHAR(1);
BEGIN
    IF INSERTING THEN
        V_OPERATION := 'I';
    ELSIF UPDATING THEN
        V_OPERATION := 'U';
    ELSIF DELETING THEN
        V_OPERATION := 'D';
    END IF;

    INSERT INTO CONTROL_LOG (COD_EMPLEADO, FECHA, TABLA, COD_OPERACION)
    VALUES (USER, SYSDATE, 'LINEAS FACTURA', V_OPERATION);
END;
/


--Trigger de Tipo Fila para Actualizar TOTAL_VENDIDOS en la Tabla PRODUCTOS
CREATE OR REPLACE TRIGGER TRG_ACTUALIZAR_TOTAL_VENDIDOS
AFTER INSERT OR UPDATE OR DELETE ON LINEAS_FACTURA
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        -- Añadir el total al campo TOTAL_VENDIDOS
        UPDATE PRODUCTOS
        SET TOTAL_VENDIDOS = TOTAL_VENDIDOS + :new.UNIDADES
        WHERE COD_PRODUCTO = :new.COD_PRODUCTO;
    ELSIF UPDATING THEN
        -- Comprobar si el valor antiguo era superior al nuevo
        IF :old.UNIDADES > :new.UNIDADES THEN
            -- Restar la diferencia al campo TOTAL_VENDIDOS
            UPDATE PRODUCTOS
            SET TOTAL_VENDIDOS = TOTAL_VENDIDOS - (:old.UNIDADES - :new.UNIDADES)
            WHERE COD_PRODUCTO = :new.COD_PRODUCTO;
        ELSIF :old.UNIDADES < :new.UNIDADES THEN
            -- Sumar la diferencia al campo TOTAL_VENDIDOS
            UPDATE PRODUCTOS
            SET TOTAL_VENDIDOS = TOTAL_VENDIDOS + (:new.UNIDADES - :old.UNIDADES)
            WHERE COD_PRODUCTO = :new.COD_PRODUCTO;
        END IF;
    ELSIF DELETING THEN
        -- Restar el total al campo TOTAL_VENDIDOS
        UPDATE PRODUCTOS
        SET TOTAL_VENDIDOS = TOTAL_VENDIDOS - :old.UNIDADES
        WHERE COD_PRODUCTO = :old.COD_PRODUCTO;
    END IF;
END;
/



-- Estos triggers realizarán lo siguiente:

-- El primer conjunto de triggers registra todas las operaciones INSERT, UPDATE y DELETE en las tablas FACTURAS y LINEAS_FACTURA en la tabla CONTROL_LOG.

-- El segundo trigger de tipo fila actualiza la columna TOTAL_VENDIDOS en la tabla PRODUCTOS en función de las operaciones INSERT, UPDATE y DELETE en la tabla LINEAS_FACTURA.

-- Asegúrate de ejecutar estos scripts en tu base de datos Oracle para implementar estas funcionalidades.
