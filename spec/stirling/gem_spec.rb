require "rails_helper"

RSpec.describe Stirling::Gem do
  describe ".load?" do
    let(:gem_name){"gem_name"}
    let(:gem_names){[gem_name]}

    before {Stirling::Gem.class_variable_set "@@loading_gems", gem_names}

    context "when argument is valid" do
      it {expect(Stirling::Gem.load? gem_name).to be_truthy}
      it do
        expect(Stirling::Gem.class_variable_get "@@loading_#{gem_name}")
          .to be_truthy
      end
    end

    context "when argument is invalid" do
      subject {Stirling::Gem.load? "bar"}

      it {is_expected.to be_falsy}
    end
  end
end
