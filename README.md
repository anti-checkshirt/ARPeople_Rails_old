# API

| URL               | レスポンス | パラメーター           | 内容     |
| ----------------- | ---------- | ---------------------- | -------- |
| api/v1/user       | User       | name, email, pass, age | 新規登録 |
| api/v1/setting | code 200   | [image]                | 画像登録 |
| api/v1/search     | User       | Image                  | 検索     |
| api/v1/image      | ImageURL   |user_id, image_name     | 画像のURL取得|



# テーブル

| User           |
| -------------- |
| name           |
| email          |
| password       |
| age            |
| twitter_id     |
| github_id      |
| person_id      |
| user_image_url |

