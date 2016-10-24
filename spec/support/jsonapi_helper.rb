# frozen_string_literal: true

CONTENT_TYPE = 'application/vnd.api+json'

def headers(token = nil)
  {
    'HTTP_ACCEPT' => CONTENT_TYPE,
    'HTTP_AUTHORIZATION' => "Token token=#{token}",
    'CONTENT_TYPE' => CONTENT_TYPE
  }
end

def parsed_json
  JSON.parse(response.body)
end

def data
  parsed_json['data']
end

def data_ids
  data.map { |item| item['id'] }
end

shared_examples 'valid response' do
  it { expect(response.content_type).to eq(CONTENT_TYPE) }
  it { expect(response.status).to be 200 }
end

shared_examples 'unauthorized response' do
  it { expect(response.content_type).to eq(CONTENT_TYPE) }
  it { expect(response.status).to be 403 }
end