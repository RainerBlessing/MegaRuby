class CipherPair
  def initialize(name, length, mode)
    @c_e = create_encryption_cipher(name, length, mode)
    @c_d = create_decryption_cipher(name, length, mode)
  end

  def key=(key)
    @c_e.key=key
    @c_d.key=key
  end

  def encrypt(data)
    @c_e.update(data)
  end

  def encrypt_final()
    @c_e.final
  end

  def decrypt(data)
    @c_d.update(data) + @c_d.final
  end

  def decrypt_final()
    @c_d.final
  end

  private

  def create_encryption_cipher(name, length, mode)
    cipher = create_cipher(name, length, mode)
    cipher.encrypt
    @iv = cipher.random_iv
    cipher
  end

  def create_decryption_cipher(name, length, mode)
    cipher = create_cipher(name, length, mode)
    cipher.decrypt
    cipher.iv=@iv
    cipher
  end

  def create_cipher(name, length, mode)
    OpenSSL::Cipher.new("#{name}-#{length}-#{mode}")
  end
end