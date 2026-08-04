# Módulo 02 — SELECT

> **Nível:** Iniciante  
> **Tempo estimado:** 3 horas  
> **Banco de dados:** Oracle Database (Oracle Live SQL)

## Sobre este módulo

O comando `SELECT` é utilizado para consultar informações armazenadas em tabelas e views. Ele será usado em praticamente todos os módulos seguintes do Bootcamp SQL.

Neste módulo você aprenderá a selecionar todas as colunas, escolher colunas específicas, utilizar aliases, criar expressões calculadas e executar consultas no Oracle Live SQL.

## Objetivos

Ao concluir este módulo, você será capaz de:

- consultar dados com `SELECT`;
- selecionar todas as colunas de uma tabela;
- retornar somente as colunas necessárias;
- utilizar aliases para melhorar a apresentação do resultado;
- criar colunas calculadas;
- concatenar textos;
- utilizar a tabela `DUAL` do Oracle;
- interpretar erros básicos de sintaxe.

## Preparação do ambiente

Antes de iniciar os exemplos e exercícios, execute o arquivo:

[`database/setup.sql`](../../database/setup.sql)

No Oracle Live SQL:

1. Faça login.
2. Abra uma **SQL Worksheet**.
3. Copie todo o conteúdo de `database/setup.sql`.
4. Cole no editor.
5. Execute como script completo.
6. Confirme a mensagem `Ambiente do SQL Bootcamp criado com sucesso!`.

O script cria as tabelas, os relacionamentos e os dados fictícios da Loja Virtual utilizados durante o curso.

## Validação rápida

Depois do setup, execute:

```sql
SELECT COUNT(*) AS quantidade_clientes
FROM clientes;

SELECT COUNT(*) AS quantidade_produtos
FROM produtos;
```

Resultados esperados:

- 8 clientes;
- 10 produtos.

## Como estudar este módulo

Siga esta ordem:

1. Leia [`teoria.md`](teoria.md).
2. Execute cada consulta de [`exemplos.sql`](exemplos.sql).
3. Altere os exemplos e observe os resultados.
4. Resolva [`exercicios.md`](exercicios.md) sem consultar as respostas.
5. Compare suas consultas com [`solucoes.sql`](solucoes.sql).
6. Faça os desafios de [`desafios.md`](desafios.md).
7. Revise [`boas-praticas.md`](boas-praticas.md) e [`erros-comuns.md`](erros-comuns.md).
8. Finalize com [`quiz.md`](quiz.md).

## Arquivos do módulo

| Arquivo | Finalidade |
|---|---|
| [`teoria.md`](teoria.md) | Fundamentos e sintaxe do `SELECT` |
| [`exemplos.sql`](exemplos.sql) | Consultas prontas para execução |
| [`exercicios.md`](exercicios.md) | Atividades divididas por dificuldade |
| [`desafios.md`](desafios.md) | Situações práticas da Loja Virtual |
| [`solucoes.sql`](solucoes.sql) | Respostas comentadas |
| [`boas-praticas.md`](boas-praticas.md) | Recomendações de escrita e manutenção |
| [`erros-comuns.md`](erros-comuns.md) | Erros frequentes e suas correções |
| [`quiz.md`](quiz.md) | Revisão dos conceitos |
| [`referencias.md`](referencias.md) | Materiais complementares |

## Primeiro teste

```sql
SELECT cliente_id,
       nome,
       email
FROM clientes;
```

Depois teste uma coluna calculada:

```sql
SELECT produto_id,
       nome,
       preco,
       preco * 1.10 AS preco_reajustado
FROM produtos;
```

## Checklist

- [ ] Preparei o banco com `database/setup.sql`.
- [ ] Consultei todos os registros de uma tabela.
- [ ] Selecionei apenas as colunas necessárias.
- [ ] Utilizei aliases.
- [ ] Criei uma coluna calculada.
- [ ] Executei consultas com `DUAL`.
- [ ] Resolvi os exercícios sem consultar as soluções.

## Próximo módulo

➡️ [Módulo 03 — WHERE](../03-where)
