# frozen_string_literal: true

require 'rspec'

require 'json'

describe 'Acceptance::Extract' do
  context 'when no data is supplied in the event body' do
    it 'raises an error' do
      message = JSON.parse File.open('spec/messages/sqs-empty-message.json').read

      ENV['ETL_STAGE'] = 'extract'

      expect do
        handler = Handler.new Container.new
        handler.process message: message
      end.to raise_error instance_of Errors::RequestWithoutBody
    end
  end
end
