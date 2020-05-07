user table
|name|email|password|
|:--:|:--:|:--:|
| TD | TD  |TD      |

task table
|task_name|limit|status|priority|user_id|
|:--:|:--:|:--:|:--:|:--:|

rabel
|task_id|rabel|
|:--:|:--:|

デプロイ仕方
①heroku login
②heroku create
③rails assets:precompile
④heroku buildpacks:set heroku/ruby
⑤heroku buildpacks:add --index 1 heroku/nodejs
⑥git add .
  git commit -m 'heroku'
  git push origin master
⑦git push heroku master
⑧heroku run rails db:migrate

バージョン
Booting Puma
=> Rails 5.2.4.2 application starting in development
=> Run `rails server -h` for more startup options
Puma starting in single mode...
* Version 3.12.4 (ruby 2.6.5-p114)
