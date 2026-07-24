# Erros comuns — Introdução ao SQL

## 1. ORA-00942: table or view does not exist

Exemplo:

```sql
SELECT *
FROM cliente;
```

Possíveis causas:

- a tabela se chama `CLIENTES`, e não `CLIENTE`;
- o script de criação ainda não foi executado;
- a tabela pertence a outro schema;
- o usuário não possui permissão.

## 2. ORA-00904: invalid identifier

Exemplo:

```sql
SELECT nome_completo
FROM clientes;
```

O nome da coluna pode estar incorreto ou não existir.

Verifique a estrutura da tabela e a ortografia.

## 3. ORA-00933: SQL command not properly ended

Pode ocorrer por sintaxe incompatível ou comando mal finalizado.

Exemplo incompatível com determinadas versões do Oracle:

```sql
SELECT *
FROM produtos
LIMIT 5;
```

No Oracle moderno, utilize:

```sql
SELECT *
FROM produtos
FETCH FIRST 5 ROWS ONLY;
```

## 4. ORA-00936: missing expression

Exemplo:

```sql
SELECT
FROM clientes;
```

Falta informar o que deve ser selecionado.

## 5. ORA-00917: missing comma

Exemplo:

```sql
SELECT nome email
FROM clientes;
```

Nesse caso, o Oracle pode interpretar `email` como alias. Em listas maiores, a ausência de vírgula frequentemente gera erro ou resultado diferente do esperado.

Forma correta para duas colunas:

```sql
SELECT nome, email
FROM clientes;
```

## 6. Usar `= NULL`

Incorreto:

```sql
WHERE email = NULL
```

Correto:

```sql
WHERE email IS NULL
```

## 7. Esquecer aspas em texto

Incorreto:

```sql
SELECT SQL Bootcamp
FROM dual;
```

Correto:

```sql
SELECT 'SQL Bootcamp'
FROM dual;
```

## 8. Utilizar aspas simples em nome de coluna

```sql
SELECT 'nome'
FROM clientes;
```

Esse comando retorna o texto literal `nome`, e não o conteúdo da coluna.

Para consultar a coluna:

```sql
SELECT nome
FROM clientes;
```

## 9. Executar UPDATE ou DELETE sem WHERE

```sql
DELETE FROM clientes;
```

Esse comando tenta remover todos os registros.

Antes de executar comandos destrutivos, valide a condição usando `SELECT`.

## 10. Confundir DELETE, TRUNCATE e DROP

- `DELETE`: remove registros;
- `TRUNCATE`: remove todos os registros de forma estrutural e rápida;
- `DROP`: remove o objeto inteiro.

São comandos diferentes e devem ser utilizados com cuidado.
