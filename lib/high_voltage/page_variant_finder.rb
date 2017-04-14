module HighVoltage
  class PageVariantFinder < PageFinder
    def find(request_variant = nil)
      path = "#{content_path}#{clean_path}"

      if request_variant
        path += ".html+#{request_variant}.erb"
      end

      path
    end

    private

    attr_reader :request_variant
  end
end
