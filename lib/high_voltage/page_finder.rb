module HighVoltage
  # A command for finding pages by id. This encapsulates the concepts of
  # mapping page names to file names.
  class PageFinder
    def initialize(page_id)
      @page_id = page_id
    end

    # Produce a template path to the page, in a format understood by
    # `render :template => find`
    def find
      path = clean_content_pathname.join(page_id.tr("\\", "/")).cleanpath.to_s
      if !path.start_with?("#{clean_content_pathname}/")
        raise InvalidPageIdError.new "Invalid page id: #{page_id}"
      end
      path
    end

    def content_path
      HighVoltage.content_path
    end

    protected

    # The raw page id passed in by the user
    attr_reader :page_id

    def clean_content_pathname
      Pathname.new(content_path).cleanpath
    end
  end

  class InvalidPageIdError < StandardError; end
end
