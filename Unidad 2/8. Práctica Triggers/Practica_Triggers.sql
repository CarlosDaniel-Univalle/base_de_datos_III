--Carlos Daniel Menchaca Arauz

--EJERCICIO_1
CREATE OR REPLACE TRIGGER trg_before_delete_employees
BEFORE DELETE ON employees
FOR EACH ROW
BEGIN
  IF UPPER(:OLD.JOB_ID) LIKE '%CLERK%' THEN
    RAISE_APPLICATION_ERROR(-20001, 'No se puede eliminar un registro con JOB_ID relacionado con CLERK');
  END IF;
END;
/

--EJERCICIO_2
CREATE TABLE AUDITORIA (
  USUARIO VARCHAR2(50),
  FECHA DATE,
  SALARIO_ANTIGUO NUMBER,
  SALARIO_NUEVO NUMBER
);

--EJERCICIO_3
CREATE OR REPLACE TRIGGER trg_before_insert_regions
BEFORE INSERT ON regions
FOR EACH ROW
BEGIN
  INSERT INTO auditoria (usuario, fecha)
  VALUES (USER, SYSDATE);
END;
/

--EJERCICIO_4
CREATE OR REPLACE TRIGGER trg_before_update_salary
BEFORE UPDATE OF salary ON employees
FOR EACH ROW
BEGIN
  IF :NEW.salary < :OLD.salary THEN
    RAISE_APPLICATION_ERROR(-20002, 'No se puede bajar un salario');
  ELSE
    INSERT INTO auditoria (salario_antiguo, salario_nuevo)
    VALUES (:OLD.salary, :NEW.salary);
  END IF;
END;
/

--EJERCICIO_5
CREATE OR REPLACE TRIGGER trg_before_insert_departments
BEFORE INSERT ON departments
FOR EACH ROW
BEGIN
  IF :NEW.department_id IS NOT NULL THEN
    FOR existing_dept IN (SELECT 1 FROM departments WHERE department_id = :NEW.department_id) LOOP
      RAISE_APPLICATION_ERROR(-20003, 'El código de departamento ya existe');
    END LOOP;
  END IF;

  IF :NEW.location_id IS NULL THEN
    :NEW.location_id := 1700;
  END IF;

  IF :NEW.manager_id IS NULL THEN
    :NEW.manager_id := 200;
  END IF;
END;
/
