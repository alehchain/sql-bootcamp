/******************************************************************************
 SOLUÇÕES — MÓDULO 05
******************************************************************************/
SELECT DISTINCT status FROM clientes ORDER BY status;
SELECT DISTINCT forma_pagamento FROM pagamentos ORDER BY forma_pagamento;
SELECT DISTINCT cargo FROM funcionarios ORDER BY cargo;
SELECT DISTINCT categoria_id FROM produtos ORDER BY categoria_id;
SELECT DISTINCT quantidade_parcelas FROM pagamentos ORDER BY quantidade_parcelas;
SELECT DISTINCT cliente_id FROM pedidos ORDER BY cliente_id;
SELECT DISTINCT vendedor_id FROM pedidos ORDER BY vendedor_id NULLS LAST;
SELECT DISTINCT status, forma_pagamento FROM pagamentos ORDER BY status, forma_pagamento;
SELECT DISTINCT categoria_id FROM produtos WHERE preco > 300 ORDER BY categoria_id;
SELECT DISTINCT data_pedido FROM pedidos ORDER BY data_pedido;
SELECT DISTINCT categoria_id, fornecedor_id FROM produtos ORDER BY categoria_id, fornecedor_id;
SELECT DISTINCT status, vendedor_id FROM pedidos ORDER BY status, vendedor_id NULLS LAST;
SELECT DISTINCT preco - custo AS margem FROM produtos ORDER BY margem DESC;

-- Comparação com GROUP BY
SELECT DISTINCT status FROM pedidos ORDER BY status;
SELECT status FROM pedidos GROUP BY status ORDER BY status;

-- Desafio 2
SELECT DISTINCT cliente_id
FROM pedidos
WHERE status <> 'CANCELADO'
ORDER BY cliente_id;

-- Desafio 3
SELECT DISTINCT categoria_id, fornecedor_id
FROM produtos
WHERE ativo = 'S'
ORDER BY categoria_id, fornecedor_id;

-- Desafio 4
SELECT DISTINCT vendedor_id
FROM pedidos
ORDER BY vendedor_id NULLS LAST;

-- Apoio ao desafio 5
SELECT COUNT(*) AS total_linhas FROM pedidos;
SELECT COUNT(DISTINCT cliente_id) AS clientes_distintos FROM pedidos;
