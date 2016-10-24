##### embarrassingly parallel computation is embarrassingly easy

# This computation is automatically distributed across
# all available compute nodes, and the result, reduced by summation (+),
# is returned at the calling node.
nheads = @parallel (+) for i=1:10000
  rand(Bool)
end

#### multithreading

# at the command line,
# export JULIA_NUM_THREADS=4

Threads.nthreads()

# simple example
a = zeros(10)

Threads.@threads for i = 1:10
    a[i] = Threads.threadid()
end

n=10
niters=4000000
a = zeros(n)
# if all works correctly, it will be faster than single threaded
# note: += is not atomic here
@time Threads.@threads for i = 1:niters
    a[i%n+1] += 1
end

a = zeros(n)
@time for i = 1:niters
    a[i%n+1] += 1
end
