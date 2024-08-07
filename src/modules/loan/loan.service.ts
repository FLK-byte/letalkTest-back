import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma.service';
import { UserService } from '../user/user.service';
import { loanDTO } from './dto/loan.dto';

@Injectable()
export class LoanService {
    constructor(private prisma: PrismaService, private UserService: UserService) { }
    async getAllLoans(): Promise<any> {
        return await this.prisma.user.findMany({
            include: { UserLoan: true }
        });
    }
    async createLoans(data: loanDTO): Promise<any> {
        try {
            let user = await this.UserService.findOne(data.userInfo.cpf);
            if (user?.UserLoan?.length > 0) throw new Error('Usuario já possui emprestimo')
            if (!user) user = await this.UserService.create(data.userInfo);

            await Promise.all(data.loansInfo.map(async (loan) => {
                try {
                    await this.prisma.userLoans.create({
                        data: {
                            ...loan,
                            userId: user.id
                        }
                    });
                } catch (e) {
                    console.log(e)
                    throw new Error("Erro ao criar empréstimo");
                }
            }))

            const loans = await this.prisma.userLoans.findMany({
                where: {
                    userId: user.id
                }
            });

            if (loans.length == 0) throw new Error('Erro ao criar emprestimo');
            return loans
        }
        catch (e) {
            console.log(e)
            throw new Error(e);
        }
    }
}
