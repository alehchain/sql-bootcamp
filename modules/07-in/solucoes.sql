-- Soluções — IN
SELECT cliente_id, nome, status FROM clientes WHERE status IN ('ATIVO', 'BLOQUEADO');
SELECT produto_id, nome, categoria_id FROM produtos WHERE categoria_id IN (1, 2, 3);
SELECT pedido_id, status FROM pedidos WHERE status IN ('ABERTO', 'PAGO', 'ENVIADO');
SELECT pagamento_id, forma_pagamento FROM pagamentos WHERE forma_pagamento IN ('PIX', 'CARTAO');
SELECT funcionario_id, nome, cargo FROM funcionarios WHERE cargo IN ('Vendedor', 'Vendedora');
SELECT produto_id, nome FROM produtos WHERE categoria_id NOT IN (4, 5);
SELECT cliente_id, nome FROM clientes WHERE status NOT IN ('INATIVO', 'BLOQUEADO');
SELECT pedido_id, cliente_id FROM pedidos WHERE cliente_id IN (1, 2, 6);
SELECT pagamento_id, quantidade_parcelas FROM pagamentos WHERE quantidade_parcelas IN (1, 3, 10);
SELECT produto_id, nome, preco FROM produtos WHERE categoria_id IN (1, 2) AND preco >= 300;

SELECT cliente_id, nome
FROM clientes
WHERE cliente_id IN (SELECT cliente_id FROM pedidos);

SELECT produto_id, nome
FROM produtos
WHERE produto_id IN (SELECT produto_id FROM itens_pedido);

SELECT funcionario_id, nome
FROM funcionarios
WHERE funcionario_id IN (
    SELECT vendedor_id FROM pedidos WHERE vendedor_id IS NOT NULL
);

SELECT cliente_id, nome
FROM clientes
WHERE cliente_id NOT IN (
    SELECT cliente_id FROM pedidos WHERE cliente_id IS NOT NULL
);

-- Desafio 1
SELECT pedido_id, status FROM pedidos
WHERE status IN ('PAGO', 'FATURADO', 'ENVIADO', 'ENTREGUE');

-- Desafio 2
SELECT produto_id, nome, categoria_id FROM produtos
WHERE categoria_id IN (1, 2, 4) AND ativo = 'S';

-- Desafio 3
SELECT cliente_id, nome FROM clientes
WHERE cliente_id IN (
    SELECT cliente_id FROM pedidos WHERE status <> 'CANCELADO'
);

-- Desafio 4
SELECT produto_id, nome FROM produtos
WHERE produto_id NOT IN (
    SELECT produto_id FROM itens_pedido WHERE produto_id IS NOT NULL
);
