require 'rspec'
require './src/client.rb'

describe 'Login' do

  it 'should compute UTF-8 password hash' do
    string = 'rainer.blessing@googlemail.com'
    cipher =SymmCipher.new('ecb', [0x64, 0x3, 0x39, 0x72, 0x5E, 0x6E, 0xBD, 0x13, 0xA2, 0x5F, 0x00, 0x52, 0x12, 0x9F, 0x7C, 0xB1].pack('c*'))

    client = Client.new

    hash=client.stringhash64(string, cipher)

    expect(hash).to eq([0xfd, 0xfe, 0xbb, 0x5f, 0x65, 0xc5, 0x7c, 0x5d, 0x65, 0xc5, 0x7c, 0x5d, 0x43, 0xbe, 0x35, 0x5d].pack('c*'))
  end

  it 'computes pw_key' do
    password="password"

    client = Client.new

    pwkey=client.pw_key(password)

    expect(pwkey).to eq([0x64, 0x3, 0x39, 0x72, 0x5E, 0x6E, 0xBD, 0x13, 0xA2, 0x5F, 0x00, 0x52, 0x12, 0x9F, 0x7C, 0xB1].pack('c*'))
  end

  it 'copies part of the hash for unknown reason' do
    email="rainer.blessing@googlemail.com"
    client = Client.new

    copied=client.copy_part_of_hash(email)

    expect(copied).to eq('rainlesslessing@')
  end
end