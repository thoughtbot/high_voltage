require 'minimal_spec_helper'

describe HighVoltage do
  it 'is valid' do
    expect(HighVoltage).to be_a(Module)
  end

  it 'is loadable without preloading rails' do
    expect { require 'high_voltage' }.not_to raise_error
  end
end
