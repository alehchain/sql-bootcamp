# Exercícios — Introdução ao SQL

> Tente resolver todos os exercícios antes de abrir `solucoes.sql`.

## Nível fácil

### Exercício 1 — Conceitos fundamentais

Explique com suas palavras:

1. o que é um banco de dados;
2. o que é um SGBD;
3. o que é uma tabela;
4. o que é uma coluna;
5. o que é um registro.

**Objetivo:** consolidar o vocabulário básico.

---

### Exercício 2 — Primeiro comando

Escreva uma consulta Oracle que retorne o texto:

```text
Estou aprendendo SQL
```

Use o alias `mensagem`.

**Objetivo:** utilizar `SELECT`, alias e `DUAL`.

---

### Exercício 3 — Cálculo simples

Retorne o resultado de `25 + 17` com o alias `resultado`.

**Objetivo:** avaliar expressões numéricas.

---

### Exercício 4 — Data atual

Retorne a data atual do banco com o alias `data_execucao`.

**Objetivo:** utilizar `SYSDATE`.

---

### Exercício 5 — Concatenação

Retorne a frase `Oracle SQL` concatenando duas strings.

**Objetivo:** utilizar o operador `||`.

## Nível médio

### Exercício 6 — Classificação de comandos

Classifique cada comando como DQL, DML, DDL, TCL ou DCL:

1. `SELECT`;
2. `INSERT`;
3. `CREATE TABLE`;
4. `COMMIT`;
5. `GRANT`;
6. `UPDATE`;
7. `ROLLBACK`;
8. `DROP TABLE`.

---

### Exercício 7 — Tabela de estudo

Crie a tabela `anotacoes_sql` com:

| Coluna | Tipo | Regra |
|---|---|---|
| `id_anotacao` | `NUMBER` | chave primária |
| `titulo` | `VARCHAR2(100)` | obrigatório |
| `conteudo` | `VARCHAR2(500)` | opcional |
| `concluida` | `CHAR(1)` | obrigatório, padrão `N`, aceita apenas `S` ou `N` |

**Objetivo:** praticar uma estrutura DDL simples.

---

### Exercício 8 — Inserção

Insira na tabela `anotacoes_sql` o registro:

- ID: `1`;
- título: `Revisar conceitos de SQL`;
- conteúdo: `Estudar DQL, DML, DDL, TCL e DCL`;
- concluída: `N`.

Depois execute `COMMIT`.

---

### Exercício 9 — Consulta

Consulte todas as colunas de `anotacoes_sql`.

---

### Exercício 10 — Alteração e rollback

Altere `concluida` para `S` no registro de ID `1`.

Antes de confirmar, execute uma consulta para visualizar a alteração. Em seguida, execute `ROLLBACK` e consulte novamente.

**Objetivo:** observar o efeito de uma transação.

## Nível difícil

### Exercício 11 — Corrija a consulta

O comando abaixo possui erros:

```sql
SELECT 'Bootcamp SQL' mensagem
FORM dual
```

Corrija-o.

---

### Exercício 12 — Identifique o problema

Por que esta condição não é adequada para verificar ausência de valor?

```sql
WHERE email = NULL
```

Escreva a forma correta.

---

### Exercício 13 — Explique a diferença

Explique a diferença entre:

```sql
DELETE FROM anotacoes_sql;
```

```sql
DROP TABLE anotacoes_sql;
```

---

### Exercício 14 — Segurança

Explique por que executar um `UPDATE` sem cláusula `WHERE` pode ser perigoso.

---

### Exercício 15 — Limpeza do laboratório

Remova a tabela `anotacoes_sql` ao final dos exercícios.

**Objetivo:** utilizar `DROP TABLE` conscientemente.
