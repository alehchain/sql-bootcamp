# Guia do Oracle Live SQL

## O que é

O Oracle Live SQL é um ambiente gratuito executado no navegador. Ele permite criar tabelas, inserir dados e executar comandos Oracle SQL e PL/SQL sem instalação local.

## Preparação

1. Crie uma conta Oracle gratuita.
2. Acesse o Oracle Live SQL.
3. Abra **SQL Worksheet**.
4. Cole um script por vez.
5. Clique em **Run Script** para executar várias instruções.
6. Clique em **Run Statement** para executar apenas a instrução selecionada.

## Ordem de execução

```text
00-drop-objects.sql   opcional
01-schema.sql
02-sequences.sql
03-seed-data.sql
04-views.sql
05-indexes.sql
06-validation.sql
```

## Observações

- O Oracle Live SQL pode encerrar sessões inativas.
- Objetos permanecem associados ao workspace da conta, mas podem ser removidos.
- Comandos administrativos que exigem privilégios elevados podem não estar disponíveis.
- Utilize `/` após blocos PL/SQL quando executar como script.

## Diagnóstico básico

```sql
SELECT table_name
FROM user_tables
ORDER BY table_name;
```

```sql
SELECT object_name, object_type, status
FROM user_objects
ORDER BY object_type, object_name;
```
