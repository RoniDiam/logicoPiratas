% ciudad(nombre).
% viaje(ciudadOrigen, ciudadDestino, valor, NombreCamion).
% banda(nombre, cantIntegrantes, cantArmas).
% camion(NombreCamion, TipoCamion).


indiceSeguridad(seguritas, 5).
camion(elRapido, acoplado(2,3, seguritas).
camion(tata, comun(1).

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

% y cuando consultas:
% > asaltaExitosamente(laBandaDeCABA, elRapido). => true.
% > caracterizar(laBandaDeCABA, buenosAires, terrorDeLaCiudad). => true.


ciudad(sanLuis).
banda(barraBrava, 5000, 1234344).
viaje(sanLuis, salta, 2, tata).





% PUNTO 5
% Para este punto me gusta analizar un predicado que sea parcialmente inversible para analizarlo en un mismo predicado
% por eso aludo a fuerza() que es un predicado parcialmente inversible. Lo es para un argumento pero no lo es para otro
% El predicado fuerza() es inversible para el segundo argumento porque Banda unifica con el predicado 
% banda() y como el is es inversible para el elemento de la izquierda se puede obtener la Fuerza que 
% valide la consulta.
% Pero no es inversible para el primer argumento porque aunque banda() sí sea inversible y 
% pueda hallarse la Banda que se encuentre en la base de conocimiento, el is no es inversible para 
% el elemento de la derecha, por lo que no se pueden hallar la CantIntegrantes y CantArmas que unifiquen.

% PUNTO 6
% Caracterizar pudiese haber sido polimorfico pero para eso habia que hacerlo con functores