-- Resumo gerencial de pedidos.
CREATE OR REPLACE VIEW vw_resumo_pedidos AS
SELECT
    p.pedido_id,
    p.data_pedido,
    p.status,
    c.cliente_id,
    c.nome AS cliente,
    f.nome AS vendedor,
    t.nome AS transportadora,
    p.valor_produtos,
    p.valor_frete,
    p.valor_desconto,
    p.valor_total
FROM pedidos p
JOIN clientes c ON c.cliente_id = p.cliente_id
LEFT JOIN funcionarios f ON f.funcionario_id = p.vendedor_id
LEFT JOIN transportadoras t ON t.transportadora_id = p.transportadora_id;

-- Produtos abaixo ou no estoque mínimo.
CREATE OR REPLACE VIEW vw_estoque_critico AS
SELECT
    p.produto_id,
    p.nome AS produto,
    e.quantidade_atual,
    e.quantidade_minima,
    e.data_atualizacao
FROM produtos p
JOIN estoque e ON e.produto_id = p.produto_id
WHERE e.quantidade_atual <= e.quantidade_minima;
