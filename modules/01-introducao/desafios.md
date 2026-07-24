# Desafios — Introdução ao SQL

## Desafio 1 — Cartão de apresentação SQL

Crie uma única consulta utilizando `DUAL` que retorne as colunas:

- `nome`;
- `profissao`;
- `curso`;
- `data_inicio`;
- `objetivo`.

Exemplo de resultado:

| NOME | PROFISSAO | CURSO | DATA_INICIO | OBJETIVO |
|---|---|---|---|---|
| Alexandre | Analista de Sistemas | SQL Bootcamp | data atual | Evoluir em SQL |

Requisitos:

- utilize aliases claros;
- use `SYSDATE` para a data;
- formate o código em múltiplas linhas.

## Desafio 2 — Mini cadastro de tarefas

Crie uma tabela chamada `tarefas_estudo` com:

- identificador numérico;
- descrição obrigatória;
- prioridade entre 1 e 3;
- indicador de conclusão com `S` ou `N`;
- data de cadastro com valor padrão igual à data atual.

Depois:

1. insira três tarefas;
2. confirme os dados com `COMMIT`;
3. consulte todas as tarefas;
4. altere uma tarefa para concluída;
5. desfaça a alteração com `ROLLBACK`;
6. remova a tabela ao final.

## Desafio 3 — Mapa das categorias SQL

Crie um arquivo de anotações ou uma tabela Markdown contendo:

| Categoria | Finalidade | Comandos de exemplo |
|---|---|---|
| DQL |  |  |
| DML |  |  |
| DDL |  |  |
| TCL |  |  |
| DCL |  |  |

Preencha sem consultar a teoria e depois revise suas respostas.
