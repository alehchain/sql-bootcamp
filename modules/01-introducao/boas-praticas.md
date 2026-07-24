# Boas práticas — Introdução ao SQL

## 1. Escreva palavras-chave em maiúsculas

```sql
SELECT nome
FROM clientes
WHERE ativo = 'S';
```

Isso não é obrigatório, mas melhora a leitura.

## 2. Coloque cláusulas principais em linhas separadas

Evite:

```sql
SELECT nome, email FROM clientes WHERE ativo = 'S' ORDER BY nome;
```

Prefira:

```sql
SELECT
    nome,
    email
FROM clientes
WHERE ativo = 'S'
ORDER BY nome;
```

## 3. Utilize aliases descritivos

```sql
SELECT SYSDATE AS data_execucao
FROM dual;
```

## 4. Evite alterar dados sem filtro

Antes de executar:

```sql
UPDATE clientes
SET ativo = 'N';
```

confirme se realmente deseja alterar todos os registros.

Quando a alteração deve atingir apenas parte dos dados, use `WHERE`:

```sql
UPDATE clientes
SET ativo = 'N'
WHERE id_cliente = 10;
```

## 5. Consulte antes de alterar

Uma prática segura é testar primeiro a condição:

```sql
SELECT *
FROM clientes
WHERE id_cliente = 10;
```

Depois reutilize a mesma condição no `UPDATE` ou `DELETE`.

## 6. Entenda o momento do COMMIT

`COMMIT` confirma alterações da transação. Antes de executá-lo:

- revise os registros afetados;
- confirme o filtro;
- valide os valores novos;
- evite rodar comandos destrutivos por impulso.

## 7. Use comentários com propósito

Comentários devem explicar contexto, regra ou motivo, e não apenas repetir o comando.

```sql
-- Clientes inativos são desconsiderados no relatório mensal.
SELECT *
FROM clientes
WHERE ativo = 'S';
```

## 8. Não utilize nomes confusos

Prefira:

```text
id_cliente
valor_total
 data_cadastro
```

Evite nomes genéricos como:

```text
campo1
valor
x
```

## 9. Mantenha scripts reproduzíveis

Um bom script de estudo deve informar:

- o objetivo;
- a ordem de execução;
- objetos criados;
- dependências;
- como limpar o ambiente.

## 10. Leia a mensagem completa do Oracle

Não ignore o código `ORA-`. Ele é a principal pista para encontrar o problema.
