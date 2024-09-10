{% macro m_get_table_names(schema_name) %}
    {% set query %}
        SELECT table_name
        FROM portfolio_analyse.information_schema.tables
        WHERE table_schema = '{{ schema_name }}'
    {% endset %}
    {% set results = run_query(query) %}
    {% set table_names = results.columns['table_name'] %}
    {{ return(table_names) }}
{% endmacro %}