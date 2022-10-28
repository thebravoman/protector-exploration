[protector](https://github.com/inossidabile/protector) is a gem with a pretty decent functionality. 

We are using it in one of our projects which is huge and with this project I am experimenting with small examples with protector to make sense of different modifications that we should maintain. 

There is an Article and a User data model. The project makes it easier to modify the scopes and rules and see the result

# Experiment with the defaults

1. Can not read the text of public articles if there is no user
But if we do not restrict the article we can read the text.

```ruby
Article.where(hidden: false).restrict!(nil).count
   (0.1ms)  SELECT COUNT(*) FROM "articles" WHERE "articles"."hidden" = ? AND "articles"."hidden" = ?  [["hidden", "f"], ["hidden", "f"]]
 => 2

Article.where(hidden: false).restrict!(nil).first.text
  Article Load (0.1ms)  SELECT  "articles".* FROM "articles" WHERE "articles"."hidden" = ? AND "articles"."hidden" = ?  ORDER BY "articles"."id" ASC LIMIT 1  [["hidden", "f"], ["hidden", "f"]]
 => nil

Article.where(hidden: false).first.text
  Article Load (0.1ms)  SELECT  "articles".* FROM "articles" WHERE "articles"."hidden" = ?  ORDER BY "articles"."id" ASC LIMIT 1  [["hidden", "f"]]
 => "the text" 
 ```

2. Only admins can see articles that are hidden

```ruby
# There are 4 articles
Article.all.count
   (0.3ms)  SELECT COUNT(*) FROM "articles"
 => 4 

# There are 2 articles if there is no user
Article.all.restrict!(nil).count
   (0.4ms)  SELECT COUNT(*) FROM "articles" WHERE "articles"."hidden" = ?  [["hidden", "f"]]
 => 2 

# There are 2 articles if you are a user
Article.all.restrict!(User.find_by(role: "user")).count
  User Load (0.1ms)  SELECT  "users".* FROM "users" WHERE "users"."role" = ? LIMIT 1  [["role", "user"]]
   (0.0ms)  SELECT COUNT(*) FROM "articles" WHERE "articles"."hidden" = ?  [["hidden", "f"]]
 => 2 

# There are 4 articles if you are an admin
Article.all.restrict!(User.find_by(role: "admin")).count
  User Load (0.3ms)  SELECT  "users".* FROM "users" WHERE "users"."role" = ? LIMIT 1  [["role", "admin"]]
   (0.2ms)  SELECT COUNT(*) FROM "articles"
 => 4 
```