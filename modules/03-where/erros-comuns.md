# Erros comuns — WHERE

## ORA-00904

Coluna inexistente ou nome incorreto.

## ORA-01722

Conversão inválida para número, geralmente causada por tipos incompatíveis.

## ORA-01861

Literal de data incompatível com o formato esperado. Prefira o literal ANSI.

## Texto sem aspas

Errado: `WHERE status = ATIVO`  
Correto: `WHERE status = 'ATIVO'`

## NULL com igualdade

Errado: `WHERE telefone = NULL`  
Correto: `WHERE telefone IS NULL`

## AND e OR sem parênteses

Pode retornar linhas diferentes da regra pretendida.
