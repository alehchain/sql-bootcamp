-- Módulo 07 — IN
SELECT cliente_id, nome, status FROM clientes WHERE status IN ('ATIVO', 'BLOQUEADO');
SELECT produto_id, nome, categoria_id FROM produtos WHERE categoria_id IN (1, 2);
SELECT pedido_id, status FROM pedidos WHERE status IN ('ABERTO', 'PAGO', 'ENVIADO');
SELECT pagamento_id, forma_pagamento FROM pagamentos WHERE forma_pagamento IN ('PIX', 'CARTAO');
SELECT pagamento_id, quantidade_parcelas FROM pagamentos WHERE quantidade_parcelas IN (1, 3, 10);
SELECT produto_id, nome FROM produtos WHERE categoria_id NOT IN (4, 5);
SELECT cliente_id, nome FROM clientes WHERE status NOT IN ('INATIVO', 'BLOQUEADO');
SELECT pedido_id, cliente_id FROM pedidos WHERE cliente_id IN (1, 2, 6);
SELECT funcionario_id, nome, cargo FROM funcionarios WHERE cargo IN ('Gerente de Vendas', 'Vendedora', 'Vendedor');
SELECT pedido_id, data_pedido FROM pedidos WHERE data_pedido IN (DATE '2025-05-02', DATE '2025-06-01');

SELECT cliente_id, nome
FROM clientes
WHERE cliente_id IN (SELECT cliente_id FROM pedidos);

SELECT produto_id, nome
FROM produtos
WHERE produto_id IN (SELECT produto_id FROM itens_pedido);

SELECT produto_id, nome
FROM produtos
WHERE produto_id NOT IN (
    SELECT produto_id FROM itens_pedido WHERE produto_id IS NOT NULL
);

SELECT funcionario_id, nome
FROM funcionarios
WHERE funcionario_id IN (
    SELECT vendedor_id FROM pedidos WHERE vendedor_id IS NOT NULL
);

SELECT pedido_id, status
FROM pedidos
WHERE pedido_id IN (
    SELECT pedido_id FROM pagamentos WHERE status = 'APROVADO'
);
