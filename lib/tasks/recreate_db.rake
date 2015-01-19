namespace :db do
  desc "Re-Create database, db:drop, db:create, db:migrate, db:seed"
  task recreate: ["db:drop", "db:create", "db:migrate", "db:seed",
    "db:test:prepare"]
end
