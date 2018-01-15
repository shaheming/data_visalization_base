module RsaUtil
  extend self
  KEY_PATH = "#{Rails.root}/config/keys/"
  # Files to store public and private keys
  PUBLIC_KEY_FILE = KEY_PATH + 'public_key.pem'
  PRIVATE_KEY_FILE = KEY_PATH + 'private_secure_key.pem'
  PASS_PHRASE = "my_rsa_pass"
  def generate_keys

    unless Dir.exist? KEY_PATH
      Dir.mkdir KEY_PATH
    end

    key = OpenSSL::PKey::RSA.new 2048

    open PUBLIC_KEY_FILE, 'w' do |io|
      io.write key.public_key.to_pem
    end

    cipher = OpenSSL::Cipher.new 'AES-128-CBC'
    #openssl支持的对称加密算法
    #OpenSSL::Cipher.ciphers 可以查看所有的算法
    # A PASS_PHRASE can be used to decrypt the key
    key_secure = key.export cipher, PASS_PHRASE

    open PRIVATE_KEY_FILE, 'w' do |io|
      io.write key_secure
    end

    puts 'The public key is in ' + PUBLIC_KEY_FILE
    puts 'The private key is in ' + PRIVATE_KEY_FILE + ' using the pass phrase:'
    puts '"' + PASS_PHRASE + '"'
  end

  def rsa_encrypt(data)
    public_key = File.read(PUBLIC_KEY_FILE)
    key = OpenSSL::PKey::RSA.new(public_key)
    str = data.split('').each_slice(117).inject('') do |str, bytes|
      str += key.public_encrypt(bytes.join)
      str
    end
    Base64.urlsafe_encode64 str
  end

  def rsa_decrypt(data)
    private_key = File.read(PRIVATE_KEY_FILE)
    key = OpenSSL::PKey::RSA.new(private_key)
    encrypted_str = Base64.urlsafe_decode64 URI.decode(data)
    encrypted_str.split('').each_slice(128).inject('') do |str, bytes|
      str += key.private_decrypt(bytes.join)
      str
    end
  end

  def rsa_verify(data, sign)
    return false if sign.blank?
    public_key = File.read(PUBLIC_KEY_FILE)
    rsa = OpenSSL::PKey::RSA.new(public_key)
    sign = Base64.urlsafe_decode64(sign)
    rsa.verify('sha1', sign, data)
  end

  def rsa_sign(data)
    private_key = File.read(PRIVATE_KEY_FILE)
    rsa = OpenSSL::PKey::RSA.new(private_key)
    Base64.urlsafe_encode64(rsa.sign('sha1', data))
  end

end