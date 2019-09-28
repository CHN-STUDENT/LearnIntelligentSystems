% One Hundred Years of Solitude 's family tree in Prolog
% Wiki picture: https://en.wikipedia.org/wiki/One_Hundred_Years_of_Solitude#/media/File:One_Hundred_Years_Of_Solitude_Buendia%27s_Family_Tree.svg
% Author : GuoZhiHong
% Class : IoT1603
% StudentID : 201616070320


% See here:https://codereview.stackexchange.com/questions/143116/family-tree-in-prolog

% predicate(X,Y) means "X is Y 's XXX ."
% eg. father(X,Y) means "X is Y 's father."

:- encoding(utf8).
:- discontiguous man/1, woman/1, marry/2,amorousAffairsy/2,parent/2,father/2,mother/2,child/2,illegitimateChild/2.

% Generation I
man('José Arcadio Buendía').
woman('Úrsula Iguarán').

marry('José Arcadio Buendía','Úrsula Iguarán').

% Generation II
man('José Arcadio').
man('Colonel Aureliano Buendía').
woman('Amaranta').
woman('Remedios Moscote').
woman('Rebeca').
woman('Pilar Ternera').

parent('José Arcadio Buendía','José Arcadio').
parent('José Arcadio Buendía','Colonel Aureliano Buendía').
parent('José Arcadio Buendía','Amaranta').
parent('Úrsula Iguarán','José Arcadio').
parent('Úrsula Iguarán','Colonel Aureliano Buendía').
parent('Úrsula Iguarán','Amaranta').
marry('Colonel Aureliano Buendía','Remedios Moscote').
marry('Rebeca','José Arcadio').
amorousAffairsy('Pilar Ternera','José Arcadio').
amorousAffairsy('Pilar Ternera','Colonel Aureliano Buendía').

% Generation III
woman('Aureliano José').
woman('Arcadio').
man('Santa Sofía de la Piedad').

marry('Santa Sofía de la Piedad','Arcadio').
illegitimateChild('17 sons by unknown women','Colonel Aureliano Buendía').
parent('Pilar Ternera','Arcadio').
parent('José Arcadio Buendía','Arcadio').
% Generation IV
woman('Remedios the Beauty').
man('José Arcadio II').
man('Aureliano II').
woman('Petra Cotes').
woman('Fernanda del Carpio').

marry('Aureliano II','Fernanda del Carpio').
amorousAffairsy('Petra Cotes','Aureliano II').
parent('Santa Sofía de la Piedad','Remedios the Beauty').
parent('Santa Sofía de la Piedad','José Arcadio II').
parent('Santa Sofía de la Piedad','Aureliano II').
parent('Arcadio','Remedios the Beauty').
parent('Arcadio','José Arcadio II').
parent('Arcadio','Aureliano II').
% Generation V
man('Gastón').
man('José Arcadio').
man('Mauricio Babilonia').
woman('Amaranta Úrsula').
woman('Renata Remedios').

marry('Amaranta Úrsula','Gastón').
amorousAffairsy('Renata Remedios','Mauricio Babilonia').
parent('Aureliano II','Amaranta Úrsula').
parent('Aureliano II','José Arcadio').
parent('Aureliano II','Renata Remedios').
parent('Fernanda del Carpio','Amaranta Úrsula').
parent('Fernanda del Carpio','José Arcadio').
parent('Fernanda del Carpio','Renata Remedios').
% Generation VI
man('Aureliano Babilonia').
parent('Mauricio Babilonia','Aureliano Babilonia').
parent('Renata Remedios','Aureliano Babilonia').

amorousAffairsy('Amaranta Úrsula','Aureliano Babilonia').
% Generation VII
man('Aureliano').
parent('Aureliano Babilonia','Aureliano').
parent('Amaranta Úrsula','Aureliano').

% --------  Start defining the relationships -------- 

marry(Y,X) :- marry(X,Y).

father(X,Y) :- parent(X,Y), man(X), X\=Y.
mother(X,Y) :- parent(X,Y), woman(X), X\=Y.
%parent(X,Y) :- father(X,Y); mother(X,Y).
parents(X,Y,Z) :- (father(X,Z), mother(Y,Z)); (father(Y,Z), mother(X,Z)), X\=Y, X\=Z, Z\=Y.
couple(X,Y) :- marry(X,Y), X\=Y. 
couple(Y,X) :- marry(X,Y), X\=Y.
amorousAffairsy(X,Y) :- amorousAffairsy(X,Y), amorousAffairsy(Y,X), X\=Y.
child(X,Y) :- (father(Y,X); mother(Y,X)), X\=Y.
illegitimateChild(X,Y) :- illegitimateChild(X,Y), X\=Y.
son(X,Y) :- child(X,Y), man(X), X\=Y.
daughter(X,Y) :- child(X,Y), woman(X), X\=Y.

grandma(X,Y) :- (mother(X,W), mother(W,Y)); (father(X,W), mother(W,Y)), X\=Y.
grandpa(X,Y) :- (father(X,W), father(W,Y)); (mother(X,W), father(W,Y)), X\=Y.
grandparents(X,Y,Z) :- (grandma(X,Z), grandpa(Y,Z)); (grandma(Y,Z), grandpa(X,Z)), X\=Y, X\=Z, Z\=Y.

siblings(A,B) :- father(F,A), father(F,B), mother(M,A), mother(M,B), A\=B.
%siblings(B,A) :- father(F,A), father(F,B), mother(M,A), mother(M,B), A\=B.
uncle(U,N) :- man(U), ((siblings(U,M), father(M,N)); (siblings(U,F), mother(F,N))), U\=N.
aunt(U,N) :- woman(U), ((siblings(U,M), father(M,N)); (siblings(U,F), mother(F,N))), U\=N.

sister(X,Y) :- siblings(X,Y), woman(X), X\=Y.
brother(X,Y) :- siblings(X,Y), man(X), X\=Y.
%brother(Y,X) :- siblings(X,Y), man(X), man(Y), X\=Y.


ancestor(X,Y):- parent(X,Y), X\=Y.
ancestor(X,Y):- parent(X,Z), ancestor(Z,Y).

% --------  End defining the relationships -------- 