-- Crear el paquete "LINEA_FACTURAS"
CREATE OR REPLACE PACKAGE LINEA_FACTURAS AS
  -- Procedimiento para dar de alta una línea de factura
  PROCEDURE ALTA_LINEA(COD_FACTURA IN NUMBER, COD_PRODUCTO IN NUMBER, UNIDADES IN NUMBER, FECHA IN DATE);
  
  -- Procedimiento para dar de baja una línea de factura
  PROCEDURE BAJA_LINEA(COD_FACTURA IN NUMBER, COD_PRODUCTO IN NUMBER);
  
  -- Procedimiento para modificar unidades o fecha de una línea de factura
  PROCEDURE MOD_PRODUCTO(COD_FACTURA IN NUMBER, COD_PRODUCTO IN NUMBER, PARAMETRO IN NUMBER);
  PROCEDURE MOD_PRODUCTO(COD_FACTURA IN NUMBER, COD_PRODUCTO IN NUMBER, PARAMETRO IN DATE);
  
  -- Función para obtener el número de líneas de una factura
  FUNCTION NUM_LINEAS(COD_FACTURA IN NUMBER) RETURN NUMBER;
END LINEA_FACTURAS;
/

-- Implementación del paquete "LINEA_FACTURAS"
CREATE OR REPLACE PACKAGE BODY LINEA_FACTURAS AS
  -- Procedimiento para dar de alta una línea de factura
  PROCEDURE ALTA_LINEA(COD_FACTURA IN NUMBER, COD_PRODUCTO IN NUMBER, UNIDADES IN NUMBER, FECHA IN DATE) AS
  BEGIN
    -- Comprobar si la factura existe
    IF NOT EXISTS (SELECT 1 FROM FACTURAS WHERE COD_FACTURA = ALTA_LINEA.COD_FACTURA) THEN
      -- Factura no encontrada, lanzar una excepción o tomar la acción adecuada
      -- Puedes usar RAISE_APPLICATION_ERROR para lanzar una excepción personalizada
      RAISE_APPLICATION_ERROR(-20001, 'Factura no encontrada.');
    END IF;
    
    -- Comprobar si el producto existe en la tabla PRODUCTOS
    IF NOT EXISTS (SELECT 1 FROM PRODUCTOS WHERE COD_PRODUCTO = ALTA_LINEA.COD_PRODUCTO) THEN
      -- Producto no encontrado, lanzar una excepción o tomar la acción adecuada
      RAISE_APPLICATION_ERROR(-20002, 'Producto no encontrado.');
    END IF;
    
    -- Obtener el PVP del producto desde la tabla PRODUCTOS
    DECLARE
      V_PVP NUMBER;
    BEGIN
      SELECT PVP INTO V_PVP
      FROM PRODUCTOS
      WHERE COD_PRODUCTO = ALTA_LINEA.COD_PRODUCTO;
      
      -- Insertar la línea de factura en la tabla LINEAS_FACTURA
      INSERT INTO LINEAS_FACTURA (COD_FACTURA, COD_PRODUCTO, PVP, UNIDADES, FECHA)
      VALUES (COD_FACTURA, COD_PRODUCTO, V_PVP, UNIDADES, FECHA);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        -- Manejar la excepción si el producto no se encuentra
        RAISE_APPLICATION_ERROR(-20002, 'Producto no encontrado.');
    END;
  END ALTA_LINEA;

  -- Procedimiento para dar de baja una línea de factura
  PROCEDURE BAJA_LINEA(COD_FACTURA IN NUMBER, COD_PRODUCTO IN NUMBER) AS
  BEGIN
    -- Borrar la línea de factura en la tabla LINEAS_FACTURA
    DELETE FROM LINEAS_FACTURA
    WHERE COD_FACTURA = BAJA_LINEA.COD_FACTURA AND COD_PRODUCTO = BAJA_LINEA.COD_PRODUCTO;
  END BAJA_LINEA;

  -- Procedimiento para modificar unidades o fecha de una línea de factura
  PROCEDURE MOD_PRODUCTO(COD_FACTURA IN NUMBER, COD_PRODUCTO IN NUMBER, PARAMETRO IN NUMBER) AS
  BEGIN
    -- Modificar unidades de la línea de factura si PARAMETRO es NUMBER
    UPDATE LINEAS_FACTURA
    SET UNIDADES = PARAMETRO
    WHERE COD_FACTURA = MOD_PRODUCTO.COD_FACTURA AND COD_PRODUCTO = MOD_PRODUCTO.COD_PRODUCTO;
  END MOD_PRODUCTO;

  PROCEDURE MOD_PRODUCTO(COD_FACTURA IN NUMBER, COD_PRODUCTO IN NUMBER, PARAMETRO IN DATE) AS
  BEGIN
    -- Modificar fecha de la línea de factura si PARAMETRO es DATE
    UPDATE LINEAS_FACTURA
    SET FECHA = PARAMETRO
    WHERE COD_FACTURA = MOD_PRODUCTO.COD_FACTURA AND COD_PRODUCTO = MOD_PRODUCTO.COD_PRODUCTO;
  END MOD_PRODUCTO;

  -- Función para obtener el número de líneas de una factura
  FUNCTION NUM_LINEAS(COD_FACTURA IN NUMBER) RETURN NUMBER AS
    NUM_LINEAS_COUNT NUMBER;
  BEGIN
    SELECT COUNT(*) INTO NUM_LINEAS_COUNT
    FROM LINEAS_FACTURA
    WHERE COD_FACTURA = NUM_LINEAS.COD_FACTURA;
    
    RETURN NUM_LINEAS_COUNT;
  END NUM_LINEAS;
END LINEA_FACTURAS;
/
