{% macro m_union_tables(schema_name) %}
    {% set table_names = m_get_table_names(schema_name) %}
    {% if table_names | length == 0 %}
        {{ exceptions.raise_compiler_error("No tables found in schema: " ~ schema_name) }}
    {% endif %}

    {% set union_query %}
        {% for table_name in table_names %}
            SELECT * FROM {{ schema_name }}.{{ table_name }}
            {% if not loop.last %}
                UNION
            {% endif %}
        {% endfor %}
    {% endset %}

    {{ return(union_query) }}
{% endmacro %}