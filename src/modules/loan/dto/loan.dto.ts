export type loanDTO = {
    userInfo: {
        cpf: string,
        uf: string,
        bornDate: string,
        valueToLoan: number,
        valueToPayPerMonth: number
    },
    loansInfo: [{
        balance: number,
        interestRate: number,
        adjustedBalance: number,
        portion: number,
        monthToPay: Date
    }]
}