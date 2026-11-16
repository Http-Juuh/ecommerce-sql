# Resultados SQL

Dados ficticios, valores monetarios em reais.

## Receita mensal

| mes | pedidos | receita_reais |
| --- | --- | --- |
| 2025-01 | 14 | 3798.0 |
| 2025-02 | 13 | 3564.0 |
| 2025-03 | 14 | 4059.0 |
| 2025-04 | 14 | 3798.0 |
| 2025-05 | 15 | 3626.0 |
| 2025-06 | 14 | 4059.0 |
| 2025-07 | 13 | 3303.0 |
| 2025-08 | 14 | 4059.0 |

## Receita por categoria

| categoria | receita_reais |
| --- | --- |
| Acessorios | 25900.0 |
| Papelaria | 4366.0 |

## Recorrencia

| compradores | recorrentes | percentual_recorrentes |
| --- | --- | --- |
| 30 | 30 | 100.0 |

## Prazo por estado

| estado | entregas | dias_medios |
| --- | --- | --- |
| RJ | 37 | 5.3 |
| MG | 37 | 5.46 |
| SP | 37 | 5.7 |

## Ticket medio

| pedidos | ticket_medio_reais |
| --- | --- |
| 111 | 272.67 |

## Interpretacao

- Compare receita por categoria com custos antes de decidir onde investir: receita alta nao implica margem alta.
- A recorrencia e elevada por construcao da base sintetica; nao e um benchmark comercial.
- Prazos medios ocultam variabilidade e nao medem atraso sem uma data prometida.
- A consulta de ticket agrega os itens antes da media, evitando contar um pedido varias vezes.
