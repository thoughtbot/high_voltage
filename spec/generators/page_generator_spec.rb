require 'spec_helper'
require 'rails/generators'
require_relative '../../lib/generators/page_generator.rb' # Make sure this path is correct for your project

RSpec.describe PageGenerator, type: :generator do
  # Define the destination directory for generator output
  let(:destination) { Rails.root.join('tmp/generators') }
  let(:filename) { 'homepage' }

  before do
    FileUtils.mkdir_p(destination)
    Rails::Generators.invoke('page', [filename], destination_root: destination)
  end

  after do
    FileUtils.rm_rf(destination)
  end

  it "creates an HTML.ERB page template in the correct location" do
    expect(File.exist?("#{destination}/app/views/pages/#{filename}.html.erb")).to be(true)
  end
end
