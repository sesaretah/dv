bundle exec rake ts:rebuild
bundle exec sidekiq --environment development -C config/sidekiq.yml

