/*
  Warnings:

  - You are about to drop the column `loanValue` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `valueTopayPerMonth` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `adjustedBalanceToPay` on the `UserLoans` table. All the data in the column will be lost.
  - You are about to drop the column `balanceToPay` on the `UserLoans` table. All the data in the column will be lost.
  - You are about to drop the column `interest` on the `UserLoans` table. All the data in the column will be lost.
  - You are about to drop the column `portionValue` on the `UserLoans` table. All the data in the column will be lost.
  - Added the required column `valueToLoan` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `valueToPayPerMonth` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `adjustedBalance` to the `UserLoans` table without a default value. This is not possible if the table is not empty.
  - Added the required column `balance` to the `UserLoans` table without a default value. This is not possible if the table is not empty.
  - Added the required column `interestRate` to the `UserLoans` table without a default value. This is not possible if the table is not empty.
  - Added the required column `portion` to the `UserLoans` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_User" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "cpf" TEXT NOT NULL,
    "bornDate" DATETIME NOT NULL,
    "uf" TEXT NOT NULL,
    "valueToLoan" INTEGER NOT NULL,
    "valueToPayPerMonth" INTEGER NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO "new_User" ("bornDate", "cpf", "createdAt", "id", "uf") SELECT "bornDate", "cpf", "createdAt", "id", "uf" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
CREATE UNIQUE INDEX "User_cpf_key" ON "User"("cpf");
CREATE TABLE "new_UserLoans" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" INTEGER NOT NULL,
    "alreadyPaid" BOOLEAN NOT NULL DEFAULT false,
    "balance" INTEGER NOT NULL,
    "interestRate" INTEGER NOT NULL,
    "adjustedBalance" INTEGER NOT NULL,
    "portion" INTEGER NOT NULL,
    "monthToPay" DATETIME NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "UserLoans_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_UserLoans" ("alreadyPaid", "createdAt", "id", "monthToPay", "userId") SELECT "alreadyPaid", "createdAt", "id", "monthToPay", "userId" FROM "UserLoans";
DROP TABLE "UserLoans";
ALTER TABLE "new_UserLoans" RENAME TO "UserLoans";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
