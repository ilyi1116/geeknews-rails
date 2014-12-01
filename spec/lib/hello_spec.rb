# usage: rspec
# usage: rspec spec/models
# usage: rspec spec/models/foo_spec.rb
require 'spec_helper'

describe Hello do
  it "message return hello" do
    expect(Hello.new.message).to eq "hello"
  end
end

# describe explains what we're testing
describe 'add' do
  it '1 + 1 = 2' do
    expect(1+1).to eq 2
  end
end

# multiple example(it do ... end)
describe 'calc' do
  it '1+1=2' do
    expect(1+1).to eq 2
  end
  it '10-1=9' do
    expect(10-1).to eq 9
  end
end
