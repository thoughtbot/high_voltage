module HighVoltage
  # A command for finding pages by id. This encapsulates the concepts of
  # mapping page names to file names.
  class PageFinder
    VALID_CHARACTERS = "a-zA-Z0-9~!@$%^&*()#`_+-=<>\"{}|[];',?".freeze

    def initialize(page_id)
      @page_id = page_id
    end

    # Produce a template path to the page, in a format understood by
    # `render :template => find`
    def find
      "#{content_path}#{clean_path}"
    end

    def content_path
      HighVoltage.content_path
    end

    protected

    # The raw page id passed in by the user
    attr_reader :page_id

    private

    def clean_path
      path = Pathname.new("/#{clean_id}")
      path.cleanpath.to_s[1..-1].tap do |p|
        if p.blank?
          raise InvalidPageIdError.new "Invalid page id: #{@page_id}"
        end
      end
    end

    def clean_id
      @page_id.tr("^#{VALID_CHARACTERS}", "").tap do |id|
        if invalid_page_id?(id)
          raise InvalidPageIdError.new "Invalid page id: #{@page_id}"
        end
      end
    end

    def invalid_page_id?(id)
      id.blank? || (id.first == ".")
    end
  end

  class InvalidPageIdError < StandardError; end
end
