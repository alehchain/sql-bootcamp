# 06 — Estrutura do Banco e PL/SQL

Este módulo concentra DDL, constraints, views e objetos Oracle que antes ocupavam vários módulos separados: `CREATE TABLE`, `ALTER TABLE`, constraints, views, materialized views, indexes, sequences, synonyms, procedures, functions, packages e triggers.

O objetivo é conhecer os recursos sem entrar em administração de banco ou tuning de performance.

## 1. CREATE TABLE e tipos

```sql
CREATE TABLE cupons (
    cupom_id      NUMBER        PRIMARY KEY,
    codigo        VARCHAR2(30)  NOT NULL,
    percentual    NUMBER(5,2),
    ativo         CHAR(1)       DEFAULT 'S',
    criado_em     DATE          DEFAULT SYSDATE
);
```

Tipos comuns no Oracle:

- `NUMBER(p,s)` para números.
- `VARCHAR2(n)` para texto variável.
- `CHAR(n)` para texto de tamanho fixo.
- `DATE` para data e hora.
- `TIMESTAMP` quando maior precisão de tempo é necessária.

## 2. Constraints

```sql
CREATE TABLE favoritos (
    favorito_id NUMBER PRIMARY KEY,
    cliente_id  NUMBER NOT NULL,
    produto_id  NUMBER NOT NULL,
    criado_em   DATE DEFAULT SYSDATE,
    CONSTRAINT fk_fav_cliente
        FOREIGN KEY (cliente_id)
        REFERENCES clientes(cliente_id),
    CONSTRAINT fk_fav_produto
        FOREIGN KEY (produto_id)
        REFERENCES produtos(produto_id),
    CONSTRAINT uk_fav_cliente_produto
        UNIQUE (cliente_id, produto_id)
);
```

Principais constraints:

- `PRIMARY KEY`: identifica uma linha.
- `FOREIGN KEY`: garante relacionamento.
- `NOT NULL`: exige valor.
- `UNIQUE`: evita duplicidade.
- `CHECK`: valida regra simples.

Exemplo:

```sql
CONSTRAINT ck_cupons_percentual
CHECK (percentual BETWEEN 0 AND 100)
```

## 3. ALTER TABLE

```sql
ALTER TABLE cupons
ADD validade DATE;

ALTER TABLE cupons
ADD CONSTRAINT uk_cupons_codigo UNIQUE (codigo);
```

Remoção:

```sql
ALTER TABLE cupons
DROP COLUMN validade;
```

## 4. Sequences

Sequence é comum em versões do Oracle e modelos que não usam identity:

```sql
CREATE SEQUENCE seq_cupons
START WITH 1
INCREMENT BY 1;
```

Uso:

```sql
INSERT INTO cupons (cupom_id, codigo, percentual)
VALUES (seq_cupons.NEXTVAL, 'SQL10', 10);
```

## 5. Views

Uma view encapsula uma consulta:

```sql
CREATE OR REPLACE VIEW vw_resumo_pedidos AS
SELECT
    p.pedido_id,
    c.nome AS cliente,
    p.data_pedido,
    p.status,
    p.valor_total
FROM pedidos p
JOIN clientes c
    ON c.cliente_id = p.cliente_id;
```

Consulta:

```sql
SELECT *
FROM vw_resumo_pedidos
WHERE status = 'PAGO';
```

### Materialized view

Materialized views armazenam fisicamente o resultado. Aqui basta conhecer a estrutura; estratégias de refresh e performance ficam fora do escopo.

```sql
CREATE MATERIALIZED VIEW mv_vendas_cliente
BUILD IMMEDIATE
REFRESH COMPLETE ON DEMAND
AS
SELECT cliente_id, SUM(valor_total) AS total
FROM pedidos
GROUP BY cliente_id;
```

## 6. Indexes

Um índice é uma estrutura auxiliar associada a colunas.

```sql
CREATE INDEX idx_pedidos_cliente
ON pedidos(cliente_id);
```

Neste bootcamp o assunto fica limitado à criação e ao conceito. Escolha de índices, planos de execução e tuning não fazem parte do currículo.

## 7. Synonyms

Um synonym cria um nome alternativo para um objeto:

```sql
CREATE SYNONYM resumo_pedidos
FOR vw_resumo_pedidos;
```

É um recurso específico do ecossistema Oracle; use conforme os padrões do ambiente.

## 8. Introdução a PL/SQL

PL/SQL adiciona blocos procedurais ao SQL Oracle.

```sql
DECLARE
    v_total NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_total
    FROM pedidos;

    DBMS_OUTPUT.PUT_LINE('Pedidos: ' || v_total);
END;
/
```

## 9. Procedures

```sql
CREATE OR REPLACE PROCEDURE reajustar_categoria (
    p_categoria_id IN NUMBER,
    p_percentual   IN NUMBER
) AS
BEGIN
    UPDATE produtos
    SET preco = preco * (1 + p_percentual / 100)
    WHERE categoria_id = p_categoria_id;
END;
/
```

Chamada:

```sql
BEGIN
    reajustar_categoria(1, 5);
END;
/
```

## 10. Functions

Functions retornam um valor:

```sql
CREATE OR REPLACE FUNCTION total_cliente (
    p_cliente_id IN NUMBER
) RETURN NUMBER AS
    v_total NUMBER;
BEGIN
    SELECT NVL(SUM(valor_total), 0)
    INTO v_total
    FROM pedidos
    WHERE cliente_id = p_cliente_id;

    RETURN v_total;
END;
/
```

Uso:

```sql
SELECT nome, total_cliente(cliente_id) AS total
FROM clientes;
```

## 11. Packages

Packages agrupam procedures, functions e outros elementos relacionados.

```sql
CREATE OR REPLACE PACKAGE pkg_clientes AS
    FUNCTION total_compras(p_cliente_id NUMBER) RETURN NUMBER;
END pkg_clientes;
/

CREATE OR REPLACE PACKAGE BODY pkg_clientes AS
    FUNCTION total_compras(p_cliente_id NUMBER) RETURN NUMBER AS
        v_total NUMBER;
    BEGIN
        SELECT NVL(SUM(valor_total), 0)
        INTO v_total
        FROM pedidos
        WHERE cliente_id = p_cliente_id;

        RETURN v_total;
    END;
END pkg_clientes;
/
```

## 12. Triggers

Triggers executam automaticamente diante de um evento.

```sql
CREATE OR REPLACE TRIGGER trg_produtos_data
BEFORE UPDATE ON produtos
FOR EACH ROW
BEGIN
    :NEW.data_atualizacao := SYSDATE;
END;
/
```

Use triggers com moderação: regras automáticas escondidas podem dificultar entendimento e manutenção. Quando a tabela do exemplo não possuir `data_atualizacao`, adapte ou crie a coluna antes.

## Boas práticas e erros comuns

- Dê nomes previsíveis às constraints.
- Defina tipos e tamanhos de acordo com o domínio.
- Não use trigger para lógica que deveria estar explícita na aplicação sem uma razão arquitetural.
- Mantenha procedures e functions pequenas e com responsabilidade clara.
- Não trate índices como “quanto mais, melhor”; tuning está fora do curso.
- Documente objetos Oracle específicos quando o projeto precisar ser portável.

## Exercícios

1. Crie uma tabela `cupons` com PK, código único, percentual entre 0 e 100 e flag `S/N`.
2. Crie uma sequence para `cupons`.
3. Adicione uma coluna `validade`.
4. Crie uma view com cliente, pedido, status e valor.
5. Crie uma function que retorne quantidade de pedidos de um cliente.
6. Crie uma procedure que desative produtos de uma categoria.
7. Explique quando escolher view comum em vez de materialized view.
8. Crie um package que agrupe as rotinas dos exercícios 5 e 6.

<details>
<summary>Ver soluções principais</summary>

```sql
-- 1
CREATE TABLE cupons (
    cupom_id    NUMBER PRIMARY KEY,
    codigo      VARCHAR2(30) NOT NULL,
    percentual NUMBER(5,2),
    ativo       CHAR(1) DEFAULT 'S' NOT NULL,
    CONSTRAINT uk_cupons_codigo UNIQUE (codigo),
    CONSTRAINT ck_cupons_percentual CHECK (percentual BETWEEN 0 AND 100),
    CONSTRAINT ck_cupons_ativo CHECK (ativo IN ('S', 'N'))
);

-- 2
CREATE SEQUENCE seq_cupons START WITH 1 INCREMENT BY 1;

-- 3
ALTER TABLE cupons ADD validade DATE;

-- 4
CREATE OR REPLACE VIEW vw_pedidos_clientes AS
SELECT c.cliente_id,
       c.nome,
       p.pedido_id,
       p.status,
       p.valor_total
FROM clientes c
JOIN pedidos p ON p.cliente_id = c.cliente_id;

-- 5
CREATE OR REPLACE FUNCTION qtd_pedidos_cliente (
    p_cliente_id NUMBER
) RETURN NUMBER AS
    v_qtd NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_qtd
    FROM pedidos
    WHERE cliente_id = p_cliente_id;

    RETURN v_qtd;
END;
/

-- 6
CREATE OR REPLACE PROCEDURE desativar_categoria (
    p_categoria_id NUMBER
) AS
BEGIN
    UPDATE produtos
    SET ativo = 'N'
    WHERE categoria_id = p_categoria_id;
END;
/

-- 8
CREATE OR REPLACE PACKAGE pkg_produtos_clientes AS
    FUNCTION qtd_pedidos_cliente(p_cliente_id NUMBER) RETURN NUMBER;
    PROCEDURE desativar_categoria(p_categoria_id NUMBER);
END pkg_produtos_clientes;
/
```

Para o exercício 7: use uma **view comum** quando quiser encapsular a consulta sem armazenar o resultado. Materialized view armazena o resultado e envolve decisões de atualização; aprofundamento desse comportamento fica fora deste bootcamp.

</details>

## Próximo módulo

Siga para [07 — Projeto Final](../07-projeto-final).
