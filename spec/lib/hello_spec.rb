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

describe 'four arithmetic operations' do
  it 'you can do everything' do
    expect(1 + 2).to eq 3
    expect(10 - 1).to eq 9
    expect(4 * 8).to eq 32
    expect(40 / 5).to eq 8
  end
end

describe 'four arithmetic operations' do
  describe 'addition' do
    it '1+1=2' do
      expect(1 + 1).to eq 2
    end
  end
  describe 'subtraction' do
    it '10-1=9' do
      expect(10 - 1).to eq 9
    end
  end
end

describe Person do
  describe '#greet' do
    before do
      @params = {name: 'たろう'}
    end
    context  '12歳以下の場合' do
      before do
        @params.merge!(age: 12)
      end
      it 'ひらがなで答えること' do
        user = Person.new(@params)
        expect(user.greet).to eq 'ぼくはたろうだよ'
      end
    end
    context '13歳以上の場合、' do
      before do
        @params.merge!(age: 13)
      end
      it '漢字で答えること' do
        user = Person.new(@params)
        expect(user.greet).to eq '僕はたろうです'
      end
    end
  end
end

# use shared_context
describe Person do
  describe '#greet' do
    let(:user){Person.new(params)}
    let(:params){{name: 'たろう', age: age}}
    shared_context '12歳以下の場合' do
      let(:age){12}
    end
    shared_context '13歳以上の場合' do
      let(:age){13}
    end
    subject{user.greet}
    context  '12歳以下の場合' do
      include_context  '12歳以下の場合' do
        it { is_expected.to eq 'ぼくはたろうだよ'}
      end
    end
    context '13歳以上の場合' do
      include_context '13歳以上の場合' do
        it { is_expected.to eq '僕はたろうです'}
      end
    end
  end

  describe '#child?' do
    let(:user){Person.new(name: 'たろう', age: age)}
    subject{ user.child? }
    context  '12歳以下の場合' do
      let(:age){12}
      it { is_expected.to eq true }
    end
    context '13歳以上の場合、' do
      let(:age){13}
      it { is_expected.to eq false }
    end
  end
end
