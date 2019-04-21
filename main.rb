require 'sinatra'
require 'sinatra/reloader' if development?
UP_MIN, UP_MAX = 65, 90
DOWN_MIN, DOWN_MAX = 97, 122

def encrypt(text, offset)
  shifted_chars = []
  text.each_byte do |char_byte|
      if char_byte >= UP_MIN and char_byte <= UP_MAX
          shifted_byte = (((char_byte + offset) - UP_MIN)) % 26 + UP_MIN
      elsif char_byte >= DOWN_MIN and char_byte <= DOWN_MAX
          shifted_byte = (((char_byte + offset) - DOWN_MIN)) % 26 + DOWN_MIN
      else
          shifted_byte = char_byte
      end
      shifted_chars.push(shifted_byte.chr)
  end
  return shifted_chars.join("")
end

get '/' do
  text = params[:text]
  offset = params[:offset].to_i
  @encrypted_text = "Encrypted Text: #{encrypt(text, offset)}" if text
  erb :default
end