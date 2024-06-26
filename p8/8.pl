domains
  name   = symbol.
  city   = symbol.
  street = symbol.
  phone  = symbol.

  address = addr(city, street, integer, integer).

  carmodel = symbol.
  carcolor = symbol.
  carnum   = symbol.

  price = integer.

  bank = symbol.
  bankaccount = integer.
  bankamount = integer.

  /* houseid = symbol. */
  /* landid = symbol. */
  /* boatid = symbol. */

  /* proptype = (car, house, land, boat). */
  proptype = symbol.
  propid = symbol.

	ptlist = proptype*.
	plist = price*.

predicates
  nondeterm phonebook(name, phone, address).
  /* nondeterm car(name, phone, carmodel, carcolor, carnum, price). */
  nondeterm car(name, phone, carmodel, carcolor, propid, price).
  nondeterm is_male(name, phone).
  nondeterm is_child(name, phone, name, phone).
  /* nondeterm is_grandchild(name, phone, name, phone). */
  nondeterm ancestor(name, phone, name, phone).
  /* nondeterm investor(name, phone, bank, bankaccount). */
  nondeterm house(name, phone, price, propid).
  nondeterm land(name, phone, price, propid).
  nondeterm boat(name, phone, price, propid).
  nondeterm property(name, phone, proptype, price, propid).

	nondeterm member(proptype, ptlist).
	nondeterm member(price, plist).
	nondeterm collect_property_types(name, phone, ptlist, ptlist).
	nondeterm collect_property_types(name, phone, ptlist).

	nondeterm collect_property_prices(name, phone, plist, plist).
	nondeterm collect_property_prices(name, phone, plist).

	nondeterm sum(plist, price, price).
	nondeterm sum(plist, price).

	nondeterm networth(name, phone, price)

clauses
  phonebook(abobin,    ph0,  addr(abobTown, abobAv, 0, 0)).
  phonebook(abobina,   ph1,  addr(abobTown, abobAv, 0, 0)).
  phonebook(abobin,    ph2,  addr(abobTown, abobAv, 1, 1)).
  phonebook(vimina,    ph3,  addr(abobTown, abobAv, 1, 1)).
  phonebook(abobina,   ph4,  addr(abobTown, abobAv, 2, 2)).
  phonebook(emacsov,   ph5,  addr(abobTown, abobAv, 2, 2)).
  phonebook(abobin,    ph6,  addr(abobTown, abobAv, 3, 3)).
  phonebook(vSCodina,  ph7,  addr(abobTown, abobAv, 3, 3)).
  phonebook(abobin,    ph8,  addr(abobTown, abobAv, 4, 4)).
  phonebook(rustova,   ph9,  addr(abobTown, abobAv, 4, 4)).
  phonebook(abobina,   ph12, addr(abobTown, abobAv, 4, 4)).
  phonebook(abobina,   ph10, addr(abobTown, abobAv, 5, 5)).
  phonebook(haskellov, ph11, addr(abobTown, abobAv, 5, 5)).
  phonebook(pupkin,    ph13, addr(pupkinTown, pupkinSt, 0, 0)).
  phonebook(pupkina,   ph14, addr(pupkinTown, pupkinSt, 0, 0)).
  phonebook(pupkin,    ph15, addr(pupkinTown, pupkinSt, 1, 1)).
  phonebook(a,         ph16, addr(pupkinTown, pupkinSt, 1, 1)).
  phonebook(pupkin,    ph17, addr(pupkinTown, pupkinSt, 2, 2)).
  phonebook(b,         ph18, addr(pupkinTown, pupkinSt, 2, 2)).
  phonebook(pupkin,    ph19, addr(pupkinTown, pupkinSt, 3, 3)).
  phonebook(c,         ph20, addr(pupkinTown, pupkinSt, 3, 3)).
  phonebook(pupkin,    ph21, addr(pupkinTown, pupkinSt, 3, 3)).
  phonebook(emacsov,   ph22, addr(emacsTown, emacsSt, 0, 0)).
  phonebook(lispova,   ph23, addr(emacsTown, emacsSt, 0, 0)).
  phonebook(emacsova,  ph24, addr(emacsTown, emacsSt, 0, 0)).

  is_male(abobin,    ph0).
  is_male(abobin,    ph2).
  is_male(emacsov,   ph5).
  is_male(abobin,    ph6).
  is_male(abobin,    ph8).
  is_male(haskellov, ph11).
  is_male(pupkin,    ph13).
  is_male(pupkin,    ph15).
  is_male(pupkin,    ph17).
  is_male(pupkin,    ph19).
  is_male(pupkin,    ph21).
  is_male(emacsov,   ph22).

  car(abobin,    ph0,  audi,   black,  num000ber, 4091).
  car(abobina,   ph1,  audi,   red,    num001ber, 4091).
  car(abobin,    ph2,  audi,   black,  num002ber, 4091).
  car(vimina,    ph3,  volvo,  green,  num003ber, 50150).
  car(abobina,   ph4,  audi,   red,    num004ber, 4091).
  car(emacsov,   ph5,  bmw,    purple, num005ber, 896).
  car(abobin,    ph6,  audi,   black,  num006ber, 4091).
  car(vSCodina,  ph7,  tesla,  blue,   num007ber, 73814).
  car(abobin,    ph8,  audi,   black,  num008ber, 4091).
  car(rustova,   ph9,  toyota, orange, num009ber, 702074).
  car(abobina,   ph12, audi,   red,    num012ber, 4091).
  car(abobina,   ph10, audi,   red,    num010ber, 4091).
  car(haskellov, ph11, legs,   purple, num011ber, 1365).
  car(pupkin,    ph13, pupcar, pink,   num013ber, 929).
  car(pupkina,   ph14, pupcar, pink,   num014ber, 929).
  car(pupkin,    ph15, pupcar, pink,   num015ber, 929).
  car(a,         ph16, acar,   acolor, num016ber, 1111).
  car(pupkin,    ph17, pupcar, pink,   num017ber, 929).
  car(b,         ph18, bcar,   bcolor, num018ber, 2222).
  car(pupkin,    ph19, pupcar, pink,   num019ber, 929).
  car(c,         ph20, ccar,   ccolor, num020ber, 3333).
  car(pupkin,    ph21, pupcar, pink,   num021ber, 929).
  car(emacsov,   ph22, bmw,    purple, num022ber, 896).
  car(lispova,   ph23, subaru, lime,   num023ber, 508460).
  car(emacsova,  ph24, bmw,    purple, num024ber, 896).

  house(abobin,    ph0, 1, id1).
  house(abobina,   ph1, 1, id2).
  house(abobin,    ph2, 1, id3).
  house(vimina,    ph3, 0, id4).
  house(abobina,   ph4, 1, id5).
  house(emacsov,   ph5, 6, id6).
  house(abobin,    ph6, 1, id7).
  house(vSCodina,  ph7, 4, id8).
  house(abobin,    ph8, 1, id9).
  house(rustova,   ph9, 4, id10).

  land(abobina,   ph12, 1, id11).
  land(abobina,   ph10, 1, id12).
  land(haskellov, ph11, 5, id13).
  land(pupkin,    ph13, 9, id14).
  land(pupkina,   ph14, 9, id15).
  land(pupkin,    ph15, 9, id16).

  boat(a,         ph16, 1, id17).
  boat(pupkin,    ph17, 9, id18).
  boat(b,         ph18, 2, id19).
  boat(pupkin,    ph19, 9, id20).
  boat(c,         ph20, 3, id21).
  boat(pupkin,    ph21, 9, id22).
  boat(emacsov,   ph22, 6, id23).
  boat(lispova,   ph23, 0, id24).
  boat(emacsova,  ph24, 6, id25).

  is_child(abobin,   ph2,  abobin,  ph0).
  is_child(abobin,   ph2,  abobina, ph1).
  is_child(abobina,  ph4,  abobin,  ph0).
  is_child(abobina,  ph4,  abobina, ph1).
  is_child(abobin,   ph6,  abobin,  ph0).
  is_child(abobin,   ph6,  abobina, ph1).
  is_child(abobin,   ph8,  abobin,  ph2).
  is_child(abobin,   ph8,  vimina,  ph3).
  is_child(abobina,  ph10, abobin,  ph2).
  is_child(abobina,  ph10, vimina,  ph3).
  is_child(abobina,  ph12, abobin,  ph8).
  is_child(abobina,  ph12, rustova, ph9).
  is_child(pupkin,   ph15, pupkin,  ph13).
  is_child(pupkin,   ph15, pupkina, ph14).
  is_child(pupkin,   ph17, pupkin,  ph15).
  is_child(pupkin,   ph17, a,       ph16).
  is_child(pupkin,   ph19, pupkin,  ph17).
  is_child(pupkin,   ph19, b,       ph18).
  is_child(pupkin,   ph21, pupkin,  ph19).
  is_child(pupkin,   ph21, c,       ph20).
  is_child(emacsov,  ph22, emacsov, ph5).
  is_child(emacsov,  ph22, abobina, ph4).
  is_child(emacsova, ph24, emacsov, ph22).
  is_child(emacsova, ph24, lispova, ph23).

  ancestor(X, Xp, Y, Yp)
    :- is_child(Y, Yp, X, Xp).
  ancestor(X, Xp, Y, Yp)
    :- is_child(Z, Zp, X, Xp), ancestor(Z, Zp, Y, Yp).

  /* is_grandchild(Gc, Gcp, Gp, Gpp) */
  /*   :- is_child(Gc, Gcp, P, Pp), is_child(P, Pp, Gp, Gpp). */

  /* property(Name, Phone, car, Price, _) */
  /*   :- car(Name, Phone, _, _, _, Price). */

  property(Name, Phone, car, Price, Id)
    :- car(Name, Phone, _, _, Id, Price).
  property(Name, Phone, house, Price, Id)
    :- house(Name, Phone, Price, Id).
  property(Name, Phone, land, Price, Id)
    :- land(Name, Phone, Price, Id).
  property(Name, Phone, boat, Price, Id)
    :- boat(Name, Phone, Price, Id).

	member(X, [X | _]).
	member(X, [_ | T]) :- member(X, T).

	collect_property_types(Name, Phone, Acc, PropTypes)
		:- property(Name, Phone, PT, _, _),
			not(member(PT, Acc)), !,
			collect_property_types(Name, Phone, [PT|Acc], PropTypes).
	collect_property_types(_, _, PropTypes, PropTypes).
	collect_property_types(Name, Phone, PropTypes)
		:- collect_property_types(Name, Phone, [], PropTypes).

	collect_property_prices(Name, Phone, Acc, Prices)
		:- property(Name, Phone, _, P, _),
			not(member(P, Acc)), !,
			collect_property_prices(Name, Phone, [P|Acc], Prices).
	collect_property_prices(_, _, Prices, Prices).
	collect_property_prices(Name, Phone, Prices)
		:- collect_property_prices(Name, Phone, [], Prices).

	sum([], Acc, Acc).
	sum([H|T], Acc, Res) :- Acc1 = Acc + H, sum(T, Acc1, Res).
	sum(Lst, Res) :- sum(Lst, 0, Res).

	networth(Name, Phone, NW)
		:- collect_property_prices(Name, Phone, Prices),
			sum(Prices, NW).

goal
  /* car(Grandchild, GrandchildPhone, Model, Color, Number, Price), */
  /* is_grandchild(Grandchild, GrandchildPhone, abobina, ph1), */
  /* is_male(Grandchild, GrandchildPhone). */
  /* property(abobin, ph2, Prop, Price, _). */
	networth(abobin, ph2, X).
