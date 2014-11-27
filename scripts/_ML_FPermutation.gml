/*
**  Usage:
**      permutation(set,subset)
**
**  Arguments:
**      set         number of elements, integer
**      subset      size of the subset, integer
**
**  Returns:
**      the number of unique subsets created from all
**      permutations of the given number of elements in
**      which the order of the chosen elements is significant,
**      or (-1) on error.
**
**  Example:
**      If six Olympic runners compete in a race, the number of
**      possible medalist rankings equals permutation(6,3) or 120
**
**  GMLscripts.com
*/
{
    var f,k,l,m,n;
    n = floor(argument0);
    k = floor(argument1);
    m = n - k;
    if (m < 0) {
        ML_RaiseException_CurParser(ML_EXCEPT_CALC,-1,"subset larger than total set for nPr: " + string(argument0) +", "+ string(argument1) );
        return -1;
    }
    else {
        f = 1;
        for (l=n; l>m; --l) f *= l;
        return f;
    }
}
