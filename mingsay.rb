#!/usr/bin/env ruby

require 'optparse'

class Mingsay
  attr_accessor :name, :image, :quote, :quotations

  def initialize(name)
    @name = name
    if(ENV['MINGSAY_PATH'])
        path = File.expand_path(ENV['MINGSAY_PATH'])
    else
        path = File.dirname(__FILE__)
    end
    if !File.directory?(path) then
      puts "No mingsay directory found."
      exit
    end

    img_path = path + '/people/' + @name
    quote_path = path + '/quotations/' + @name
    if File.exists?(img_path)
      @image = File.open(img_path, 'r').read
      img_shift = 8
      @image = @image.split("\n").map {|l| " "*img_shift+l}
    else
      puts "No data found for person '#{@name}'."
      exit
    end
    @quotations = []
    if File.exists?(quote_path)
      @quotations = File.open(path+'/quotations/'+@name, 'r')
                        .read.split("\n\n").map(&:chomp)
    end
  end

  def draw_box(text)
    text = text.split("\n").map(&:chomp)
    if (text.size==1) then
      width = text[0].size
      puts " " + "_"*(width+2)
      puts "< " + text[0] + " >"
      puts " " + "-"*(width+2)
    else
      width = text.map {|x| x.size}.max
      puts " " + "_"*(width+2)
      putline(text[0],width,"/","\\")
      for i in 1..(text.size-2)
        putline(text[i],width,"|","|")
      end
      putline(text[-1],width,"\\","/")
      puts " " + "-"*(width+2)
    end
  end

  def set_quote(quote)
    @quote = quote
  end

  def random_quote()
    @quote = @quotations.sample
  end

  def print()
    draw_box(@quote)
    puts @image
  end
end

output = ""

options = { :person => 'ming', :quote => false }
parser = OptionParser.new do |opts|
  opts.banner = "usage: mingsay [--person PERSONFILE] [--quote]"
  opts.on('-p', '--person PERSONFILE', 'which person to use') do |person|
    options[:person] = person
  end
  opts.on('-q', '--quote', 'Choose a random quote') do |q|
    options[:quote] = true
  end
end

begin
  parser.parse!(ARGV)
rescue OptionParser::ParseError
  puts parser.banner
  exit
end

m = Mingsay.new(options[:person])
if (options[:quote])
  if m.quotations != []
    m.random_quote()
  else
    puts "No quote data for person '#{options[:person]}'."
    exit
  end
else
  if (ARGV.size == 0)
    output = gets()
  else
    output = ARGV.join(' ')
  end
  m.set_quote(output)
end
m.print()

