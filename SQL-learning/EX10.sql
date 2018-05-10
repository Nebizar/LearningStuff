CREATE OR REPLACE VIEW ASYSTENCI (ID, NAZWISKO, PLACA, STAZ_PRACY) AS
    SELECT ID_PRAC, NAZWISKO, PLACA_POD, 'LAT: '|| EXTRACT(YEAR FROM (CURRENT_DATE-ZATRUDNIONY) YEAR TO MONTH) || 'MIESIECY: ' || EXTRACT(MONTH FROM (CURRENT_DATE-ZATRUDNIONY) YEAR TO MONTH)
    FROM PRACOWNICY 
    WHERE ETAT='ASYSTENT';
    
SELECT * FROM ASYSTENCI ORDER BY NAZWISKO;

CREATE OR REPLACE VIEW PLACE(ID_ZESP, SREDNIA, MINIMUM, MAXIMUM, FUNDUSZ, L_PENSJI, L_DODATKOW) AS
    SELECT ID_ZESP, AVG(PLACA_POD+PLACA_DOD), MIN(PLACA_POD+PLACA_DOD), MAX(PLACA_POD+PLACA_DOD), SUM(PLACA_POD)+SUM(PLACA_DOD), COUNT(PLACA_POD), COUNT(PLACA_DOD) 
    FROM PRACOWNICY GROUP BY ID_ZESP;
    
SELECT * FROM PLACE;

SELECT P.NAZWISKO, P.PLACA_POD FROM  PRACOWNICY P JOIN PLACE PL USING(ID_ZESP) WHERE (P.PLACA_POD+P.PLACA_DOD)<PL.SREDNIA;

CREATE OR REPLACE VIEW PLACE_MINIMALNE (ID_PRAC, NAZWISKO, ETAT, PLACA_POD) AS
    SELECT ID_PRAC, NAZWISKO, ETAT, PLACA_POD
    FROM PRACOWNICY
    WHERE PLACA_POD<700
    WITH CHECK OPTION;
    
COMMIT;

--UPDATE PLACE_MINIMALNE SET PLACA_POD=800 WHERE NAZWISKO='HAPKE';

CREATE OR REPLACE VIEW PRAC_SZEF(ID_PRAC, ID_SZEFA, PRACOWNIK, ETAT, SZEF) AS
    SELECT P.ID_PRAC, P.ID_SZEFA, P.NAZWISKO, P.ETAT, S.NAZWISKO FROM PRACOWNICY P JOIN PRACOWNICY S ON(P.ID_SZEFA=S.ID_PRAC);
    
SELECT * FROM PRAC_SZEF;

CREATE OR REPLACE VIEW ZAROBKI(ID_PRAC, NAZWISKO, ETAT, PLACA_POD) AS
    SELECT P.ID_PRAC, P.NAZWISKO, P.ETAT, P.PLACA_POD 
    FROM PRACOWNICY P JOIN PRACOWNICY S ON(P.ID_SZEFA=S.ID_PRAC)
    WHERE P.PLACA_POD<S.PLACA_POD
    WITH CHECK OPTION;
    
SELECT * FROM ZAROBKI;

COMMIT;

SELECT * FROM USER_UPDATABLE_COLUMNS WHERE TABLE_NAME='PRAC_SZEF';


