DECLARE
  PRAGMA EXCEPTION_INIT(duplicado, -1);

BEGIN
  INSERT INTO regions (region_id, region_name) VALUES (1, 'Nombre duplicado');
  
EXCEPTION
  WHEN duplicado THEN
    DBMS_OUTPUT.PUT_LINE('Error: Clave duplicada, intente otra');
END;