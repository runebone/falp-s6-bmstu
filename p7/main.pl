phone_book_record(фамилия0, 00000000000, address(город0, улица0, 0, 0)).
phone_book_record(фамилия0, 10000000000, address(город0, улица0, 0, 0)).
phone_book_record(фамилия0, 20000000000, address(город0, улица0, 0, 0)).
phone_book_record(фамилия1, 00000000001, address(город0, улица1, 1, 1)).
phone_book_record(фамилия1, 10000000001, address(город0, улица1, 1, 1)).
phone_book_record(фамилия1, 20000000001, address(город1, улица1, 1, 1)).
phone_book_record(фамилия2, 00000000002, address(город2, улица2, 2, 2)).
phone_book_record(фамилия3, 00000000003, address(город3, улица3, 3, 3)).

car_record(фамилия0, марка0, цвет0, 0000000, но000мер).
car_record(фамилия0, марка1, цвет1, 0000001, но001мер).
car_record(фамилия0, марка2, цвет2, 0000002, но002мер).
car_record(фамилия1, марка1, цвет3, 0000003, но003мер).
car_record(фамилия1, марка2, цвет3, 0000004, но004мер).
car_record(фамилия2, марка3, цвет4, 0000005, но005мер).

phone_book_record(Surname, Phone, address(City, _, _, _)), car_record(Surname, марка3, цвет4, _, _).
