///_ML_LexicalAnalysis(parser, tokenlist, string)
/// @argType    r, r, s
/// @returnType r
/// @hidden     true

var str, s, c, tc, tokenstr, tstr, p, tokenlist;

var l = 0;
var level = 0;
var maxlevel = 0;

//lists
var parser = argument0;
str = argument2;

var P_ROOTS = _ML_LiP_GetOperatorRoots(parser);

//initialize
tokenlist = argument1;
p = 1;
while (string_length(str) > 0) {
    c = string_char_at(str,1);
    l = 1;
    if (c != " ") {
        if (c == '"' || c == "'") {
            l = 2;
            while (l <= string_length(str) ){
                tc = string_char_at(str,l);
                if (tc == c) break;
                ++l;
            }
        } else if (_ML_LEX_Alpha(c) || c == "_") {
            l = 2;
            while (l <= string_length(str) ){
                tc = string_char_at(str,l);
                if !(_ML_LEX_Word(tc)) break;
                ++l;
            }
            --l;
        } else if (_ML_LEX_Digit(c)) { 
            l = 2;
            while (l <= string_length(str) ){
                tc = string_char_at(str,l);
                if (!_ML_LEX_Digit(tc) && tc != ".") break;
                ++l;
            }
            --l;
        } else if (_ML_LEX_Punct(c)) {
            l = 2;
            tstr = c;
            var baselength = 1;
            var v;
            while (l <= string_length(str) ){
                tc = string_char_at(str,l);
                tstr += tc;
                v = ds_map_find_value(P_ROOTS, tstr);
                if (!is_array(v)) {
                    break;
                }
                if (v[1] > 0) {
                    baselength = l;
                }
                
                ++l;
            }
            l = baselength;
        } else {
            ML_RaiseException(ML_EXCEPT_CHAR,p,"unknown charcter: '"+c+"' at "+string(p));
            l = _ML_FirstStringPos3(str, " ", "(", ")") - 1;
        }
        if (l <= 0) l = string_length(str);
        tokenstr = string_copy(str,1,l);
        _ML_LEX_TokenAdd(tokenlist, tokenstr,p);
    }
    str = string_delete(str,1,l);
    p += l;
}
var eol = _ML_LEX_TokenAdd(tokenlist,"",p);
_ML_LEX_TokenSetType(parser, eol, ML_TT_EOL);
if (!ML_NoException(parser)) return tokenlist;

//now for each token determine it's type:
var i, tok, v, prevtok;
s = ds_list_size(tokenlist) - 1;
if (s > 0) {
    //first token is special, no binary, no prevtoken:
    tok = ds_list_find_value(tokenlist, 0)
    if (string(_ML_LiTok_GetVal(tok)) == "("){
        v = ML_TT_LEFTP;
    } else if _ML_LEX_IsFunction(parser, tok, -1) {
        v = ML_TT_FUNCTION;
    } else if (_ML_LEX_IsUnoper(parser, tok, -1)) {
        v = ML_TT_UNARY;
    } else if _ML_LEX_IsVariable(parser, tok, -1) {
        v = ML_TT_VARIABLE;
    } else if _ML_LEX_IsValue(tok, -1 ){
        v = ML_TT_VALUE;
    } else {
        v = ML_TT_UNKNOWN;
    }
    _ML_LEX_TokenSetType(parser, tok, v);
    
    if (!ML_NoException(parser)) return tokenlist;
    //middle tokens
    prevtok = tok;
    for (i = 1; i < s; ++i) {
        tok = ds_list_find_value(tokenlist, i);
        if (string(_ML_LiTok_GetVal(tok)) == ";") {
            v = ML_TT_EXPRTERMINATOR;
        } else if (string(_ML_LiTok_GetVal(tok))  == ",") {
            v = ML_TT_COMMA;
        } else if (string(_ML_LiTok_GetVal(tok)) == "("){
            v = ML_TT_LEFTP;
        } else if (string(_ML_LiTok_GetVal(tok)) == ")") {
            v = ML_TT_RIGHTP;
        }else if _ML_LEX_IsFunction(parser, tok, prevtok) {
            v = ML_TT_FUNCTION;
        } else if _ML_LEX_IsVariable(parser, tok, prevtok) {
            v = ML_TT_VARIABLE;
        } else if _ML_LEX_IsValue(tok, prevtok){
            v = ML_TT_VALUE;
        } else if (_ML_LEX_IsBinoper(parser, tok, prevtok)) {
            v = ML_TT_BINARY;    
        } else if (_ML_LEX_IsUnoper(parser, tok, prevtok)) {
            v = ML_TT_UNARY;
        } else if (_ML_LEX_IsAssignoper(parser, tok, prevtok)) {
            v = ML_TT_ASSIGN;
        } else if (_ML_LEX_IsTernOper(parser, tok, prevtok)) {
            v = ML_TT_TERNARY1;
        } else if (_ML_LEX_IsTernOper2(parser, tok, prevtok)) {
            v = ML_TT_TERNARY2
        } else {
            v = ML_TT_UNKNOWN;
        }
        _ML_LEX_TokenSetType(parser, tok, v);
        if (!ML_NoException(parser)) return tokenlist;
        prevtok = tok;
    }
}
return true;
