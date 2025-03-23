enum PieceType { worker, generator, gun, tank, mech }

enum PieceColor { white, black }

enum ActionType { move, attack, build }

const int boardSize = 9;

//Power drain from running
int energyCostWorker = 1;
int energyCostTank = 2;
int energyCostGun = 1;
int energyCostMech = 4;

//Power drain for actions
int energyCostBuild = 2;
int energyCostAttack = 2;
int energyCostMove = 1;

int energyGenerationGenerator = 2;

//Starting state of platers
int initialEnergy = 2;
