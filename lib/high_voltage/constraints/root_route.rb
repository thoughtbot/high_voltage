module HighVoltage
  module Constraints
    # Routing constraint to validate request.path has a corresponding view
    class RootRoute
      class << self
        def matches?(request)
          page_id = clean_page_path(request.path)
          pattern = file_pattern(page_id)

          Dir.glob(pattern).any?
        end

        private

        def clean_page_path(request_path)
          request_path.sub(/\.html$/, "")
        end

        def file_pattern(page_id)
          "#{content_path}#{page_id}.html*"
        end

        def content_path
          Rails.root.join("app", "views", HighVoltage.content_path).to_s
        end
      end
    end
  end
end
