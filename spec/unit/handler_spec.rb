# frozen_string_literal: true

require 'rspec'

describe Handler do
  context 'when invoking processor with event' do
    it 'does not raise an error' do
      ENV['ETL_STAGE'] = 'extract'

      expect do
        handler = described_class.new Container.new
        handler.process(
          message: {
            Records: []
          }
        )
      end.not_to raise_error
    end
  end

  context 'when invoking processor without configuring a stage' do
    it 'raises an error' do
      ENV['ETL_STAGE'] = ''

      expect do
        handler = described_class.new Container.new
        handler.process(
          message: {
            Records: []
          }
        )
      end.to raise_error instance_of Errors::EtlStageInvalid
    end
  end

  context 'when invoking processor with invalid stage configuration' do
    it 'raises an error' do
      ENV['ETL_STAGE'] = 'asdf'

      expect do
        handler = described_class.new Container.new
        handler.process(
          message: {
            Records: []
          }
        )
      end.to raise_error instance_of Errors::EtlStageInvalid
    end
  end
end
