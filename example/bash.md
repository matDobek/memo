# Bash
## Difference between $(...) and (...) and $((...)) and ((...))

`$(...)` executes command in a subshell and return its output as string.
`(...)` executes command in a subshell.

`$((...))` performs arithmetic and return result
`((...))` performs arithmetic

```
a=$(( b = 1 + 1 ))
echo $a # 2
echo $b # 2
```


`$(...)` and `$((...))` are just substitutions.

```
fileName=$(date).txt

echo $fileName
```

## For what is `${...}` ?

`${...}` tells where variable starts and ends.

```
echo "Found 42 ${type}s"
```

## Difference between `let`, `((...))` and `$((...))`

Those constructs allows us to use C style manipulation.
Works only for integer arithmetic.

`let ...` - arithmetic evaluation
`((...))` - arithmetic evaluation
`$((...))` - arithmetic expansion


```
(( 1 + 1 ))   # OK (noop)
$(( 1 + 1 ))  # 2: command not found

let x=1
let x=x+1
let "x = x + 1"
let i++
let i-=2
```

## " vs '

" interpolate
' do not interpolate
