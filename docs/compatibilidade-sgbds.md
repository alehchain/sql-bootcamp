# Compatibilidade entre SGBDs

| Recurso | Oracle | PostgreSQL | SQL Server | MySQL |
|---|---|---|---|---|
| Limitar linhas | `FETCH FIRST 10 ROWS ONLY` | `LIMIT 10` | `TOP 10` ou `OFFSET/FETCH` | `LIMIT 10` |
| Data atual | `SYSDATE` | `CURRENT_TIMESTAMP` | `GETDATE()` | `NOW()` |
| Sequência | `sequence.NEXTVAL` | `nextval('sequence')` | `NEXT VALUE FOR sequence` | Geralmente `AUTO_INCREMENT` |
| Nulo alternativo | `NVL`/`COALESCE` | `COALESCE` | `ISNULL`/`COALESCE` | `IFNULL`/`COALESCE` |
| Diferença de conjuntos | `MINUS` | `EXCEPT` | `EXCEPT` | `EXCEPT` em versões recentes; suporte pode variar |
| String concatenada | `||` | `||` | `+` ou `CONCAT` | `CONCAT` |
| Identity | `GENERATED AS IDENTITY` | `GENERATED AS IDENTITY` | `IDENTITY` | `AUTO_INCREMENT` |

O curso utiliza sintaxe Oracle como referência. Adaptações são destacadas nos módulos correspondentes.
