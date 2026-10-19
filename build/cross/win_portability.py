"""Windows (MinGW-w64) portability fix for CalculiX 2.21, applied to the stock and the stock solver tree alike (idempotent).
usage: python3 -I win_portability.py <ccx_2.21/src>

ccx_2.21.c and ccx_2.21step.c carry, at FILE scope,
    #ifdef __WIN32
    _set_output_format(_TWO_DIGIT_EXPONENT);
    #endif
which is a statement outside any function: GCC 13 parses it as an implicit-int declaration that conflicts with the
prototype in MinGW's <stdio.h> (hard error). The call is meant to make msvcrt printf write two-digit exponents
(1.0E+03, not 1.0E+003; the fixed-column .frd needs this). Fix: delete the file-scope lines and make the same call
as the first statement of main() / CalculiXstep(). No effect on non-Windows builds."""
import sys, os
src = sys.argv[1]
OLD = '#ifdef __WIN32\n_set_output_format(_TWO_DIGIT_EXPONENT);\n#endif\n'
CALL = '\n#ifdef __WIN32\n  _set_output_format(_TWO_DIGIT_EXPONENT); /* win_portability.py: moved here from file scope */\n#endif\n'
for fn, anchor in (('ccx_2.21.c', 'int main(int argc,char *argv[])\n{\n'),
                   ('ccx_2.21step.c', None)):
    p = os.path.join(src, fn); s = open(p, encoding='latin-1').read()
    if 'win_portability.py' in s:
        print(fn, 'already patched'); continue
    assert s.count(OLD) == 1, fn
    s = s.replace(OLD, '', 1)
    if anchor is None:                      # CalculiXstep(...) signature spans several lines: first '{' after it
        i = s.index('void CalculiXstep('); i = s.index('{', i) + 1
    else:
        assert s.count(anchor) == 1, fn
        i = s.index(anchor) + len(anchor) - 1
    s = s[:i] + CALL + s[i:]
    open(p, 'w', encoding='latin-1').write(s); print(fn, 'patched')
