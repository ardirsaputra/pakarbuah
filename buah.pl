:- dynamic(known/3).
:- discontiguous menutanya/3.
:- discontiguous tanya/2.

buah(pisang)        :- warna(kuning),bentuk(sabit).
buah(apel)          :- warna(merah),bentuk(bola).
buah(lemon)         :- warna(kuning),(bentuk(bola);bentuk('bola meruncing')),masam(iya),biji(iya).
buah('jeruk nipis') :- warna(hijau),bentuk(bola),masam(iya),biji(iya).
buah(pir)           :- warna(hijau),bentuk('bola meruncing').
buah(anggur)        :- warna(ungu),bentuk(bola),biji(iya).
buah(jeruk)         :- (warna(hijau);warna(oranye)),bentuk(bola),biji(iya).
buah(ceri)          :- warna(merah),bentuk(bola),biji(iya).
buah(kelengkeng)    :- warna(kuning),bentuk(bola),biji(iya).

% Pengenalan Pakar
warna(X) :- menutanya(warna , X , [merah,hijau,oranye,kuning,ungu]).
bentuk(X) :- menutanya(bentuk, X , [bola,'bola meruncing',sabit]).
masam(X) :- tanya(masam,X).
biji(X) :- tanya(biji,X).

% Mengingat ketika jawabanya benar
tanya(Atribut,Nilai) :- known(iya, Atribut, Nilai), !.
menutanya(Atribut, Nilai,_) :- known(iya,Atribut , Nilai), !.

% Mengingat ketika jawaban salah
tanya(Atribut,Nilai) :- known(_, Atribut, Nilai), !,fail.
menutanya(Atribut, Nilai,_) :- known(_,Atribut , Nilai), !,fail.

% Mengingat Ketika ditanya memiliki perbedaan nilai atribut
tanya(Atribut,Nilai) :- known(iya, Atribut, N), N \== Nilai,!,fail.
menutanya(Atribut, Nilai,_) :- known(iya, Atribut, N), N \== Nilai,!,fail.

tanya(Atribut,Nilai) :- write('Apakah memiliki '),
                        write(Atribut:Nilai),write('? '),
                        read(Jawaban),
                        asserta(known(Jawaban,Atribut,Nilai)),
                        Jawaban == iya.
menutanya(Atribut, Nilai, List) :- write('Apakah '), write(Atribut), write('nya ? '), nl,
                                write(List), nl,
                                read(Jawaban),
                                check_val(Jawaban, Atribut, Nilai, List),
                                asserta(known(iya, Atribut, Jawaban)),
                                Jawaban == Nilai.

check_val(Jawaban, _, _, List) :- member(Jawaban, List), !.
check_val(Jawaban, Atribut, Nilai, List) :- write(Jawaban), write(' tidak dikenali, mohon ulangi lagi ya.'), nl,
                                            menutanya(Atribut, Nilai, List).

jalan :- buah(Buah), write('Buah Itu adalah '),write(Buah),nl.
