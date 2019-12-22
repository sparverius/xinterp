
#include "./../HATS/x.hats"

#staload "{$XJSON}/SATS/json.sats"

#staload "./interp0.sats"

fun jsonize_ir0val: jsonize_type(ir0val)
fun jsonize_ir0valist: jsonize_type(ir0valist)
overload jsonize with jsonize_ir0val
overload jsonize with jsonize_ir0valist

fun
jsonize_ir0lftval: jsonize_type ir0lftval
overload jsonize with jsonize_ir0lftval
