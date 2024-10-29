# config/initializers/kaminari_config.rb
Kaminari.configure do |config|
  config.default_per_page = 10   # Set the default items per page
  config.max_per_page = 100       # Set the maximum items per page
  config.window = 4               # Number of pages to display in the pagination window
  config.outer_window = 0         # Number of outer pages to display
  config.left = 0                  # Left window size
  config.right = 0                 # Right window size
  config.page_method_name = :page  # Page method name
  config.param_name = :page        # Query parameter name for pagination
end
