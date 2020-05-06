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
