% ciudad(nombre).
% viaje(ciudadOrigen, ciudadDestino, valor, camion).
% banda(nombre, cantIntegrantes, cantArmas).
% camion(NombreCamion, TipoCamion).

% PUNTO 1
asaltaExitosamente(Banda, Camion):-
        viaje(_,_,_,Camion), % El camion esta haciendo un viaje 
        dificultad(Camion, DificultadCamion),
        fuerza(Banda, Fuerza),
        Fuerza > Dificultad.

fuerza(Banda, Fuerza):-
    banda(Banda, CantIntegrantes, CantArmas),
    Fuerza is (CantIntegrantes + 2 * CantArmas).

dificultad(Camion, DificultadCamion):-
    camion(Camion, comun(CantCarga)),
    DificultadCamion is CantCarga / 10.

dificultad(Camion, DificultadCamion):-
    camion(Camion, semiremolque(LargoRemolque, CantChoferes)),
    DificultadCamion is LargoRemolque * CantChoferes.

dificultad(Camion, DificultadCamion):-
    camion(Camion, acoplado(CapacidadCaja, CapacidadAcoplado, _(Indice))),
    DificultadCamion is ((CapacidadCaja + CapacidadAcoplado) * Indice).

% PUNTO 2
obtenerBotin(Banda, Ciudad):-
    findall(CamionesAsaltados, asaltaExitosamente(Banda, CamionesAsaltados), Lista),
    viaje(_, _, valor, Lista).



% PUNTO 3
caracterizar(Banda, decadente):-
    banda(_, CantIntegrantes, _),
    forall(tipo(Camion, _), not(asaltaExitosamente(Banda, Camion))),
    CantIntegrantes < 10.

caracterizar(Banda, terrorDeLaCiudad):-
    banda(_, CantIntegrantes, _),
    forall(tipo(Camion, _), not(asaltaExitosamente(Banda, Camion))),
    CantIntegrantes < 10.
