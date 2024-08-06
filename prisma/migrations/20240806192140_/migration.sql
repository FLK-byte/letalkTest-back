-- CreateTable
CREATE TABLE "User" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "cpf" TEXT NOT NULL,
    "bornDate" DATETIME NOT NULL,
    "uf" TEXT NOT NULL,
    "loanValue" INTEGER NOT NULL,
    "valueTopayPerMonth" INTEGER NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "UserLoans" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" INTEGER NOT NULL,
    "alreadyPaid" BOOLEAN NOT NULL DEFAULT false,
    "balanceToPay" INTEGER NOT NULL,
    "interest" INTEGER NOT NULL,
    "adjustedBalanceToPay" INTEGER NOT NULL,
    "portionValue" INTEGER NOT NULL,
    "monthToPay" DATETIME NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "UserLoans_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "User_cpf_key" ON "User"("cpf");
