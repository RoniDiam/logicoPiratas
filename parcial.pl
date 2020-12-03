% ciudad(nombre).
% viaje(ciudadOrigen, ciudadDestino, valor, NombreCamion).
% banda(nombre, cantIntegrantes, cantArmas).
% camion(NombreCamion, TipoCamion).


indiceSeguridad(seguritas, 5).
camion(elRapido, acoplado(2,3, seguritas).

% PUNTO 1
asaltaExitosamente(Banda, NombreCamion):-
        viaje(_,_,Botin,NombreCamion), % El camion esta haciendo un viaje 
        dificultad(NombreCamion, DificultadCamion),
        fuerza(Banda, Fuerza),
        Fuerza > Dificultad.

fuerza(Banda, Fuerza):-
    banda(Banda, CantIntegrantes, CantArmas),
    Fuerza is (CantIntegrantes + 2 * CantArmas).

dificultad(NombreCamion, DificultadCamion):-
    camion(NombreCamion, comun(CantCarga)),
    DificultadCamion is CantCarga / 10.

dificultad(NombreCamion, DificultadCamion):-
    camion(NombreCamion, semiremolque(LargoRemolque, CantChoferes)),
    DificultadCamion is LargoRemolque * CantChoferes.

dificultad(NombreCamion, DificultadCamion):-
    camion(NombreCamion, acoplado(CapacidadCaja, CapacidadAcoplado, _(Indice))),
    indiceSeguridad(NombreEmpresa, IndiceSeguridad),
    DificultadCamion is ((CapacidadCaja + CapacidadAcoplado) * Indice).


% PUNTO 2
asola(Banda, Ciudad, BotinTotal):-
    banda(Banda, _, _),
    ciudad(Ciudad),
    findall(Botin, (camionPasaPorCiudad(Camion, Ciudad), asaltaExitosamente(Banda, Camion, Botin)), Botines),
    sumlist(Botines, BotinTotal).
   
   camionPasaPorCiudad(Camion, Ciudad):- viaje(Ciudad, _, _, Camion).
   camionPasaPorCiudad(Camion, Ciudad):- viaje(_, Ciudad, _, Camion).


% PUNTO 3
caracterizar(Banda, Ciudad, decadente):-
    banda(Banda, CantIntegrantes, _),
    forall(tipo(NombreCamion, _), not(asaltaExitosamente(Banda, NombreCamion))),
    CantIntegrantes < 10.

caracterizar(Banda, Ciudad, terrorDeLaCiudad):-
    banda(Banda, _, _),
    ciudad(Ciudad),
    forall(camionPasaPorCiudad(Camion, Ciudad), unicoAsaltante(Banda, Camion)).
   
   unicoAsaltante(Banda, Camion):-
    asaltaExitosamente(Banda, Camion, _),
    not(asaltaExitosamente(OtraBanda, Camion, _), Banda \= OtraBanda).


caracterizar(Banda, Ciudad, exentrica):-
    banda(Banda, _, CantArmas),
    not(asola(Banda, _, _)),
    CantArmas > 7.

% PUNTO 4

ciudad(buenosAires).
banda(laBandaDeCABA, 10, 2).
viaje(buenosAires, salta, 2434, elRapido).
viaje(jujuy, buenosAires, 2444534, elRapido).

ciudad(sanLuis).
banda(barraBrava, 5, 12).
caracterizar(barraBrava, sanLuis, exentrica).



% PUNTO 5
% El predicado caracterizar es inversible ya que me traigo de los predicados banda o de ciudad por ejemplo para 
% luego usarlos en el forall o en el not.
%

% PUNTO 6
% Se puede ver claramente el polimorfismo en caracterizar ya que caracterizar lo entienden 
