DECLARE
  v_employee_id NUMBER := 100;

BEGIN
  SELECT first_name INTO v_employee_name FROM employees WHERE employee_id > 100;

  DBMS_OUTPUT.PUT_LINE('Nombre del empleado: ' || v_employee_name);

EXCEPTION
  WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.PUT_LINE('Error: Demasiados empleados en la consulta');
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Error: Empleado inexistente');
END;