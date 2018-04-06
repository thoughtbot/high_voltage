module HighVoltage
  class Page
    attr_reader :content_path, :file_path

    def initialize(content_path, file_path)
      @content_path = content_path
      @file_path = file_path
    end

    def id
      file_path.gsub(content_path, "").split(".").first
    end

    def valid?
      exists? && file_in_content_path? && !directory? && !partial? && handled?
    end

    private

    def handler_extension
      File.extname(file_path).delete(".")
    end

    def exists?
      File.exist?(file_path)
    end

    def file_in_content_path?
      file_path.start_with?(content_path)
    end

    def directory?
      FileTest.directory?(file_path)
    end

    def partial?
      File.basename(file_path).first == "_"
    end

    def handled?
      available_handlers.include? handler_extension
    end

    def available_handlers
      ActionView::Template.template_handler_extensions
    end
  end
end
