# frozen_string_literal: true

describe UseCase::Load do
  class Request
    def body
      JSON.parse (
        {
          "data": {
            "firstName": 'Joe',
            "lastName": 'Testerton',
            "dateOfBirth": '1985-11-25'
          },
          "endpoint": {
            "method": 'put',
            "uri": 'http://test-endpoint/api/schemes/1/assessors/TEST000000'
          }
        }
      ).to_json
    end
  end

  context 'when making a request' do
    before do
      stub_request(:put, 'http://test-endpoint/api/schemes/1/assessors/TEST000000')
        .with(body: JSON.generate(
            firstName: 'Joe',
            lastName: 'Testerton',
            dateOfBirth: '1985-11-25'
        ))
          .to_return(status: 200)
    end

    it 'sends data to the API endpoint' do
      request = Request.new
      load = described_class.new request
      response = load.execute

      expect(response.code).to eq '200'
    end
  end
end