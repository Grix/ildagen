/*
**  Usage:
**      combination(set,subset)
**
**  Arguments:
**      set         number of elements, integer
**      subset      size of the subset, integer
**
**  Returns:
**      the number of unique subsets created from all
**      combinations of the given number of elements,
**      or (-1) on error
**
**  Example:
**      If six players compete in pairs, the number of
**      possible matches equals combination(6,2) or 15
**
**  GMLscripts.com
*/
{
    var f,i,j,k,l,m,n;
    n = floor(argument0);
    k = floor(argument1);
    m = n - k;
    if (m < 0) {
        ML_RaiseException_CurParser(ML_EXCEPT_CALC,-1,"subset larger than total set for nCr: " + string(argument0) +", "+ string(argument1) );
        return -1;
    }
    else {
        f = 1;
        i = 1;
        j = 1;
        for (l=2; l<=n; ++l) {
            f *= l;
            if (l == k) i = f;
            if (l == m) j = f;
        }
        return (f / (i * j));
    }
}
