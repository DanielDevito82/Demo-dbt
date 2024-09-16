{% macro m_create_schema_if_not_exists(schema_name) %}
    {% set sql %}
        CREATE SCHEMA IF NOT EXISTS {{ schema_name }}
    {% endset %}
    {{ run_query(sql) }}
{% endmacro %}