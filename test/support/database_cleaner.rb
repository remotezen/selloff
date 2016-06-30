
# tests/support/database_cleaner.rb
DatabaseCleaner.strategy = :transaction
DatabaseCleaner.clean_with(:truncation)

class ActiveSupport::TestCase
  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end
end
