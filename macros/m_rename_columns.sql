{% macro m_rename_columns(table_name, prefix) %}
    {% set columns = adapter.get_columns_in_relation(ref(table_name)) %}
    {% set renamed_columns = [] %}

    {% for column in columns %}
        {% set renamed_column = column.name + ' AS ' + prefix + column.name %}
        {% do renamed_columns.append(renamed_column) %}
    {% endfor %}

    {{ return(renamed_columns | join(', ')) }}
{% endmacro %}