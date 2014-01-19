require './src/symm_cipher'

class Client
  # To change this template use File | Settings | File Templates.
  def stringhash64(string, cipher)
    stringhash(string.downcase, cipher)
  end

  def stringhash(string, cipher)
    t = string.length & -16
    hash=string[t..-1]

    (16-hash.length).times do
      hash+="\x0"
    end

    while t>0 do
      t -= 16
      hash=cipher.xor(string[t..-1], hash)
    end

    16384.times do
      hash = cipher.encrypt(hash)
    end
    hash=hash.length>0 ? hash : cipher.encrypt_final

    copy_part_of_hash(hash)
  end

  def copy_part_of_hash(hash)
    hash[0..3]+hash[8..11]+hash[8..15]
  end

  def pw_key(password)
    t = password.length
    n=(password.length+15)/16
    keys=[]
    key_size = 16

    n.times do |i|
      valid=(i!=(n-1)) ? key_size : (t-key_size*i)
      key=password[i*key_size...i*key_size+valid]
      (key_size-valid).times do
        key+="\x0"
      end

      keys << SymmCipher.new('ecb', key)
    end

    key ="\x93\xC4\x67\xE3\x7D\xB0\xC7\xA4\xD1\xBE\x3F\x81\x01\x52\xCB\x56"

    65536.times do
      n.times do |j|
        key=keys[j].encrypt(key)
      end
    end
    key
  end
end