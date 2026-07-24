-- =============================================================
-- SQL Bootcamp
-- Módulo 01: Soluções dos exercícios práticos
-- Consulte somente depois de tentar resolver.
-- =============================================================

-- Exercício 2
SELECT 'Estou aprendendo SQL' AS mensagem
FROM dual;

-- Exercício 3
SELECT 25 + 17 AS resultado
FROM dual;

-- Exercício 4
SELECT SYSDATE AS data_execucao
FROM dual;

-- Exercício 5
SELECT 'Oracle' || ' ' || 'SQL' AS tecnologia
FROM dual;

-- Exercício 7
CREATE TABLE anotacoes_sql (
    id_anotacao NUMBER        NOT NULL,
    titulo      VARCHAR2(100) NOT NULL,
    conteudo    VARCHAR2(500),
    concluida   CHAR(1)       DEFAULT 'N' NOT NULL,
    CONSTRAINT pk_anotacoes_sql PRIMARY KEY (id_anotacao),
    CONSTRAINT ck_anotacoes_sql_concluida CHECK (concluida IN ('S', 'N'))
);

-- Exercício 8
INSERT INTO anotacoes_sql (
    id_anotacao,
    titulo,
    conteudo,
    concluida
) VALUES (
    1,
    'Revisar conceitos de SQL',
    'Estudar DQL, DML, DDL, TCL e DCL',
    'N'
);

COMMIT;

-- Exercício 9
SELECT
    id_anotacao,
    titulo,
    conteudo,
    concluida
FROM anotacoes_sql;

-- Exercício 10
UPDATE anotacoes_sql
SET concluida = 'S'
WHERE id_anotacao = 1;

SELECT
    id_anotacao,
    titulo,
    concluida
FROM anotacoes_sql;

ROLLBACK;

SELECT
    id_anotacao,
    titulo,
    concluida
FROM anotacoes_sql;

-- Exercício 11
SELECT 'Bootcamp SQL' AS mensagem
FROM dual;

-- Exercício 12
-- Para valores nulos, utilize IS NULL.
-- Exemplo:
-- SELECT * FROM clientes WHERE email IS NULL;

-- Exercício 15
DROP TABLE anotacoes_sql PURGE;
