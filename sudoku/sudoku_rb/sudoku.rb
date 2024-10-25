require 'benchmark'
$NN = 2
$N = $NN * $NN
$PUZZLE = [
    [0, -1, -1, -1],
    [2, -1, 0, 1],
    [3, 2, -1, 0],
    [-1, -1, -1, 2]
  ]
$N_NEURON = $N * $N * $N
$TAU = 10.0
$W_INH = -1.0
$E_REST = -65.0
$THETA = -55.0
$I_EXT = 20.0
$DECAY = 0.5

$NT = 2000
$DT = 1.0

def id(i, j, a)
    return (a + $N * (j + $N * i));
end

def wid(post, pre)
    return pre + $N_NEURON * post
end

def createCoNNection(w)
    $N.times do |i|
        $N.times do |j|
            $N.times do |a|
                post = id(i, j, a)
                #grid
                $N.times do |b|
                    pre = id(i, j, b)
                    w[wid(post, pre)] = (a != b) ? $W_INH : 0.0
                end

                #row
                $N.times do |l|
                    $N.times do |b|
                        pre = id(l, j, b)
                        w[wid(post, pre)] = (i != l && a == b) ? $W_INH : 0.0
                    end
                end

                #column
                $N.times do |l|
                    $N.times do |b|
                        pre = id(i, l, b)
                        w[x = wid(post, pre)] = (j != l && a == b) ? $W_INH : 0.0
                    end
                end

                #box
                $NN.times do |ll|
                  $NN.times do |mm|
                      ib = i / $NN
                      jb = j / $NN
                      l = ll + $NN * ib
                      m = mm + $NN * jb
                      $N.times do |b|
                        pre = id(l, m, b)
                        w[x = wid(post, pre)] = (!(i == l && j == m) && a == b) ? $W_INH : 0.0
                      end
                    end
                end
            end
        end
    end
end

def setInput(i_ext)
    $N.times do |i|
        $N.times do |j|
            b = $PUZZLE[i][j]
            if(b >= 0)
                $N.times do |a|
                    i_ext[id(i, j, a)] = (a == b) ? 1: 0
                end
            end
        end
    end
end

def printAnswer(ns)
    $N.times do |i|
        $N.times do |j|
            maxa = 0
            maxs = ns[id(i, j, maxa)]
            $N.times do |a|
                if(maxs < ns[id(i, j, a)])
                    maxa = a
                    maxs = ns[id(i, j, maxa)]
                end
            end
            print "#{maxa}#{j == $N - 1 ? "\n" : " "}"
        end
    end
end
def main
    result = Benchmark.realtime do
    w = Array.new($N_NEURON * $N_NEURON, 0.0)
    createCoNNection(w)
    
    i_ext = Array.new($N_NEURON, 0.0)
    setInput(i_ext)

    v = Array.new($N_NEURON, $E_REST)

    g_syn = Array.new($N_NEURON, 0.0)
    s = Array.new($N_NEURON, false)
    ns = Array.new($N_NEURON, 0)

    srand(0)

    $NT.times do |nt|
        $N_NEURON.times do |i|
            r = 0.0
            $N_NEURON.times do |j|
                r += w[wid(i, j)] * (s[j] ? 1 : 0)
            end
            g_syn[i] = $DECAY * g_syn[i] + r
        end
        $N_NEURON.times do |i|
            dv = $DT * (-(v[i] - $E_REST) + g_syn[i] + $I_EXT * (i_ext[i] + rand(0.0..1.0))) / $TAU
            s[i] = (v[i] > $THETA)
            v[i] = s[i] ? $E_REST : (v[i] + dv)
            ns[i] += 1 if s[i] && nt >= $NT / 2
            #printf("%d %d\n", nt, i) if s[i]
        end
    end
    printAnswer(ns)
    puts "処理概要 #{result}s"
end
end