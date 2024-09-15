{% macro m_get_table_names(schema_name, filter_names) %}
    {% set query %}
        SELECT table_name
        FROM portfolio_analyse.information_schema.tables
        WHERE table_schema = '{{ schema_name }}' AND table_name LIKE '%{{filter_names}}'
    {% endset %}
    
    {% set results = run_query(query) %}
    
    {% if results is none %}
        {{ exceptions.raise_compiler_error("No results returned for query: " ~ query) }}
    {% endif %}
    
    {{ log("Results: " ~ results, info=True) }}
    
    {% set table_names = [] %}
    {% for row in results %}
        {% do table_names.append(row['table_name']) %}
    {% endfor %}
    
    {{ log("Table names: " ~ table_names, info=True) }}
    {{ return(table_names) }}
{% endmacro %}