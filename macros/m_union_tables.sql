{% macro m_union_tables(schema_name, filter_names, fields) %}
    {% set table_names = m_get_table_names(schema_name, filter_names) %}
    {% if table_names.length == 0 %}
        {{ exceptions.raise_compiler_error("No tables found in schema: " ~ schema_name) }}
    {% endif %}

    {% set union_query = [] %}
    {% for table_name in table_names %}
        {% do union_query.append("SELECT " ~ fields | join(', ') ~ " FROM " ~ schema_name ~ "." ~ table_name) %}
    {% endfor %}

    {% set final_query = union_query | join(" UNION ") %}
    
    {{ return(final_query) }}
{% endmacro %}