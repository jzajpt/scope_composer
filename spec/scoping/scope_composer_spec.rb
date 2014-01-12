# encoding: utf-8

require "spec_helper"

describe Scoping::ScopeComposer do
  describe "#all" do
    let(:scope) { double "Scope" }
    subject { Scoping::ScopeComposer.new scope, table }

    context 'given criteria table' do
      let(:table) { { a: '1', b: '2', c: '3' } }

      it "applies all scopes" do
        scope.stub_chain(:method, :arity).and_return 1
        scope.stub_chain(:a, :b, :c).and_return "halelujah"
        expect(subject.all).to eq "halelujah"
      end
    end

    context 'not given any criteria table' do
      let(:table) { nil }

      it "applies all scopes" do
        expect(scope).to receive :all
        subject.all
      end
    end
  end

  describe "#count" do
    let(:scope) { double "Scope" }
    subject { Scoping::ScopeComposer.new scope, table }

    context 'given criteria table' do
      let(:table) { { a: '1', b: '2', c: '3' } }
      let(:result) { double "ResultScope" }

      it "applies all scopes" do
        scope.stub_chain(:method, :arity).and_return 1
        scope.stub_chain(:a, :b, :c).and_return result
        expect(result).to receive :count
        subject.count
      end
    end

    context 'not given any criteria table' do
      let(:table) { nil }

      it "applies all scopes" do
        expect(scope).to receive :count
        subject.count
      end
    end
  end

  describe "#paginate" do
    let(:scope) { double "Scope" }
    subject { Scoping::ScopeComposer.new scope, table }

    context 'given criteria table' do
      let(:table) { { a: '1', b: '2', c: '3' } }
      let(:result) { double "ResultScope" }

      it "applies all scopes" do
        scope.stub_chain(:method, :arity).and_return 1
        scope.stub_chain(:a, :b, :c).and_return result
        expect(result).to receive(:paginate).with page: 1, per_page: 123
        subject.paginate(page: 1, per_page: 123)
      end
    end

    context 'not given any criteria table' do
      let(:table) { nil }

      it "applies all scopes" do
        expect(scope).to receive :paginate
        subject.paginate
      end
    end
  end
end
