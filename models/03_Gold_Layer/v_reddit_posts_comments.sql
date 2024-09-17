{{ config(
    materialized='view'
) }}

WITH posts AS (
    SELECT
        {{ m_rename_columns('silver_social_media_by_dbt','t_reddit_posts', 'posts_') }}
    FROM {{ source('Reddit API Silver Layer','t_reddit_posts') }}
),

comments AS (
    SELECT
        {{ m_rename_columns('silver_social_media_by_dbt','t_reddit_comments', 'comments_') }}
    FROM {{ source('Reddit API Silver Layer','t_reddit_comments') }}
)

SELECT
    *
FROM posts
JOIN comments
ON posts.posts_id = comments.comments_id
