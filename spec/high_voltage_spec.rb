require 'minimal_spec_helper'

describe HighVoltage do
  it 'should be valid' do
    HighVoltage.should be_a(Module)
  end

  it 'should be loadable without preloading rails' do
    expect { require 'high_voltage' }.not_to raise_error
  end
end
