# API仕様書

# ユーザー

## `POST` api/v1/register

### 新規登録



#### Parameter

|   Key    |     Value      |
| :------: | :------------: |
|   name   |      名前      |
|  email   | メールアドレス |
| password |   パスワード   |



#### Response

```
{
    "github_id" = tomoki69386;
    "twitter_id" = "tomoki_sun";
    "age" = 12;
    "email" = "aaaaa@example.com";
    "id" = 2;
    "uuid" = "iwioefwfooewfofeo"
    name = "tomoki";
    "password_digest" = abc123abc;
    "user_image_url" = "domain.net/public/iwioefwfooewfofeo/wjeojfeo.jpg";
}
```



## `POST` api/v1/login

### AccessTokenゲット



#### Parameter

|   Key    |     Value      |
| :------: | :------------: |
|  email   | メールアドレス |
| password |   パスワード   |



#### Response

```
{
    "Authorization": "agigehwahofjew"
}
```



## `POST` api/v1/user

### ユーザ情報を取得



#### Header

|      Key      |      Value       |
| :-----------: | :--------------: |
| Authorization | アクセストークン |



#### Response

```
{
    "github_id" = tomoki69386;
    "twitter_id" = "tomoki_sun";
    "age" = 12;
    "email" = "aaaaa@example.com";
    "id" = 2;
    "uuid" = "iwioefwfooewfofeo"
    name = "tomoki";
    "password_digest" = abc123abc;
    "user_image_url" = "domain.net/public/iwioefwfooewfofeo/wjeojfeo.jpg";
}
```



## `PUT` api/v1/user

### ユーザー情報を変更する



#### Header

|      Key      |      Value       |
| :-----------: | :--------------: |
| Authorization | アクセストークン |



#### Parameter

|    Key    |     Value      |
| :-------: | :------------: |
|   name    |      名前      |
|   email   | メールアドレス |
|    age    |    生年月日    |
| twitterID |   TwitterID    |
| githubID  |    GitHubID    |



#### Response

```
{
    "access_token" = eieieiieieieieieieiie;
    age = 100;
    "created_at" = "2018-12-25T07:24:59.667Z";
    email = "tomoki@g.com";
    "github_id" = tomoki69386;
    id = 2;
    name = "\U30c6\U30b9\U30c8User";
    "password_digest" = TomokiTomoki;
    "person_id" = "<null>";
    "twitter_id" = "tomoki_sun";
    "updated_at" = "2018-12-26T07:14:41.322Z";
    "user_image_url" = "";
    uuid = "aaaaaaaaaaaaaaaaaaallllllllllllwwwwwwwwwiiie";
}
```



## `POST` api/v1/user_image

### ユーザーのプロフィール画像を設定する



#### Header

|      Key      |      Value       |
| :-----------: | :--------------: |
| Authorization | アクセストークン |



#### Parameter

|  Key  | Value |
| :---: | :---: |
| Image | 画像  |



#### Response

```
{
    "message": "OK"
}
```



# FaceSearch

## `POST` api/v1/images

### 画像の登録



#### Header

|      Key      |      Value       |
| :-----------: | :--------------: |
| Authorization | アクセストークン |



#### Parameter

|   Key   |  Value   |
| :-----: | :------: |
| image1  | 画像.jpg |
| Image10 | 画像.jpg |



#### Response

```
{
    "message": "OK"
}
```



## `POST` api/v1/search

### 顔写真からユーザーの検索



#### Header

|      Key      |      Value       |
| :-----------: | :--------------: |
| Authorization | アクセストークン |



#### Parameter

|  Key  |  Value   |
| :---: | :------: |
| Image | 画像.jpg |



#### Response

```
{
    "github_id" = tomoki69386;
    "twitter_id" = "tomoki_sun";
    "age" = 12;
    "email" = "aaaaa@example.com";
    "id" = 2;
    "uuid" = "iwioefwfooewfofeo"
    name = "tomoki";
    "password_digest" = abc123abc;
    "user_image_url" = "domain.net/public/iwioefwfooewfofeo/wjeojfeo.jpg";
}
```



# その他

## `POST` api/v1/info

### お問い合わせ

#### Parameter

|    Key     |       Value        |
| :--------: | :----------------: |
| deviceName |      iPhoneXs      |
| appVersion | アプリのバージョン |
|    name    |        Name        |
|  message   |  お問い合わせ内容  |
|  infoType  |       String       |



#### Response

```
{
    "message": "OK"
}
```



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
