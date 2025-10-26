namespace :app do
  desc 'Ridgepole Apply'
  task migrate: :environment do
    system(<<~CMD.squish, exception: true)
      bin/ridgepole -c config/database.yml \
      --bulk-change \
      --allow-pk-change \
      --drop-table
      -s primary
      -a
      -E #{ENV.fetch('RAILS_ENV', 'development')}
    CMD
  end
end