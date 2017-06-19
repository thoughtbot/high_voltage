module HighVoltage
  module Constraints
    # Routing constraint to validate request.path has a corresponding view
    class RootRoute
      def initialize
        @lookup_context = ActionView::LookupContext.new(
          Rails.configuration.paths["app/views"],
        )
      end

      def matches?(request)
        page_id = clean_page_path(request.path)
        template = File.join(content_path, page_id)
        lookup_context.exists? template
      end

      private

      attr_reader :lookup_context

      def clean_page_path(request_path)
        request_path.sub(/\.html$/, "")
      end

      def content_path
        HighVoltage.content_path
      end
    end
  end
end
