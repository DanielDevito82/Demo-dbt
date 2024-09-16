{{ config(
    materialized='table'
) }}

{% set 
fields_comments = 
    [
    "all_awardings",
    "cast(approved_at_utc AS TIMESTAMP) AS approved_at_utc",
    "approved_by",
    "author",
    "author_fullname",
    "author_is_blocked",
    "author_premium",
    "banned_at_utc",
    "banned_by",
    "body",
    "cast(created_utc AS TIMESTAMP) AS created_utc",
    "comment_type",
    "controversiality",
    "cast(created AS TIMESTAMP) AS created",
    "depth",
    "edited",
    "id",
    "likes",
    "link_id",
    "locked",
    "mod_note",
    "mod_reason_by",
    "mod_reason_title",
    "mod_reports",
    "name",
    "num_reports",
    "parent_id",
    "permalink",
    "report_reasons",
    "score",
    "subreddit",
    "subreddit_id",
    "subreddit_name_prefixed",
    "subreddit_type",
    "top_awarded_type",
    "total_awards_received",
    "user_reports"
    ]
%}

WITH unioned_data AS (
    {{ m_union_tables('bronze_reddit_deltatable', 'comments', fields_comments ) }}
 )

SELECT * FROM unioned_data
LIMIT 1000000