#include
"share/atspre_staload.hats"
#staload
UN = "prelude/SATS/unsafe.sats"
//
(* ****** ****** *)

#include
"./../HATS/libxatsopt.hats"
#include
"./../HATS/libxjsonize.hats"

(* ****** ****** *)

#staload "./../SATS/interp0.sats"
#staload "./../SATS/interp0_jsonize.sats"

#staload "./../SATS/intrep0.sats"
#staload "./../SATS/intrep0_jsonize.sats"


#staload "./interp0_envmap.dats"
#staload _ = "./interp0_envmap.dats"

#staload _ = "./intrep0_jsonize.dats"
//
(* ****** ****** *)
//
implement
jsonize_val<ir0val> = jsonize_ir0val
implement
jsonize_val<ir0arg> = jsonize_ir0arg
implement
jsonize_val<ir0exp> = jsonize_ir0exp
//

implement jsonize_ir0valist(x) =
  jsonize_list_named<ir0val>("ir0valist", x)

(* ****** ****** *)
//
implement
jsonize_ir0val(x0) =
node("ir0val", res) where
val res =
(
case+ x0 of
//
| IR0Vnil() =>
  jsonify("IR0Vnil")
//
| IR0Vint(i0) =>
  jsonify("IR0Vint", jsonize(i0))
| IR0Vptr(ptr) =>
  jsonify("IR0Vptr", jsonize("...ptr..."))
| IR0Vbtf(b0) =>
  jsonify("IR0Vbtf", jsonize(b0))
| IR0Vchr(c0) =>
  jsonify("IR0Vchr", jsonize(c0))
| IR0Vflt(f0) =>
  jsonify("IR0Vflt", jsonize(f0))
| IR0Vstr(s0) =>
  jsonify("IR0Vstr", jsonize(s0))
//
| IR0Vlft(x0) =>
  jsonify("IR0Vlft", jsonize(x0))
//
| IR0Vcon(d2c, arg) =>
  jsonify("IR0Vcon", jsonize(d2c), jsonize(arg))
//
| IR0Vfun(fopr) =>
  jsonify("IR0Vfun", jsonize("..."))
    (* jsonize_val<(ir0valist -<cloref1> ir0val)>(fopr) *)
//
| IR0Vtuple(knd, irvs) =>
  jsonify("IR0Vtuple", jsonize(knd), jsonize(irvs))
//
| IR0Vlam(fenv, iras, ire1) =>
  jsonify("IR0Vlam", jsonize("..."),
    jsonize(iras),
    jsonize(ire1)
  )
| IR0Vfix(fenv, d2v0, iras, ire1) =>
  jsonify("IR0Vfix",
    jsonize("fenv"),
    jsonize(d2v0),
    jsonize(iras),
    jsonize(ire1)
  )
| IR0Vfixs(fenv, d2v0, iras, ire1, ires) =>
  jsonify("IR0Vfixs",
    jsonize("fenv"),
    jsonize(d2v0),
    jsonize(iras),
    jsonize(ire1),
    jsonize(ires)
  )
//
| IR0Vlazy(irlz) =>
  tagged("IR0Vlazy", "...")
| IR0Vllazy(_, _, _) =>
  tagged("IR0Vllazy", "...")
//
| IR0Vnone0() =>
  jsonify("IR0Vnone0")
| IR0Vnone1(ire1) =>
  jsonify("IR0Vnone1", jsonize(ire1))
//
) : labjsonval
end (* end of [jsonize_ir0val] *)
//
(* ****** ****** *)
//
implement
jsonize_ir0lftval
  (x0) =
node("ir0lftval", res) where
val res =
(
case+ x0 of
| IR0LVref(r0) =>
  jsonify("IR0LVref", jsonize("..."))
  (* where val _ = $showtype(ref_get_ptr(r0)) end *)
(*
| IR0LVproj(x1, lab, idx) =>
  jsonify("IR0LVproj", jsonize(x1), jsonize(lab), jsonize(idx))
*)
| IR0LVpcon
  (x1, lab) =>
  jsonify("IR0LVpcon", jsonize(x1), jsonize(lab))
//
| IR0LVpbox
  (x1, lab, idx) =>
  jsonify("IR0LVpbox", jsonize(x1), jsonize(lab), jsonize(idx))
| IR0LVpflt
  (x1, lab, idx) =>
  jsonify("IR0LVpflt", jsonize(x1), jsonize(lab), jsonize(idx))

) : labjsonval
end
//
(* ****** ****** *)

(* end of [xint_interp0_jsonize.dats] *)
