# frozen_string_literal: true

require 'json'

describe 'Acceptance::Load' do
  context 'when no data is supplied in the event body' do
    it 'raises an error' do
      message = JSON.parse File.open('spec/messages/sqs-empty-message.json').read

      ENV['ETL_STAGE'] = 'load'

      expect do
        handler = Handler.new Container.new
        handler.process message: message
      end.to raise_error instance_of Errors::RequestWithoutBody
    end
  end

  context 'when data is supplied' do
    context 'when all required data is present' do
      it 'sends the data to the endpoint' do
        message = JSON.parse File.open('spec/messages/sqs-message-load-input.json').read

        ENV['ETL_STAGE'] = 'load'

        http_stub = stub_request(:put, 'http://test-endpoint/api/schemes/1/assessors/TEST000000')
                    .to_return(body: JSON.generate(message: 'ok'), status: 200)

        handler = Handler.new Container.new
        handler.process message: message

        expect(WebMock).to have_requested(:put, 'http://test-endpoint/api/schemes/1/assessors/TEST000000')
          .with(body: JSON.generate(
            firstName: 'Joe',
            lastName: 'Testerton',
            dateOfBirth: '1980-11-01 00:00:00.000000'
          ))

        remove_request_stub(http_stub)
      end
    end
  end
end
