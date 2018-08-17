: dummy.mod
: Makes functions written in C or NMODL available to hoc
NEURON {
   SUFFIX nothing
}
: call it gceil to avoid naming conflicts
FUNCTION gceil(z) {
   gceil = ceil(z)
}
FUNCTION gfloor(z) {
   gfloor = floor(z)
}