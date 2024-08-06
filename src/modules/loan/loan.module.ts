import { Module } from '@nestjs/common';
import { LoanService } from './loan.service';
import { LoanController } from './loan.controller';
import { PrismaService } from 'src/prisma.service';
import { UserModule } from '../user/user.module';
import { UserService } from '../user/user.service';

@Module({
    imports: [UserModule],
    controllers: [LoanController],
    providers: [LoanService, PrismaService, UserService],
})
export class LoanModule { }
