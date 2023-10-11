DECLARE
  v_employee_name EMPLOYEES.FIRST_NAME%TYPE;
  v_employee_salary EMPLOYEES.SALARY%TYPE;
  v_department_manager_id EMPLOYEES.MANAGER_ID%TYPE;
  v_department_name DEPARTMENTS.DEPARTMENT_NAME%TYPE;
  v_is_manager BOOLEAN := FALSE;

  CURSOR salary_cursor IS
    SELECT FIRST_NAME, SALARY, MANAGER_ID
    FROM EMPLOYEES;
    
  CURSOR manager_cursor (p_employee_id EMPLOYEES.EMPLOYEE_ID%TYPE) IS
    SELECT D.DEPARTMENT_NAME, E.FIRST_NAME
    FROM DEPARTMENTS D
    JOIN EMPLOYEES E ON D.MANAGER_ID = E.EMPLOYEE_ID
    WHERE E.EMPLOYEE_ID = p_employee_id;
BEGIN
  FOR employee_rec IN salary_cursor LOOP
    v_employee_name := employee_rec.FIRST_NAME;
    v_employee_salary := employee_rec.SALARY;
    v_department_manager_id := employee_rec.MANAGER_ID;

    IF v_employee_name = 'Steven' AND v_department_manager_id IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, 'No se puede ver el sueldo del jefe (Steven King).');
    END IF;
  END LOOP;

  FOR department_rec IN (SELECT * FROM EMPLOYEES) LOOP
    OPEN manager_cursor(department_rec.EMPLOYEE_ID);

    FETCH manager_cursor INTO v_department_name, v_employee_name;
    IF manager_cursor%FOUND THEN
      DBMS_OUTPUT.PUT_LINE('El empleado ' || v_employee_name || ' es jefe del departamento ' || v_department_name);
      v_is_manager := TRUE;
    END IF;

    IF NOT v_is_manager THEN
      DBMS_OUTPUT.PUT_LINE('El empleado ' || department_rec.FIRST_NAME || ' no es jefe de nada');
    END IF;

    CLOSE manager_cursor;

    v_is_manager := FALSE;
  END LOOP;

  PROCEDURE get_employee_count (p_department_id NUMBER) IS
    CURSOR employee_count_cursor (p_dept_id NUMBER) IS
      SELECT COUNT(*) AS EMPLOYEE_COUNT
      FROM EMPLOYEES
      WHERE DEPARTMENT_ID = p_dept_id;
    v_count NUMBER;
  BEGIN
    OPEN employee_count_cursor(p_department_id);
    FETCH employee_count_cursor INTO v_count;
    DBMS_OUTPUT.PUT_LINE('El número de empleados en el departamento ' || p_department_id || ' es ' || v_count);
    CLOSE employee_count_cursor;
  END;

  get_employee_count(10);

  FOR employee_name_rec IN (SELECT FIRST_NAME FROM EMPLOYEES WHERE JOB_ID = 'ST_CLERK') LOOP
    DBMS_OUTPUT.PUT_LINE('Empleado ST_CLERK: ' || employee_name_rec.FIRST_NAME);
  END LOOP;

  FOR employee_rec IN (SELECT * FROM EMPLOYEES FOR UPDATE) LOOP
    IF employee_rec.SALARY > 8000 THEN
      UPDATE EMPLOYEES
      SET SALARY = SALARY * 1.02
      WHERE CURRENT OF salary_cursor;
    ELSIF employee_rec.SALARY < 8000 THEN
      UPDATE EMPLOYEES
      SET SALARY = SALARY * 1.03
      WHERE CURRENT OF salary_cursor;
    END IF;
  END LOOP;

  COMMIT;
END;
/

-- SALIDA ESPERADA (Obviamente los datos seran diferentes)
-- El empleado Steven es jefe del departamento Executive
-- El empleado Neena no es jefe de nada
-- El empleado Lex es jefe del departamento Executive
-- El empleado Alexander no es jefe de nada
-- El empleado Bruce no es jefe de nada
-- El empleado David no es jefe de nada
-- El número de empleados en el departamento 10 es 1
-- Empleado ST_CLERK: Diana
-- Empleado ST_CLERK: Ismael
-- Empleado ST_CLERK: Jose
-- Empleado ST_CLERK: John
-- Empleado ST_CLERK: Luis
-- Empleado ST_CLERK: Natalia
-- Empleado ST_CLERK: Winston
-- Empleado ST_CLERK: Alberto
