require 'rspec'
require './src/symm_cipher.rb'

def create_symm_cipher
  cipher = OpenSSL::Cipher::AES.new(256, :CBC)
  SymmCipher.new('cbc', cipher.random_key)
end

describe 'Symmetric Cipher' do

  it 'should encrypt and decrypt a short string' do
    sc = create_symm_cipher
    plaintext = 'plaintext'

    encrypted = sc.encrypt(plaintext)
    decrypted = sc.decrypt(encrypted+sc.encrypt_final)

    expect(plaintext).to eq(decrypted)
  end

  it 'xors two strings with one reversal' do
    sc = create_symm_cipher

    t1='aaa'
    t2='bbb'

    x1=sc.xor(t1)
    x2=sc.xor(t2, x1)
    x3=sc.xor(t2, x2)
    expect(x3).to eq(t1)
  end
end