SELECT NAZWISKO, PLACA_POD FROM PRACOWNICY ORDER BY PLACA_POD DESC FETCH FIRST 3 ROWS ONLY;

SELECT T.nazwisko, T.pensja
FROM (SELECT nazwisko, placa_pod AS pensja FROM pracownicy ORDER BY pensja DESC) T
WHERE ROWNUM <= 3;

SELECT NAZWISKO, PLACA_POD FROM PRACOWNICY ORDER BY PLACA_POD DESC OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY; 

SELECT T.nazwisko, T.pensja
FROM (SELECT nazwisko, placa_pod AS pensja FROM pracownicy ORDER BY pensja DESC OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY) T
WHERE ROWNUM<=10;

WITH
    PIOTROWO AS (SELECT ID_ZESP, NAZWA, ADRES FROM ZESPOLY WHERE ADRES LIKE 'PIOTROWO 3A'),
    ASYSTENCI AS (SELECT NAZWISKO, ETAT, ID_ZESP FROM PRACOWNICY WHERE ETAT LIKE 'ASYSTENT')
    
SELECT * FROM  ASYSTENCI NATURAL JOIN PIOTROWO;

WITH
    podwladni (id_prac, id_szefa, nazwisko, poziom) AS
    -- definicja korzenia hierarchii
    (SELECT id_prac, id_szefa, nazwisko, 1 FROM pracownicy WHERE id_prac = 130
        UNION ALL
    -- rekurencyjna definicja ni¿szych poziomów
    SELECT p.id_prac, p.id_szefa, p.nazwisko, poziom+1 FROM podwladni s JOIN pracownicy p ON s.id_prac = p.id_szefa)
-- wskazanie sposobu przeszukiwania hierarchii i sortowania rekordów-dzieci
    SEARCH DEPTH FIRST BY nazwisko SET porzadek_potomkow
SELECT  nazwisko, poziom
FROM podwladni
ORDER BY porzadek_potomkow;

SELECT  nazwisko, LEVEL AS poziom
FROM pracownicy
CONNECT BY id_szefa = PRIOR id_prac
START WITH nazwisko = 'BRZEZINSKI'
ORDER SIBLINGS BY nazwisko;

WITH
    podwladni (id_prac, id_szefa, nazwisko, poziom) AS
    -- definicja korzenia hierarchii
    (SELECT id_prac, id_szefa, nazwisko, 1 FROM pracownicy WHERE id_prac = 130
        UNION ALL
    -- rekurencyjna definicja ni¿szych poziomów
    SELECT p.id_prac, p.id_szefa, p.nazwisko, poziom+1 FROM podwladni s JOIN pracownicy p ON s.id_prac = p.id_szefa)
-- wskazanie sposobu przeszukiwania hierarchii i sortowania rekordów-dzieci
    SEARCH DEPTH FIRST BY nazwisko SET porzadek_potomkow
SELECT  LPAD(nazwisko, LENGTH(NAZWISKO)+POZIOM, ' '), poziom
FROM podwladni
ORDER BY porzadek_potomkow;

SELECT LPAD(nazwisko, LENGTH(NAZWISKO)+LEVEL, ' '), LEVEL AS poziom
FROM pracownicy
CONNECT BY id_szefa = PRIOR id_prac
START WITH nazwisko = 'BRZEZINSKI'
ORDER SIBLINGS BY nazwisko;

