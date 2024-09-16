{{ config(
    materialized='view'
) }}

WITH posts AS (
    SELECT
        {{ m_rename_columns('t_reddit_posts', 'posts_') }}
    FROM {{ ref('t_reddit_posts') }}
),

comments AS (
    SELECT
        {{ m_rename_columns('t_reddit_comments', 'comments_') }}
    FROM {{ ref('t_reddit_comments') }}
)

SELECT
    posts.*,
    comments.*
FROM posts
JOIN comments
ON posts.posts_id = comments.comments_post_id
