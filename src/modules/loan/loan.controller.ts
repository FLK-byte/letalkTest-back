import { Body, Controller, Get, Post } from '@nestjs/common';
import { LoanService } from './loan.service';
import { loanDTO } from './dto/loan.dto';

@Controller('/loans')
export class LoanController {
    constructor(private loanService: LoanService) { }

    @Get()
    getAllLoans() {
        return this.loanService.getAllLoans();
    }

    @Post()
    createLoans(@Body() postData: loanDTO) {
        return this.loanService.createLoans(postData);
    }
}
