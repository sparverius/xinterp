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


implement
jsonize_val<filpath> = jsonize_filpath

implement
jsonize_val<ir0pat> = jsonize_ir0pat
implement
jsonize_val<ir0dcl> = jsonize_ir0dcl
implement
jsonize_val<ir0exp> = jsonize_ir0exp
implement
jsonize_val<ir0arg> = jsonize_ir0arg


implement
jsonize_ir0patlst(x) = jsonize_list_named<ir0pat>("ir0patlst", x)
implement
jsonize_ir0dclist(x) = jsonize_list_named<ir0dcl>("ir0dclist", x)
implement
jsonize_ir0explst(x) = jsonize_list_named<ir0exp>("ir0explst", x)
implement
jsonize_ir0expopt(x) = jsonize_option_named<ir0exp>("ir0expopt", x)
implement
jsonize_ir0arglst(x) = jsonize_list_named<ir0arg>("ir0arglst", x)

implement
jsonize_val<ir0fundecl> = jsonize_ir0fundecl
implement
jsonize_val<ir0valdecl> = jsonize_ir0valdecl
implement
jsonize_val<ir0vardecl> = jsonize_ir0vardecl
implement
jsonize_val<ir0clau> = jsonize_ir0clau
implement
jsonize_val<ir0gua> = jsonize_ir0gua


implement
jsonize_ir0valdeclist(x) = jsonize_list_named<ir0valdecl>("ir0valdeclist", x)
implement
jsonize_ir0vardeclist(x) = jsonize_list_named<ir0vardecl>("ir0vardeclist", x)
implement
jsonize_ir0fundeclist(x) = jsonize_list_named<ir0fundecl>("ir0fundeclist", x)

implement
jsonize_ir0claulst(x) = jsonize_list_named<ir0clau>("ir0claulst", x)
implement
jsonize_ir0gualst(x) = jsonize_list_named<ir0gua>("ir0gualst", x)


implement
jsonize_ir0pat
  (x0) =
node("ir0pat", res) where
val res =
(
case+ x0.node() of
//
| IR0Pnil() =>
  jsonify("IR0Pnil")
| IR0Pint(tok) =>
  jsonify("IR0Pint", jsonize(tok))
| IR0Pbtf(tok) =>
  jsonify("IR0Pbtf", jsonize(tok))
//
| IR0Pany() =>
  jsonify("IR0Pany")
| IR0Pvar(d2v) =>
  jsonify("IR0Pvar", jsonize(d2v))
//
| IR0Pcapp(d2c0, irps) =>
  jsonify("IR0Pcapp", jsonize(d2c0), jsonize(irps))
//
| IR0Ptuple(knd, irps) =>
  jsonify("IR0Ptuple", jsonize(knd), jsonize(irps))
//
| IR0Pnone0() =>
  jsonify("IR0Pnone0")
| IR0Pnone1(d3p) =>
  jsonify("IR0Pnone1", jsonize(d3p))
//
| IR0Pflat(d) =>
  jsonify("IR0Pflat", jsonize(d))
| IR0Pfree(d) =>
  jsonify("IR0Pfree", jsonize(d))

) : labjsonval
end  // end of [jsonize_ir0pat]


implement
jsonize_ir0arg
  (x0) =
let
  val+IR0ARGsome(npf, irps) = x0
in
node("ir0arg", res) where
val res =
  jsonify("IR0ARGsome", tagged("npf", npf), jsonize(irps)) : labjsonval
end
end // end of [jsonize_ir0arg]


implement
jsonize_ir0exp(x0) =
node("ir0exp", res) where
val res =
(
case+
x0.node() of
//
| IR0Eint(tok) =>
  jsonify("IR0Eint", jsonize(tok))
| IR0Ebtf(tok) =>
  jsonify("IR0Ebtf", jsonize(tok))
(*
| IR0Eflt(tok) =>
  jsonize("IR0Eflt") //, tok, ")")
*)
| IR0Estr(tok) =>
  jsonify("IR0Estr", jsonize(tok))
//
| IR0Evar(d2v) =>
  jsonify("IR0Evar", jsonize(d2v))
//
| IR0Econ1(d2c) =>
  jsonify("IR0Econ1", jsonize(d2c))

| IR0Ecst1(d2c) =>
  jsonify("IR0Ecst1", jsonize(d2c))
//
| IR0Efcst(d2c) =>
  jsonify("IR0Efst1", jsonize(d2c))
//
| IR0Etcst(d2c1, ti3a, ti2s) =>
  jsonify("IR0Etcst", jsonize(d2c1), jsonize(ti3a), jsonize(ti2s))
  //jsonize_list<ti2arg>("ti2arglst", ti2s))
| IR0Etimp(ire1, targ, irc2, tsub) =>
  jsonify("IR0Etimp",
    jsonize(ire1),
    jsonize(targ), (* jsonize_list<t2ype>("t2ypelst", targ), *)
    jsonize(irc2),
    jsonize(tsub) (* jsonize_list<t2ype>(tsub) *)
  )
//
| IR0Edapp(irf0, npf1, ires) =>
  jsonify("IR0Edapp", jsonize(irf0), tagged("npf", npf1), jsonize(ires))
//
| IR0Eproj(ire1, lab2, idx2) =>
  jsonify("IR0Eproj", jsonize(ire1), jsonize(lab2), jsonize(idx2))
//
| IR0Elet(irds, ire1) =>
  jsonify("IR0Elet", jsonize(irds), jsonize(ire1))
| IR0Ewhere(ire1, irds) =>
  jsonify("IR0Ewhere", jsonize(ire1), jsonize(irds))
//
| IR0Eseqn(ires, ire1) =>
  jsonify("IR0Eseqn", jsonize(ires), jsonize(ire1))
| IR0Etuple(knd0, npf1, ires) =>
  jsonify("IR0Etuple", jsonize(knd0), tagged("npf", npf1), jsonize(ires))
| IR0Eassgn(irel, irer) =>
  jsonify("IR0Eassgn", jsonize(irel), jsonize(irer))
//
| IR0Eif0(ire1, ire2, opt3) =>
  jsonify("IR0Eif0", jsonize(ire1), jsonize(ire2), jsonize(opt3))
//
| IR0Ecase(knd0, ire1, ircls) =>
  jsonify("IR0Ecase", jsonize(knd0), jsonize(ire1), jsonize(ircls))
//
| IR0Elam(knd0, farg, body) =>
  jsonify("IR0Elam", jsonize(knd0), jsonize(farg), jsonize(body))
| IR0Efix(knd0, d2v0, farg, body) =>
  jsonify("IR0Efix", jsonize(knd0), jsonize(d2v0), jsonize(farg), jsonize(body))
//
| IR0Eaddr(ire1) =>
  jsonify("IR0Eaddr", jsonize(ire1))
| IR0Efold(ire1) =>
  jsonify("IR0Efold", jsonize(ire1))
//
| IR0Eeval
  (knd0, ire1) =>
  jsonify("IR0Eeval", jsonize(knd0), jsonize(ire1))
//
| IR0Elazy(ire1) =>
  jsonify("IR0Elazy", jsonize(ire1))
| IR0Ellazy(ire1, opt2) =>
  jsonify("IR0Ellazy", jsonize(ire1), jsonize(opt2))
| IR0Eflat(ire1) =>
  jsonify("IR0Eflat", jsonize(ire1))
| IR0Etalf(ire1) =>
  jsonify("IR0Etalf", jsonize(ire1))
//
| IR0Enone0() =>
  jsonify("IR0Enone0")
| IR0Enone1(d3e1) =>
  jsonify("IR0Enone1", jsonize(d3e1))
//
| IR0Etop(p) =>
  jsonify("IR0Etop", jsonize(p))
| IR0Epcon(p1, p2) =>
  jsonify("IR0Epcon", jsonize(p1), jsonize(p2))
) : labjsonval
end // end of [jsonize_ir0exp]



implement
jsonize_ir0gua
  (x0) =
node("ir0gua", res) where
val res =
(
case+
x0.node() of
| IR0GUAexp(ir0e) =>
  jsonify("IR0GUAexp", jsonize(ir0e))
| IR0GUAmat(ir0e, ir0p) =>
  jsonify("IR0GUAmat", jsonize(ir0e), jsonize(ir0p))
) : labjsonval
end (* end of [jsonize_ir0gua] *)


implement
jsonize_ir0clau
  (x0) =
node("ir0clau", res) where
val res =
(
case+
x0.node() of
//
| IR0CLAUpat(ir0gp) =>
  jsonify("IR0CLAUpat", jsonize(ir0gp))
//
| IR0CLAUexp(ir0gp, d0e0) =>
  jsonify("IR0CLAUpat", jsonize(ir0gp), jsonize(d0e0))
//
) : labjsonval
end (* end of [jsonize_ir0clau] *)



implement
jsonize_ir0gpat
  (x0) =
node("ir0gpat", res) where
val res =
(
case+
x0.node() of
//
| IR0GPATpat(ir0p) =>
  jsonify("IR0GPATpat", jsonize(ir0p))
| IR0GPATgua(ir0p, ir0gs) =>
  jsonify("IR0CLAUpat", jsonize(ir0p), jsonize(ir0gs))
//
) : labjsonval
end (* end of [jsonize_ir0gpat] *)


implement
jsonize_ir0dcl(x0) =
node("ir0dcl", res) where
val res =
(
case+ x0.node() of
//
| IR0Cstatic(tok, irc1) =>
  jsonify("IR0Cstatic", jsonize(tok), jsonize(irc1))
| IR0Cextern(tok, irc1) =>
  jsonify("IR0Cextern", jsonize(tok), jsonize(irc1))
//
| IR0Cinclude(tok, src, knd, fopt, body) =>
  jsonify("IR0Cinclude",
    jsonize(tok),
    jsonize(src),
    jsonize(knd),
    jsonize(fopt),
    jbody
  ) where
    val jbody = (
      case+ body of
      | Some(x) => jsonize(x)
      | None() => jsonify("None")
    ) : labjsonval
    end
//
| IR0Clocal(head, body) =>
  jsonify("IR0Clocal", jsonize(head), jsonize(body))
//
| IR0Cvardecl(knd, mopt, irds) =>
  jsonify("IR0Cvardecl", jsonize(knd), jsonize(mopt), jsonize(irds))
| IR0Cvaldecl(knd, mopt, irds) =>
  jsonify("IR0Cvaldecl", jsonize(knd), jsonize(mopt), jsonize(irds))
//
| IR0Cfundecl(knd, mopt, tqas, irds) =>
  jsonify("IR0Cfundecl",
    jsonize(knd),
    jsonize(mopt),
    jsonize(tqas), (* jsonize_list<tq2arg>(tqas), *)
    jsonize(irds)
  )
//
| IR0Cimpdecl3(knd, mopt, sqas, tqas, id2c, ti3a, ti2s, iras, body) =>
  jsonify("IR0Cimpdecl3",
    jsonize(knd),
    jsonize(mopt),
    jsonize(sqas), (* jsonize_list<sq2arg>(sqas), *)
    jsonize(tqas), (* jsonize_list<tq2arg>(tqas), *)
    jsonize(id2c),
    jsonize(ti3a),
    jsonize(ti2s), (* jsonize_list<ti2arg>(ti2s), *)
    jsonize(iras),
    jsonize(body)
  )
//
| IR0Cnone0() =>
  jsonify("IR0Cnone0")
| IR0Cnone1(d3cl) =>
  jsonify("IR0Cnone1", jsonize(d3cl))
//
) : labjsonval
end // end of [jsonize_ir0dcl]


implement
jsonize_ir0vardecl
  (x0) = let
//
val+IR0VARDECL(rcd) = x0
//
in
node("ir0vardecl", res) where
val res =
  jsonify("IR0VARDECL", jsonize(rcd.d2v), jsonize(rcd.ini)) : labjsonval
end
end // end of [jsonize_ir0vardecl]


implement
jsonize_ir0valdecl
  (x0) = let
//
val+IR0VALDECL(rcd) = x0
//
in
node("ir0valdecl", res) where
val res =
  jsonify("IR0VALDECL", jsonize(rcd.pat),
    (case+ rcd.def of
      | None() => jsonize("None")
      | Some(x) => jsonize(x)
    )) : labjsonval
end
end // end of [jsonize_ir0valdecl]


implement jsonize_val<f2arg> = jsonize_f2arg

implement
jsonize_ir0fundecl
  (x0) = let
//
val+IR0FUNDECL(rcd) = x0
//
in
node("ir0fundecl", res) where
val res =
  jsonify("IR0FUNDECL",
    jsonize(rcd.nam),
    jsonize(rcd.d2c),
    jsonize(rcd.a2g), (* jsonize_list<f2arg>(rcd.a2g), *)
    ja3g,
    jdef
  ) : labjsonval
  where
    val ja3g = (
      case+ rcd.a3g of
      | None() => jsonify("None") //JSONlist(list_nil())
      | Some(x) => jsonize(x)
      (* jsonize_list<f2arg>(rcd.a2g) *)
    ) : labjsonval
    val jdef = (
      case+ rcd.def of
      | None() => jsonify("None")
      | Some(x) => jsonize(x)
      (* jsonize_list<f2arg>(rcd.a2g) *)
    ) : labjsonval
  end
end
end // end of [jsonize_ir0fundecl]
