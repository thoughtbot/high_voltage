class SubclassedPagesController < HighVoltage::PagesController
  layout 'alternate'

  def content_path
    'other_pages/'
  end
end
