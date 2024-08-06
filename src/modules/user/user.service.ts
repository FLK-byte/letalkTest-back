import { Injectable, UseFilters } from '@nestjs/common';
import { CustomExceptionFilter } from 'src/filters/customExceptionFilter';
import { PrismaService } from 'src/prisma.service';

@Injectable()
export class UserService {
    constructor(private readonly prisma: PrismaService) { }

    @UseFilters(CustomExceptionFilter)
    async create(data: {
        cpf: string,
        uf: string,
        bornDate: string,
        valueToLoan: number,
        valueToPayPerMonth: number
    }
    ): Promise<any> {
        try {
            const user = await this.prisma.user.findUnique({
                where: {
                    cpf: data.cpf
                }
            })
            if (user) throw new Error('Usuario já cadastrado');
            return await this.prisma.user.create({ data });
        } catch (e) {
            console.log(e)
            throw new Error('Erro ao criar o usuario');
        }
    }

    async findOne(cpf: string): Promise<any> {
        return await this.prisma.user.findUnique({
            where: {
                cpf
            },
            include: { UserLoan: true }
        });
    }
}
