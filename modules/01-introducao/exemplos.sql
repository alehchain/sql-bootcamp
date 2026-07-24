-- =============================================================
-- SQL Bootcamp
-- Módulo 01: Introdução ao SQL
-- Ambiente: Oracle Live SQL
-- =============================================================

-- 01. Exibindo uma mensagem
SELECT 'Olá, SQL Bootcamp!' AS mensagem
FROM dual;

-- 02. Operação matemática
SELECT 10 + 5 AS soma
FROM dual;

-- 03. Mais de uma expressão na mesma consulta
SELECT
    10 + 5 AS soma,
    10 - 5 AS subtracao,
    10 * 5 AS multiplicacao,
    10 / 5 AS divisao
FROM dual;

-- 04. Data e hora atuais do banco
SELECT SYSDATE AS data_atual
FROM dual;

-- 05. Timestamp atual
SELECT SYSTIMESTAMP AS timestamp_atual
FROM dual;

-- 06. Texto em letras maiúsculas
SELECT UPPER('sql bootcamp') AS texto_maiusculo
FROM dual;

-- 07. Texto em letras minúsculas
SELECT LOWER('ORACLE DATABASE') AS texto_minusculo
FROM dual;

-- 08. Concatenando textos no Oracle
SELECT 'SQL' || ' ' || 'Bootcamp' AS nome_curso
FROM dual;

-- 09. Criando uma tabela simples de laboratório
CREATE TABLE laboratorio_modulo_01 (
    id_registro NUMBER       NOT NULL,
    descricao  VARCHAR2(100) NOT NULL,
    ativo      CHAR(1)       DEFAULT 'S' NOT NULL,
    CONSTRAINT pk_laboratorio_modulo_01 PRIMARY KEY (id_registro),
    CONSTRAINT ck_laboratorio_modulo_01_ativo CHECK (ativo IN ('S', 'N'))
);

-- 10. Inserindo um registro
INSERT INTO laboratorio_modulo_01 (
    id_registro,
    descricao,
    ativo
) VALUES (
    1,
    'Primeiro registro do Bootcamp',
    'S'
);

-- 11. Confirmando a transação
COMMIT;

-- 12. Consultando o registro
SELECT
    id_registro,
    descricao,
    ativo
FROM laboratorio_modulo_01;

-- 13. Alterando o registro
UPDATE laboratorio_modulo_01
SET descricao = 'Registro atualizado no Módulo 01'
WHERE id_registro = 1;

-- 14. Visualizando a alteração antes do COMMIT
SELECT
    id_registro,
    descricao,
    ativo
FROM laboratorio_modulo_01;

-- 15. Desfazendo a alteração ainda não confirmada
ROLLBACK;

-- 16. Confirmando que o valor anterior foi restaurado
SELECT
    id_registro,
    descricao,
    ativo
FROM laboratorio_modulo_01;

-- 17. Excluindo o registro
DELETE FROM laboratorio_modulo_01
WHERE id_registro = 1;

-- 18. Desfazendo a exclusão
ROLLBACK;

-- 19. O registro continua existente
SELECT
    id_registro,
    descricao,
    ativo
FROM laboratorio_modulo_01;

-- 20. Removendo a tabela de laboratório
DROP TABLE laboratorio_modulo_01 PURGE;
