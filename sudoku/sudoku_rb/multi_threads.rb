require 'parallel'

Parallel.each(1..10, in_threads: 8) do |i|
    sleep 10
    puts i
end
