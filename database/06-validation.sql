-- Validação simples da instalação.
SELECT 'CLIENTES' tabela, COUNT(*) quantidade FROM clientes
UNION ALL SELECT 'PRODUTOS', COUNT(*) FROM produtos
UNION ALL SELECT 'PEDIDOS', COUNT(*) FROM pedidos
UNION ALL SELECT 'ITENS_PEDIDO', COUNT(*) FROM itens_pedido
UNION ALL SELECT 'PAGAMENTOS', COUNT(*) FROM pagamentos;

SELECT object_name, object_type, status
FROM user_objects
WHERE object_name IN ('VW_RESUMO_PEDIDOS','VW_ESTOQUE_CRITICO')
ORDER BY object_name;
