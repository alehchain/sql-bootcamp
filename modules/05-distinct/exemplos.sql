/******************************************************************************
 MÓDULO 05 — DISTINCT
******************************************************************************/
SELECT DISTINCT status FROM clientes ORDER BY status;
SELECT DISTINCT categoria_id FROM produtos ORDER BY categoria_id;
SELECT DISTINCT fornecedor_id FROM produtos ORDER BY fornecedor_id;
SELECT DISTINCT status FROM pedidos ORDER BY status;
SELECT DISTINCT cliente_id FROM pedidos ORDER BY cliente_id;
SELECT DISTINCT vendedor_id FROM pedidos ORDER BY vendedor_id NULLS LAST;
SELECT DISTINCT forma_pagamento FROM pagamentos ORDER BY forma_pagamento;
SELECT DISTINCT status FROM pagamentos ORDER BY status;
SELECT DISTINCT status, forma_pagamento FROM pagamentos ORDER BY status, forma_pagamento;
SELECT DISTINCT quantidade_parcelas FROM pagamentos ORDER BY quantidade_parcelas;
SELECT DISTINCT cargo FROM funcionarios ORDER BY cargo;
SELECT DISTINCT prazo_medio_dias FROM transportadoras ORDER BY prazo_medio_dias;
SELECT DISTINCT cliente_id FROM pedidos WHERE status <> 'CANCELADO' ORDER BY cliente_id;
SELECT DISTINCT categoria_id FROM produtos WHERE preco > 300 ORDER BY categoria_id;
SELECT DISTINCT categoria_id, fornecedor_id FROM produtos ORDER BY categoria_id, fornecedor_id;
SELECT DISTINCT preco - custo AS margem FROM produtos ORDER BY margem DESC;
SELECT DISTINCT data_pedido FROM pedidos ORDER BY data_pedido;
SELECT DISTINCT status, vendedor_id FROM pedidos ORDER BY status, vendedor_id NULLS LAST;
