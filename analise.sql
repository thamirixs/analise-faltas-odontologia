-- Execute em SQLite para reproduzir os 100 agendamentos fictícios.
CREATE TABLE IF NOT EXISTS agendamentos (
 id INTEGER PRIMARY KEY, data_consulta TEXT NOT NULL, turno TEXT NOT NULL,
 especialidade TEXT NOT NULL, status TEXT NOT NULL
);
WITH RECURSIVE numeros(n) AS (
 SELECT 1 UNION ALL SELECT n + 1 FROM numeros WHERE n < 100
)
INSERT OR IGNORE INTO agendamentos
SELECT n, date('2026-10-01', '+' || ((n-1)/4) || ' days'),
 CASE WHEN n % 4 IN (1,2) THEN 'Manhã' ELSE 'Tarde' END,
 CASE n % 3 WHEN 0 THEN 'Clínica geral' WHEN 1 THEN 'Ortodontia' ELSE 'Endodontia' END,
 CASE WHEN n % 10 IN (0,3) THEN 'Faltou' ELSE 'Compareceu' END
FROM numeros;

SELECT turno, especialidade, COUNT(*) AS total_agendamentos,
       SUM(CASE WHEN status = 'Faltou' THEN 1 ELSE 0 END) AS total_faltas
FROM agendamentos
GROUP BY turno, especialidade
ORDER BY turno, especialidade;
