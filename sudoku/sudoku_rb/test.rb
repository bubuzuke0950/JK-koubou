require 'benchmark'
require 'async'
require 'parallel'

def tarai(x = 14, y = 7, z = 0)
  x <= y ? y : tarai(tarai(x-1, y, z),
                     tarai(y-1, z, x),
                     tarai(z-1, x, y))
end

Benchmark.bm(8) do |x|
  x.report('none') { 4.times{ tarai } }
  x.report('thread') { Parallel.each(Array.new(4), in_threads: 4) { tarai } }
  x.report('process') { Parallel.each(Array.new(4), in_processes: 4) { tarai } }
  x.report('fiber') {
    task = Async do
      4.times { Async() { |_task| tarai } }
    end
    task.wait
  }
  x.report('ractor') {
    4.times.map do
      Ractor.new { tarai }
    end.each(&:take)
  }
end