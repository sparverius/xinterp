
#include "./../HATS/x.hats"

#staload "{$XJSON}/SATS/json.sats"

#staload "./intrep0.sats"

fun jsonize_ir0pat : jsonize_type(ir0pat)
fun jsonize_ir0patlst : jsonize_type(ir0patlst)
overload jsonize with jsonize_ir0pat
overload jsonize with jsonize_ir0patlst

fun jsonize_ir0arg : jsonize_type(ir0arg)
fun jsonize_ir0arglst : jsonize_type(ir0arglst)
overload jsonize with jsonize_ir0arg
overload jsonize with jsonize_ir0arglst

fun jsonize_ir0exp : jsonize_type(ir0exp)
fun jsonize_ir0explst : jsonize_type(ir0explst)
fun jsonize_ir0expopt : jsonize_type(ir0expopt)
overload jsonize with jsonize_ir0exp
overload jsonize with jsonize_ir0explst
overload jsonize with jsonize_ir0expopt

fun jsonize_ir0gua : jsonize_type(ir0gua)
fun jsonize_ir0gualst : jsonize_type(ir0gualst)
overload jsonize with jsonize_ir0gua
overload jsonize with jsonize_ir0gualst

fun jsonize_ir0clau : jsonize_type(ir0clau)
fun jsonize_ir0claulst : jsonize_type(ir0claulst)
overload jsonize with jsonize_ir0clau
overload jsonize with jsonize_ir0claulst

fun jsonize_ir0gpat : jsonize_type(ir0gpat)
overload jsonize with jsonize_ir0gpat

fun jsonize_ir0vardecl : jsonize_type(ir0vardecl)
fun jsonize_ir0vardeclist : jsonize_type(ir0vardeclist)
overload jsonize with jsonize_ir0vardecl
overload jsonize with jsonize_ir0vardeclist

fun jsonize_ir0valdecl : jsonize_type(ir0valdecl)
fun jsonize_ir0valdeclist : jsonize_type(ir0valdeclist)
overload jsonize with jsonize_ir0valdecl
overload jsonize with jsonize_ir0valdeclist

fun jsonize_ir0fundecl : jsonize_type(ir0fundecl)
fun jsonize_ir0fundeclist : jsonize_type(ir0fundeclist)
overload jsonize with jsonize_ir0fundecl
overload jsonize with jsonize_ir0fundeclist

fun jsonize_ir0dcl : jsonize_type(ir0dcl)
fun jsonize_ir0dclist : jsonize_type(ir0dclist)
overload jsonize with jsonize_ir0dcl
overload jsonize with jsonize_ir0dclist
