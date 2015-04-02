module HighVoltage
  require "find"

  class PageCollector
    attr_reader :content_path

    def initialize(content_path)
      @content_path = content_path.to_s
    end

    def page_ids
      pages.select(&:valid?).map(&:id)
    end

    private

    def pages
      Find.find(content_path).map do |file_path|
        HighVoltage::Page.new(content_path, file_path)
      end
    end
  end
end
