DECLARE
  TYPE EmployeeRecord IS RECORD (
    NAME VARCHAR2(100),
    SAL EMPLOYEES.SALARY%TYPE,
    DEPT_CODE EMPLOYEES.DEPARTMENT_ID%TYPE
  );
  emp_info EmployeeRecord;
  TYPE EmployeeCollection IS TABLE OF EmployeeRecord;
  emp_collection EmployeeCollection := EmployeeCollection();
BEGIN
  FOR i IN 100..206 LOOP
    SELECT FIRST_NAME || ' ' || LAST_NAME, SALARY, DEPARTMENT_ID
    INTO emp_info.NAME, emp_info.SAL, emp_info.DEPT_CODE
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = i;
    emp_collection.extend;
    emp_collection(emp_collection.count) := emp_info;
  END LOOP;

  FOR i IN 1..emp_collection.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE('Name: ' || emp_collection(i).NAME || ', Salary: ' || emp_collection(i).SAL || ', Department: ' || emp_collection(i).DEPT_CODE);
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('First employee: ' || emp_collection(1).NAME);
  DBMS_OUTPUT.PUT_LINE('Last employee: ' || emp_collection(emp_collection.LAST).NAME);
  DBMS_OUTPUT.PUT_LINE('Number of employees: ' || emp_collection.COUNT);

  FOR i IN REVERSE emp_collection.FIRST..emp_collection.LAST LOOP
    IF emp_collection(i).SAL < 700 THEN
      emp_collection.DELETE(i);
    END IF;
  END LOOP;

  FOR i IN 1..emp_collection.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE('Name: ' || emp_collection(i).NAME || ', Salary: ' || emp_collection(i).SAL || ', Department: ' || emp_collection(i).DEPT_CODE);
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('Number of employees after deletion: ' || emp_collection.COUNT);
END;
