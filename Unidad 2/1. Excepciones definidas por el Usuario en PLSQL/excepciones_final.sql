DECLARE
  PRAGMA EXCEPTION_INIT(CONTROL_REGIONES, -20001);

  v_region_code NUMBER := 201;

BEGIN
  IF v_region_code > 200 THEN
    RAISE CONTROL_REGIONES;
  ELSE
    DBMS_OUTPUT.PUT_LINE('Región insertada o modificada correctamente.');
  END IF;
EXCEPTION
  WHEN CONTROL_REGIONES THEN
    DBMS_OUTPUT.PUT_LINE('Error: Código no permitido. Debe ser inferior a 200');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error inesperado: ' || SQLERRM);
END;

