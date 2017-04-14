require 'spec_helper'

describe HighVoltage::PageVariantFinder do
  describe '#find' do
    context when 'request variant is present' do
      it 'produces the name of an existing template with a variant' do
        expect(find('existing', with_request_variant: true)).
          to eq 'pages/existing.html+test.erb'
      end
    end

    context 'when a page variant is not present' do
      it 'defaults to original file name' do
        expect(find('existing')).to eq 'pages/existing'
      end
    end
  end

  private

  def find(page_id, options = {})
    variant = options[:with_request_variant] ? request_variant : nil
    page_finder(page_id).find(variant)
  end

  def page_finder(page_id = 'whatever')
    HighVoltage::PageVariantFinder.new(page_id)
  end

  def request_variant
    :test
  end
end
