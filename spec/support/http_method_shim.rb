# Rails 5 deprecates calling HTTP action methods with positional arguments
# in favor of keyword arguments. However, the keyword argument form is only
# supported in Rails 5+. Since we support back to 4, we need some sort of shim
# to avoid super noisy deprecations when running tests.
module HTTPMethodShim
  def get(path, params = nil, *args)
    if args.any?
      raise ArgumentError, "Unexpected arguments passed to shim: #{args.inspect}"
    else
      super(path, params: params)
    end
  end
end

if Rails::VERSION::MAJOR >= 5
  RSpec.configure do |config|
    config.include HTTPMethodShim, type: :controller
  end
end
