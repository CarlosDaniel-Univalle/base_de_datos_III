--Para esta práctica, desarrollé un código más general que ayuda a entender el funcionamiento.

--Paquete REGIONES:
CREATE OR REPLACE PACKAGE REGIONES AS
  FUNCTION CON_REGION(codigo_region IN NUMBER) RETURN VARCHAR2;
  
  PROCEDURE ALTA_REGION(codigo IN NUMBER, nombre IN VARCHAR2);
  PROCEDURE BAJA_REGION(codigo IN NUMBER);
  PROCEDURE MOD_REGION(codigo IN NUMBER, nuevo_nombre IN VARCHAR2);
END REGIONES;
/

--Cuerpo del paquete "REGIONES" con la implementación de las funciones y procedimientos:
CREATE OR REPLACE PACKAGE BODY REGIONES AS
  FUNCTION CON_REGION(codigo_region IN NUMBER) RETURN VARCHAR2 IS
    nombre_region VARCHAR2(100);
  BEGIN
    SELECT nombre INTO nombre_region FROM tabla_de_regiones WHERE codigo = codigo_region;
    RETURN nombre_region;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN NULL;
  END CON_REGION;
  
  FUNCTION EXISTE_REGION(codigo IN NUMBER) RETURN BOOLEAN IS
    existe BOOLEAN := FALSE;
  BEGIN
    SELECT 1 INTO existe FROM tabla_de_regiones WHERE codigo = codigo;
    RETURN TRUE;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN FALSE;
  END EXISTE_REGION;

  PROCEDURE ALTA_REGION(codigo IN NUMBER, nombre IN VARCHAR2) IS
  BEGIN
    IF NOT EXISTE_REGION(codigo) THEN
      INSERT INTO tabla_de_regiones(codigo, nombre) VALUES (codigo, nombre);
    ELSE
      RAISE_APPLICATION_ERROR(-20001, 'La región ya existe.');
    END IF;
  END ALTA_REGION;
  
  PROCEDURE BAJA_REGION(codigo IN NUMBER) IS
  BEGIN
    IF EXISTE_REGION(codigo) THEN
      DELETE FROM tabla_de_regiones WHERE codigo = codigo;
    ELSE
      RAISE_APPLICATION_ERROR(-20002, 'La región no existe.');
    END IF;
  END BAJA_REGION;
  
  PROCEDURE MOD_REGION(codigo IN NUMBER, nuevo_nombre IN VARCHAR2) IS
  BEGIN
    IF EXISTE_REGION(codigo) THEN
      UPDATE tabla_de_regiones SET nombre = nuevo_nombre WHERE codigo = codigo;
    ELSE
      RAISE_APPLICATION_ERROR(-20003, 'La región no existe.');
    END IF;
  END MOD_REGION;
  
END REGIONES;
/


--Paquete NOMINA:
CREATE OR REPLACE PACKAGE NOMINA AS
  FUNCTION CALCULAR_NOMINA(salario_base IN NUMBER) RETURN NUMBER;
  
  FUNCTION CALCULAR_NOMINA(salario_base IN NUMBER, porcentaje_descuento IN NUMBER) RETURN NUMBER;
  
  FUNCTION CALCULAR_NOMINA(salario_base IN NUMBER, porcentaje_descuento IN NUMBER, tipo_comision IN CHAR) RETURN NUMBER;
  
END NOMINA;
/


--Cuerpo del paquete "NOMINA" con la implementación de las funciones sobrecargadas:

CREATE OR REPLACE PACKAGE BODY NOMINA AS
  FUNCTION CALCULAR_NOMINA(salario_base IN NUMBER) RETURN NUMBER IS
    salario_final NUMBER;
  BEGIN
    salario_final := salario_base * 0.85;
    RETURN salario_final;
  END CALCULAR_NOMINA;
  
  FUNCTION CALCULAR_NOMINA(salario_base IN NUMBER, porcentaje_descuento IN NUMBER) RETURN NUMBER IS
    salario_final NUMBER;
  BEGIN
    salario_final := salario_base * (1 - porcentaje_descuento / 100); -- Resta del porcentaje personalizado
    RETURN salario_final;
  END CALCULAR_NOMINA;
  
  FUNCTION CALCULAR_NOMINA(salario_base IN NUMBER, porcentaje_descuento IN NUMBER, tipo_comision IN CHAR) RETURN NUMBER IS
    salario_final NUMBER;
    comision NUMBER;
  BEGIN
    IF tipo_comision = 'V' THEN
      SELECT comision INTO comision FROM tabla_de_comisiones WHERE empleado_id = 123;
      
      salario_final := (salario_base + comision) * (1 - porcentaje_descuento / 100);
    ELSE
      salario_final := salario_base * (1 - porcentaje_descuento / 100);
    END IF;
    
    RETURN salario_final;
  END CALCULAR_NOMINA;
  
END NOMINA;
/

