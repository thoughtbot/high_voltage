module HighVoltage
  class PageFinder
    VALID_CHARACTERS = "a-zA-Z0-9~!@$%^&*()#`_+-=<>\"{}|[];',?".freeze

    def initialize(page_id)
      @page_id = page_id
    end

    def find
      "#{content_path}#{clean_path}"
    end

    def content_path
      HighVoltage.content_path
    end

    protected

    attr_reader :page_id

    private

    def clean_path
      path = Pathname.new("/#{clean_id}")
      path.cleanpath.to_s[1..-1]
    end

    def clean_id
      @page_id.tr("^#{VALID_CHARACTERS}", '')
    end
  end
end
