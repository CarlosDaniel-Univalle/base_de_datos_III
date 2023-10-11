-- Crear el paquete "FACTURAS"
CREATE OR REPLACE PACKAGE FACTURAS AS
  -- Procedimiento para dar de alta una factura
  PROCEDURE ALTA_FACTURA(COD_FACTURA IN NUMBER, FECHA IN DATE, DESCRIPCION IN VARCHAR2);
  
  -- Procedimiento para borrar una factura y sus líneas de factura asociadas
  PROCEDURE BAJA_FACTURA(COD_FACTURA IN NUMBER);
  
  -- Procedimiento para modificar la descripción de una factura
  PROCEDURE MOD_DESCRI(COD_FACTURA IN NUMBER, DESCRIPCION IN VARCHAR2);
  
  -- Procedimiento para modificar la fecha de una factura
  PROCEDURE MOD_FECHA(COD_FACTURA IN NUMBER, FECHA IN DATE);
  
  -- Función para obtener el número de facturas entre dos fechas
  FUNCTION NUM_FACTURAS(FECHA_INICIO IN DATE, FECHA_FIN IN DATE) RETURN NUMBER;
  
  -- Función para obtener el total de una factura
  FUNCTION TOTAL_FACTURA(COD_FACTURA IN NUMBER) RETURN NUMBER;
END FACTURAS;
/

-- Implementación del paquete "FACTURAS"
CREATE OR REPLACE PACKAGE BODY FACTURAS AS
  -- Procedimiento para dar de alta una factura
  PROCEDURE ALTA_FACTURA(COD_FACTURA IN NUMBER, FECHA IN DATE, DESCRIPCION IN VARCHAR2) AS
  BEGIN
    -- Comprobar si la factura ya existe
    IF EXISTS (SELECT 1 FROM FACTURAS WHERE COD_FACTURA = ALTA_FACTURA.COD_FACTURA) THEN
      -- Factura duplicada, lanzar una excepción o tomar la acción adecuada
      -- Puedes usar RAISE_APPLICATION_ERROR para lanzar una excepción personalizada
      RAISE_APPLICATION_ERROR(-20001, 'Factura duplicada.');
    ELSE
      -- Insertar la factura en la tabla FACTURAS
      INSERT INTO FACTURAS (COD_FACTURA, FECHA, DESCRIPCION) VALUES (COD_FACTURA, FECHA, DESCRIPCION);
    END IF;
  END ALTA_FACTURA;

  -- Procedimiento para borrar una factura y sus líneas de factura asociadas
  PROCEDURE BAJA_FACTURA(COD_FACTURA IN NUMBER) AS
  BEGIN
    -- Borrar las líneas de factura asociadas en la tabla LINEAS_FACTURA
    DELETE FROM LINEAS_FACTURA WHERE COD_FACTURA = BAJA_FACTURA.COD_FACTURA;
    
    -- Borrar la factura en la tabla FACTURAS
    DELETE FROM FACTURAS WHERE COD_FACTURA = BAJA_FACTURA.COD_FACTURA;
  END BAJA_FACTURA;

  -- Procedimiento para modificar la descripción de una factura
  PROCEDURE MOD_DESCRI(COD_FACTURA IN NUMBER, DESCRIPCION IN VARCHAR2) AS
  BEGIN
    -- Modificar la descripción de la factura
    UPDATE FACTURAS SET DESCRIPCION = DESCRIPCION WHERE COD_FACTURA = MOD_DESCRI.COD_FACTURA;
  END MOD_DESCRI;

  -- Procedimiento para modificar la fecha de una factura
  PROCEDURE MOD_FECHA(COD_FACTURA IN NUMBER, FECHA IN DATE) AS
  BEGIN
    -- Modificar la fecha de la factura
    UPDATE FACTURAS SET FECHA = FECHA WHERE COD_FACTURA = MOD_FECHA.COD_FACTURA;
  END MOD_FECHA;

  -- Función para obtener el número de facturas entre dos fechas
  FUNCTION NUM_FACTURAS(FECHA_INICIO IN DATE, FECHA_FIN IN DATE) RETURN NUMBER AS
    NUM_FACTURAS_COUNT NUMBER;
  BEGIN
    SELECT COUNT(*) INTO NUM_FACTURAS_COUNT
    FROM FACTURAS
    WHERE FECHA BETWEEN FECHA_INICIO AND FECHA_FIN;
    
    RETURN NUM_FACTURAS_COUNT;
  END NUM_FACTURAS;

  -- Función para obtener el total de una factura
  FUNCTION TOTAL_FACTURA(COD_FACTURA IN NUMBER) RETURN NUMBER AS
    TOTAL NUMBER := 0;
  BEGIN
    SELECT SUM(PVP * UNIDADES) INTO TOTAL
    FROM LINEAS_FACTURA
    WHERE COD_FACTURA = TOTAL_FACTURA.COD_FACTURA;
    
    RETURN TOTAL;
  END TOTAL_FACTURA;
END FACTURAS;
/
