require "find"

module HighVoltage
  class PageCollector
    attr_reader :content_path

    def initialize(content_path)
      @content_path = File.join(content_path.to_s, "")
    end

    def page_ids
      Find.find(@content_path).
        reject { |f| File.basename(f).start_with?("_") || File.directory?(f) }.
        map { |f| f[@content_path.length...ext_index(f)] }
    end

    private

    def template_ext?(ext)
      @ext_lookup ||=
        ActionView::Template.template_handler_extensions.index_by(&:itself)
      @ext_lookup.key?(ext)
    end

    def ext_index(path)
      at = path.length
      while (i = path.rindex(".", at - 1)) && template_ext?(path[(i + 1)...at])
        at = i
      end
      at
    end
  end
end
