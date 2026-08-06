/******************************************************************************
 MÓDULO 04 — ORDER BY
******************************************************************************/

SELECT cliente_id, nome FROM clientes ORDER BY nome ASC;
SELECT produto_id, nome, preco FROM produtos ORDER BY preco DESC;
SELECT pedido_id, data_pedido, status FROM pedidos ORDER BY data_pedido DESC;
SELECT pedido_id, data_pedido FROM pedidos ORDER BY data_pedido DESC, pedido_id DESC;
SELECT cliente_id, nome, status FROM clientes ORDER BY status, nome;
SELECT produto_id, categoria_id, nome, preco FROM produtos ORDER BY categoria_id, preco DESC;
SELECT produto_id, nome, preco - custo AS margem FROM produtos ORDER BY margem DESC;
SELECT nome, preco FROM produtos ORDER BY 2 DESC;
SELECT cliente_id, nome, telefone FROM clientes ORDER BY telefone ASC NULLS LAST;
SELECT cliente_id, nome, data_nascimento FROM clientes ORDER BY data_nascimento ASC NULLS FIRST;
SELECT pedido_id, status, valor_total FROM pedidos WHERE status <> 'CANCELADO' ORDER BY valor_total DESC;
SELECT funcionario_id, nome, salario FROM funcionarios ORDER BY salario DESC;
SELECT produto_id, quantidade_atual, quantidade_minima,
       quantidade_atual - quantidade_minima AS saldo_minimo
FROM estoque
ORDER BY saldo_minimo ASC;
SELECT pagamento_id, status, valor FROM pagamentos ORDER BY status, valor DESC;
SELECT transportadora_id, nome, prazo_medio_dias FROM transportadoras ORDER BY prazo_medio_dias;
SELECT cliente_id, nome, data_cadastro FROM clientes ORDER BY data_cadastro DESC, cliente_id DESC;
