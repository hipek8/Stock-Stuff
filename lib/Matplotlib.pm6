class Matplotlib {

    use Inline::Python;

    has $!py;

    submethod BUILD() {
        $!py = Inline::Python.new();
        $!py.run('import matplotlib.pyplot')
    }

    method FALLBACK($name, *@x) { $!py.call('matplotlib.pyplot', $name,   @x); }
} 
