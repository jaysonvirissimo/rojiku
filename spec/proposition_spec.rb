# frozen_string_literal: true

RSpec.describe Proposition do
  describe '#well_formed?' do
    subject { described_class.new(formula) }

    context 'when the formula is well-formed' do
      let(:formula) { '(A & B)' }

      it { expect(subject.well_formed?).to eq(true) }
    end

    context 'when the formula has unbalanced parens' do
      let(:formula) { '(A & B(' }

      it { expect(subject.well_formed?).to eq(false) }
    end

    context 'when the formula has no symbols' do
      let(:formula) { '()' }

      it { expect(subject.well_formed?).to eq(false) }
    end
  end
end
