require 'parallel'
require 'benchmark'
$N = 10000000
def main1
    time = Benchmark.realtime do
        a = Array.new($N)
        $N.times do |i|
            a[i] = i
        end
        puts "処理概要 #{time}s"
    end
end

def main2
    time = Benchmark.realtime do
        a = Array.new($N)
        Parallel.each(0..($N-1), in_threads: 10) do |i|
            a[i] = i
        end
        puts "処理概要 #{time}s"
    end
end
