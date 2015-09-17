///_ML_COMP_RemoveExtraTokens(tokenList, importantTokenMap)
/// @argType    r,r
/// @returnType void
/// @hidden     true

var tokenlist = argument0;
var important_tokens = argument1;
var tok;

for (var i = ds_list_size(tokenlist) - 1; i >= 0; --i) {
    tok = ds_list_find_value(tokenlist, i);
    if (!ds_map_exists(important_tokens, tok)) {
        _ML_LiTok_Destroy(tok);
    }
}
