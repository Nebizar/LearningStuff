SET SERVEROUTPUT ON;

DECLARE
    nazwisko_v PRACOWNICY.NAZWISKO%TYPE;
    etat_v PRACOWNICY.ETAT%TYPE;
    placa_v PRACOWNICY.PLACA_POD%TYPE;
BEGIN
    SELECT NAZWISKO, ETAT INTO nazwisko_v, etat_v FROM PRACOWNICY ORDER BY PLACA_POD DESC FETCH FIRST 1 ROWS ONLY;
    DBMS_OUTPUT.PUT_LINE('Najlepiej zarabia pracownik '||nazwisko_v);
    DBMS_OUTPUT.PUT_LINE('Pracuje on jako '||etat_v);
    COMMIT;
END;

DECLARE
    CURSOR prac_c IS
        SELECT NAZWISKO, ZATRUDNIONY FROM PRACOWNICY WHERE ETAT='ASYSTENT';
    nazwisko_v PRACOWNICY.NAZWISKO%TYPE;
    data_v PRACOWNICY.ZATRUDNIONY%TYPE;
BEGIN
    OPEN prac_c;
    LOOP
        FETCH prac_c INTO nazwisko_v, data_v;
        EXIT WHEN prac_c%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(nazwisko_v || ' pracuje od ' || data_v);
    END LOOP;
    CLOSE prac_c;
    COMMIT;
END;

DECLARE
    CURSOR PRAC_C (P_ETAT PRACOWNICY.ETAT%TYPE DEFAULT 'DYREKTOR') IS
        SELECT * FROM PRACOWNICY WHERE ETAT=P_ETAT;
    V_NAZWISKO PRACOWNICY.NAZWISKO%TYPE;
    V_ETAT PRACOWNICY.ETAT%TYPE := &TEKST;
BEGIN
    FOR R_PRAC IN PRAC_C(V_ETAT) LOOP
        DBMS_OUTPUT.PUT_LINE(R_PRAC.NAZWISKO);
    END LOOP;
    COMMIT;
END;


