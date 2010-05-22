require 'bloomfilter'
require 'thread'

class DecayingBloomFilter

  attr_accessor :index, :time
  
  def initialize(opts)
    count = opts.delete(:count)
    @time = opts.delete(:time)
    @master = BloomFilter.new(opts)
    @index = 0
    @filters = []
    @mutex = Mutex.new
    count.times {@filters << BloomFilter.new(opts)}
    Updater.new(self)
  end

  def update_master
    @mutex.synchronize {
      @master.clear
      @filters.each_with_index {|bf, i| @master.merge!(bf)}
      @index = (@index + 1) % @filters.size
      @filters[@index].clear
    }
  end

  def method_missing(method, *args, &block)
    @mutex.synchronize {
      @filters[@index].send(method, *args, &block)
      @master.send(method, *args, &block)
    }
  end

  class Updater
    def initialize(bf)
      ::Thread.new(bf) do |bf|
        loop do
          bf.update_master
          sleep(bf.time)
        end
      end
    end
  end
end