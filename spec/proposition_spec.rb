# frozen_string_literal: true

RSpec.describe Proposition do
  describe '#well_formed?' do
    subject { described_class.new(formula) }

    context 'each propositional variable is, on its own, a formula' do
      let(:formula) { 'A' }

      it { expect(subject).to be_well_formed }
    end

    context 'if φ is a formula' do
      context 'then ~φ is a formula' do
        let(:formula) { '~φ' }

        it { expect(subject).to be_well_formed }
      end

      context 'and ψ is a formula' do
        context 'and • is any binary connective' do
          context 'then (φ • ψ) is a formula' do
            let(:formulas) do
              ['(φ & ψ)', '(φ || ψ)', '(φ -> ψ)', '(φ <-> ψ)']
            end

            it 'for all boolean operators' do
              formulas.each do |formula|
                expect(described_class.new(formula)).to be_well_formed
              end
            end
          end
        end
      end
    end

    context 'when the formula has unbalanced parens' do
      let(:formula) { '(A & B(' }

      it { expect(subject).to_not be_well_formed }
    end

    context 'when the formula has no symbols' do
      let(:formula) { '()' }

      it { expect(subject).to_not be_well_formed }
    end
  end
end
