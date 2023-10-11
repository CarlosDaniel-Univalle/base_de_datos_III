DECLARE
  v_employee_id NUMBER := 100;

  v_employee_name VARCHAR2(50);

BEGIN
  SELECT first_name INTO v_employee_name FROM employees WHERE employee_id = v_employee_id;

  DBMS_OUTPUT.PUT_LINE('Nombre del empleado: ' || v_employee_name);

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Error: Empleado inexistente');
END;