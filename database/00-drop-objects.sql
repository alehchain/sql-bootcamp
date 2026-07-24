-- Remove objetos do curso quando existirem.
BEGIN
    FOR obj IN (
        SELECT object_name, object_type
        FROM user_objects
        WHERE object_name IN (
            'AUDITORIA','USUARIOS','PERFIS','ESTOQUE','PAGAMENTOS',
            'ITENS_PEDIDO','PEDIDOS','TRANSPORTADORAS','PRODUTOS',
            'FORNECEDORES','CATEGORIAS','CLIENTES','FUNCIONARIOS',
            'VW_RESUMO_PEDIDOS','VW_ESTOQUE_CRITICO'
        )
        AND object_type IN ('TABLE','VIEW')
    ) LOOP
        BEGIN
            IF obj.object_type = 'TABLE' THEN
                EXECUTE IMMEDIATE 'DROP TABLE ' || obj.object_name || ' CASCADE CONSTRAINTS PURGE';
            ELSE
                EXECUTE IMMEDIATE 'DROP VIEW ' || obj.object_name;
            END IF;
        EXCEPTION
            WHEN OTHERS THEN NULL;
        END;
    END LOOP;

    FOR seq IN (
        SELECT sequence_name
        FROM user_sequences
        WHERE sequence_name LIKE 'SEQ_%'
    ) LOOP
        EXECUTE IMMEDIATE 'DROP SEQUENCE ' || seq.sequence_name;
    END LOOP;
END;
/
