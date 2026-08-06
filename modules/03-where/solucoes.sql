/******************************************************************************
 SOLUÇÕES — MÓDULO 03
******************************************************************************/

SELECT cliente_id, nome, status FROM clientes WHERE status = 'ATIVO';
SELECT produto_id, nome, preco FROM produtos WHERE preco < 200;
SELECT pedido_id, data_pedido, status FROM pedidos WHERE status = 'ENTREGUE';
SELECT funcionario_id, nome, salario FROM funcionarios WHERE salario >= 5000;
SELECT produto_id, nome, categoria_id, preco FROM produtos WHERE categoria_id = 2;
SELECT produto_id, nome, preco FROM produtos WHERE ativo = 'S' AND preco > 1000;
SELECT pedido_id, data_pedido FROM pedidos WHERE data_pedido >= DATE '2025-06-01';
SELECT cliente_id, nome, data_cadastro FROM clientes WHERE status = 'ATIVO' AND data_cadastro >= DATE '2025-03-01';
SELECT pagamento_id, pedido_id, quantidade_parcelas FROM pagamentos WHERE status = 'APROVADO' AND quantidade_parcelas > 1;
SELECT produto_id, quantidade_atual, quantidade_minima FROM estoque WHERE quantidade_atual <= quantidade_minima;
SELECT produto_id, nome, categoria_id FROM produtos WHERE (categoria_id = 1 OR categoria_id = 2) AND ativo = 'S';
SELECT produto_id, nome, preco - custo AS margem FROM produtos WHERE preco - custo >= 150;
SELECT pedido_id, status, valor_total FROM pedidos WHERE status <> 'CANCELADO' AND valor_total > 500;
SELECT funcionario_id, nome, cargo FROM funcionarios WHERE ativo = 'S' AND cargo <> 'Vendedor' AND cargo <> 'Vendedora';

-- Desafio 1
SELECT produto_id, nome, preco, custo, preco - custo AS margem
FROM produtos
WHERE ativo = 'S' AND preco >= 500;

-- Desafio 2
SELECT cliente_id, nome, email, data_cadastro
FROM clientes
WHERE status = 'ATIVO' AND data_cadastro >= DATE '2025-02-01';

-- Desafio 3
SELECT pedido_id, status, valor_total
FROM pedidos
WHERE (status = 'ABERTO' OR status = 'ENVIADO')
  AND valor_total >= 280;

-- Desafio 4
SELECT produto_id, quantidade_atual, quantidade_minima,
       quantidade_minima - quantidade_atual AS faltante_para_minimo
FROM estoque
WHERE quantidade_atual <= quantidade_minima;

-- Desafio 5
SELECT pagamento_id, pedido_id, status, data_pagamento
FROM pagamentos
WHERE status <> 'APROVADO' OR data_pagamento IS NULL;
