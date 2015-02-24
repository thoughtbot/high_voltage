class AlternativeFinderController < HighVoltage::PagesController
  private

  def page_finder_factory
    Rot13PageFinder
  end

  class Rot13PageFinder < HighVoltage::PageFinder
    def find
      paths = super.split('/')
      "#{paths[0..-2].join('/')}/#{paths[-1].tr('a-z','n-za-m')}"
    end
  end
end
