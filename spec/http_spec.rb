require 'rspec'
require './src/http.rb'

describe 'HTTP' do

  it 'should update s time' do
    http = HTTP.new

    time = http.update_s_time
    ds = http.ds

    expect(ds).to eq(time)
  end
end