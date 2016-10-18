# frozen_string_literal: true
def headers(token = nil)
  {
    'HTTP_ACCEPT' => 'application/vnd.api+json',
    'HTTP_AUTHORIZATION' => "Token token=#{token}"
  }
end

def parsed_json
  subject
  JSON.parse(response.body)
end

def data
  parsed_json['data']
end

def data_ids
  data.map { |item| item['id'] }
end

shared_examples 'valid response' do
  it do
    expect(subject)
    expect(response.status).to be 200
    expect(response.content_type).to eq('application/vnd.api+json')
  end
end

shared_examples 'unauthorized response' do
  it do
    expect(subject)
    expect(response.status).to be 403
    expect(response.content_type).to eq('application/vnd.api+json')
  end
end
