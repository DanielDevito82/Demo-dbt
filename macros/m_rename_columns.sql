{% macro m_rename_columns(schema_name, table_name, prefix) %}
    {% set relation = adapter.get_relation(database=None, schema=schema_name, identifier=table_name) %}
    {% set columns = adapter.get_columns_in_relation(relation) %}
    {% set renamed_columns = [] %}

    {% if columns is none %}
        {% do log("Table " ~ schema_name ~ "." ~ table_name ~ " not found.", info=True) %}
        {% set renamed_columns = ["*"] %}
    {% else %}
        {% for column in columns %}
            {% set renamed_column = column.name + ' AS ' + prefix + column.name %}
            {% do renamed_columns.append(renamed_column) %}
        {% endfor %}
    {% endif %}

    -- Debugging-Ausgabe
    {% do log("Renamed columns for " ~ schema_name ~ "." ~ table_name ~ ": " ~ renamed_columns | join(', '), info=True) %}

    {{ return(renamed_columns | join(', ')) }}
{% endmacro %}