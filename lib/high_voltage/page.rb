module HighVoltage
  class Page
    attr_reader :content_path, :file_path

    def initialize(content_path, file_path)
      @content_path = content_path
      @file_path = file_path
    end

    def id
      file_path.gsub(content_path, "").gsub(html_file_pattern, "")
    end

    def valid?
      exists? && file_in_content_path? && !directory? && !partial? && valido?
    end

    private

    def exists?
      File.exists?(file_path)
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

    def valido?
      !file_path.match(valid_file_pattern).nil?
    end

    def valid_file_pattern
      \.(haml||erb||slim)(\.[a-z]+)?$
    end
  end
end
