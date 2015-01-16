require "rails_helper"

RSpec.describe Stirling::BaseController, :type => :controller do
  let(:model_name){"base"}
  let(:instance) {double "instance"}
  let(:new_instance){double "new_instance"}

  describe "#model_name" do
    subject {controller.send :model_name}

    it {is_expected.to eq model_name}
  end

  describe "#model" do
    subject {controller.send :model}

    context "When there is constant" do
      before {class Base < ActiveRecord::Base; end}

      it {is_expected.to eq model_name.classify.safe_constantize}
    end

    context "When there is not constant" do
      before do
        expect(controller).to receive(:model_name).and_return "fuga"
      end

      it {is_expected.to be_nil}
    end
  end

  describe "#model_name_symbol" do
    subject {controller.send :model_name_symbol}

    it {is_expected.to eq :"#{model_name}"}
  end

  describe "#load_instance" do
    subject {controller.send :load_instance}

    before do
      expect(controller.send(:model)).to receive(:find).and_return instance
    end

    it {is_expected.to eq instance}
  end

  describe "#build_instance" do
    subject {controller.send :build_instance}

    before do
      expect(controller).to receive(:model_params)
      expect(controller.send(:model)).to receive(:new).and_return instance
    end

    it {is_expected.to eq instance}
  end

  describe "#instance=" do
    subject {assigns model_name}

    before do
      expect(controller).to receive(:model_name).and_return model_name
      controller.send :instance=, new_instance
    end

    it {is_expected.to eq new_instance}
  end

  describe "#instance" do
    subject {controller.send :instance}

    before do
      controller.send :instance=, instance
    end

    it {is_expected.to eq instance}
  end

  describe "#assign_params" do
    subject {controller.send :assign_params}

    before do
      expect(controller).to receive(:model_params)
      expect(instance).to receive(:assign_attributes).and_return instance
      expect(controller).to receive(:instance).and_return instance
    end

    it {is_expected.to eq instance}
  end


  describe "#model_params" do
    subject {controller.send :model_params}

    let(:params){{"key1" => "value1", "key2" => "value2"}}

    if Rails.version >= "4.0.0"
      before do
        controller.send(:model).class_eval {def self.acceptable_attributes; end}
        expect(controller.send(:model)).to receive(:acceptable_attributes)
          .and_return params.keys
      end

      context "when params's keys is same as model.acceptable_attributes" do
        before do
          controller.params[controller.send(:model_name_symbol)] = params
        end

        it {is_expected.to eq params}
      end

      context "when param's keys is not same as model.acceptable_attributes" do
        before do
          controller.params[controller.send(:model_name_symbol)] = params
            .merge({"key3" => "value3"})
        end

        it {is_expected.to eq params}
      end
    else
      before do
        controller.params[controller.send(:model_name_symbol)] = params
      end

      it {is_expected.to eq params}
    end
  end

  describe "#load_instances" do
    subject {controller.send :load_instances}

    context "when app includes ransack" do
      let(:ransack){double "ransack", :result => nil}

      before do
        controller.send(:model).class_eval {def self.search(q); end}
        expect(Stirling::Gem).to receive("load?").with("ransack")
          .and_return true
        expect(Stirling::Gem).to receive("load?").with("kaminari")
          .and_return false
        expect(Stirling::Gem).to receive("load?").with("will_paginate")
          .and_return false
        expect(controller.send(:model)).to receive(:search).and_return ransack
        expect(ransack).to receive(:result).and_return ransack
      end

      it {is_expected.to eq ransack}
    end

    context "when app does not include ransack" do
      before do
        expect(Stirling::Gem).to receive("load?").with("ransack")
          .and_return false
        expect(Stirling::Gem).to receive("load?").with("kaminari")
          .and_return false
        expect(Stirling::Gem).to receive("load?").with("will_paginate")
          .and_return false
        expect(controller.send(:model)).to receive(:all).and_return instance
      end

      it {is_expected.to eq instance}
    end

    context "when app includes paginate" do
      before do
        controller.send(:model).class_eval {def self.page(page); end}
        expect(Stirling::Gem).to receive("load?").with("ransack")
          .and_return false
        expect(Stirling::Gem).to receive("load?").with("kaminari")
          .and_return true
        expect(controller.send(:model)).to receive(:all).and_return instance
        expect(instance).to receive(:page).and_return instance
      end

      it {is_expected.to eq instance}
    end
  end
end
