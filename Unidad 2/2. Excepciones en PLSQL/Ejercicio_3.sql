DECLARE
  v_salary NUMBER := 1000;

BEGIN
  SELECT v_salary / 0 INTO v_result FROM dual;
  
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ', ' || SQLERRM);
END;