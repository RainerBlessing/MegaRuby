require './src/cipher_pair.rb'

class SymmCipher
  BLOCK_SIZE = 128
  NAME = "aes"

  def initialize(mode, key)
    @cipher_cbc = CipherPair.new(NAME, BLOCK_SIZE, mode)
    self.key=key
  end

  def key=(key)
    @cipher_cbc.key=key
  end

  def encrypt(data)
    @cipher_cbc.encrypt(data)
  end

  def encrypt_final()
    @cipher_cbc.encrypt_final
  end

  def decrypt(data)
    @cipher_cbc.decrypt(data)
  end

  def decrypt_final()
    @cipher_cbc.decrypt_final
  end

  def xor(src, dst='')
    if dst.empty?
      src.length.times do
        dst+=[0].pack('C*')
      end
    end

    res=dst.bytes
    src.bytes.each_with_index { |b, i| res[i]=b^dst.bytes[i] if i<dst.length }
    res.pack('C*')
  end
end