desc 'Create a database and test database from a database dump'
task :build, [:train_system] do |t, args|
  system("createdb #{args.train_system}")
  system("psql #{args.train_system} < database_backup.sql")
  system("createdb -T #{args.train_system} #{args.train_system + '_test'}")
end
