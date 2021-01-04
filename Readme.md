To see predeclared output the following query works:
```
bazel query kind('generated file', //:*)
```
But if you want to see dynamically generated files which don't have labels, then you must use aquery instead:
```
bazel aquery outputs('.*', expand_template)
```