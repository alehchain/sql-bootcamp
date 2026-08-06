/******************************************************************************
 SOLUÇÕES — MÓDULO 04
******************************************************************************/
SELECT cliente_id, nome FROM clientes ORDER BY nome;
SELECT produto_id, nome, preco FROM produtos ORDER BY preco;
SELECT produto_id, nome, preco FROM produtos ORDER BY preco DESC;
SELECT funcionario_id, nome, salario FROM funcionarios ORDER BY salario DESC;
SELECT pedido_id, data_pedido FROM pedidos ORDER BY data_pedido;
SELECT cliente_id, nome, status FROM clientes ORDER BY status, nome;
SELECT produto_id, categoria_id, nome, preco FROM produtos ORDER BY categoria_id, preco DESC;
SELECT pagamento_id, status, valor FROM pagamentos ORDER BY status, valor DESC;
SELECT cliente_id, nome, telefone FROM clientes ORDER BY telefone NULLS LAST;
SELECT pedido_id, data_pedido FROM pedidos ORDER BY data_pedido DESC, pedido_id DESC;
SELECT produto_id, nome, preco - custo AS margem FROM produtos ORDER BY margem DESC;
SELECT produto_id, quantidade_atual, quantidade_minima,
       quantidade_atual - quantidade_minima AS saldo_minimo
FROM estoque ORDER BY saldo_minimo;
SELECT pedido_id, status, valor_total FROM pedidos WHERE status <> 'CANCELADO' ORDER BY valor_total DESC;
SELECT cliente_id, nome, data_nascimento FROM clientes ORDER BY data_nascimento NULLS FIRST;

-- Desafio 1
SELECT produto_id, categoria_id, nome, preco
FROM produtos
WHERE ativo = 'S'
ORDER BY categoria_id, preco DESC, nome;

-- Desafio 2
SELECT pedido_id, status, data_pedido, valor_total
FROM pedidos
WHERE status <> 'CANCELADO'
ORDER BY CASE status WHEN 'ABERTO' THEN 1 WHEN 'ENVIADO' THEN 2 ELSE 3 END,
         data_pedido;

-- Desafio 3
SELECT produto_id, quantidade_atual, quantidade_minima,
       quantidade_atual - quantidade_minima AS saldo_minimo
FROM estoque ORDER BY saldo_minimo;

-- Desafio 4
SELECT funcionario_id, nome, cargo, salario
FROM funcionarios
WHERE ativo = 'S'
ORDER BY salario DESC, nome;

-- Desafio 5
SELECT cliente_id, nome, telefone
FROM clientes
ORDER BY telefone NULLS FIRST, nome;
