{{ config(
    materialized='table'
) }}

{% set 
fields_posts = [
    "author",
    "author_premium",
    "author_is_blocked",
    "approved_by",
    "try_cast(approved_at_utc AS TIMESTAMP) AS approved_at_utc",
    "category",
    "try_cast(created AS TIMESTAMP) AS created",
    "try_cast(created_utc AS TIMESTAMP) AS created_utc",
    "try_cast(edited AS TIMESTAMP) AS edited",
    "fullname",
    "id",
    "mod_note",
    "mod_reason_by",
    "mod_reason_title",
    "mod_reports",
    "name",
    "num_comments",
    "num_crossposts",
    "num_reports",
    "over_18",
    "parent_whitelist_status",
    "removal_reason",
    "removed_by",
    "removed_by_category",
    "report_reasons",
    "score",
    "selftext",
    "shortlink",
    "subreddit",
    "subreddit_id",
    "subreddit_name_prefixed",
    "subreddit_subscribers",
    "subreddit_type",
    "suggested_sort",
    "title",
    "top_awarded_type",
    "total_awards_received",
    "url",
    "user_reports",
    "view_count",
    "visited",
    "whitelist_status"
] %}

WITH unioned_data AS (
    {{ m_union_tables('bronze_reddit_deltatable', 'posts', fields_posts ) }}
 )

SELECT * FROM unioned_data
LIMIT 1000000