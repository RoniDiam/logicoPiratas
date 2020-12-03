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

caracterizar(Banda1, Ciudad, terrorDeLaCiudad):-
    forall(viaje(_, _, _, NombreCamion), asaltaExitosamente(Banda1, NombreCamion)),
    not(forall(viaje(_, _, _, NombreCamion), asaltaExitosamente(Banda2, NombreCamion))),
    Banda1 \= Banda2.


caracterizar(Banda, Ciudad, exentrica):-
    banda(Banda, _, _),
    not(asola(Banda, _, _)).

% PUNTO 4

ciudad(buenosAires).
banda(laBandaDeCABA, 10, 2).
caracterizar(laBandaDeCABA, buenosAires, terrorDeLaCiudad).
asaltaExitosamente(laBandaDeCABA, elRapido).
viaje(buenosAires, salta, 2434, elRapido).
viaje(jujuy, buenosAires, 2444534, elRapido).


caracterizar(Banda, Ciudad, exentrica)


% PUNTO 6
% Se puede ver claramente el polimorfismo en camion(NombreCamion, TipoCamion). 
% ya que TipoCamion eso lo entienden los distintos tipos de camion(comun, semiremolque, acoplado).
